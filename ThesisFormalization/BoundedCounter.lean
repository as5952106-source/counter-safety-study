import Std

/-! Demonstration thesis model: inductive safety of a bounded counter. -/
namespace ThesisFormalization

inductive Command where
  | increment
  | decrement
  | reset
  deriving DecidableEq, Repr

/-- Saturating transitions. Every state is a natural number; capacity is explicit. -/
def step (capacity state : Nat) : Command → Nat
  | .increment => min (state + 1) capacity
  | .decrement => state - 1
  | .reset => 0

/-- A state is safe precisely when it does not exceed capacity. -/
def Safe (capacity state : Nat) : Prop := state ≤ capacity

/-- Every command preserves safety, including capacity zero. -/
theorem step_safe (capacity state : Nat) (cmd : Command) (h : Safe capacity state) :
    Safe capacity (step capacity state cmd) := by
  cases cmd <;> simp [step, Safe] at * <;> omega

/-- Interpret a finite trace in chronological order. -/
def run (capacity : Nat) (state : Nat) : List Command → Nat
  | [] => state
  | cmd :: rest => run capacity (step capacity state cmd) rest

/-- Main safety theorem: arbitrary finite traces preserve the invariant. -/
theorem run_safe (capacity state : Nat) (commands : List Command)
    (h : Safe capacity state) : Safe capacity (run capacity state commands) := by
  induction commands generalizing state with
  | nil => exact h
  | cons cmd rest ih => exact ih _ (step_safe capacity state cmd h)

/-- All finite executions from the designated initial state remain safe. -/
theorem initial_run_safe (capacity : Nat) (commands : List Command) :
    Safe capacity (run capacity 0 commands) :=
  run_safe capacity 0 commands (Nat.zero_le capacity)

/-- Trace composition agrees with sequential execution. -/
theorem run_append (capacity state : Nat) (xs ys : List Command) :
    run capacity state (xs ++ ys) = run capacity (run capacity state xs) ys := by
  induction xs generalizing state with
  | nil => rfl
  | cons cmd rest ih => exact ih (step capacity state cmd)

/-- A reset erases the entire preceding execution history. -/
theorem reset_erases_history (capacity state : Nat) (xs ys : List Command) :
    run capacity state (xs ++ .reset :: ys) = run capacity 0 ys := by
  rw [run_append]
  rfl

end ThesisFormalization
