import ThesisFormalization
open ThesisFormalization

example : run 0 0 [.increment, .increment, .decrement] = 0 := rfl
example : run 2 0 [.increment, .increment, .increment] = 2 := rfl
example : run 10 0 [.decrement] = 0 := rfl
example : run 3 0 [.increment, .reset, .increment] = 1 := rfl
example (commands : List Command) : Safe 7 (run 7 0 commands) :=
  initial_run_safe 7 commands
example (xs ys : List Command) : run 3 0 (xs ++ .reset :: ys) = run 3 0 ys :=
  reset_erases_history 3 0 xs ys
