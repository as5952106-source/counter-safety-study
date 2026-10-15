# Demonstration thesis: invariant preservation

This is a demonstration topic, not a claim to formalize an existing thesis.

## Research question

Can a simple saturating counter exceed its configured capacity after a finite
sequence of commands, assuming it starts in a safe state?

## Model

State and capacity are natural numbers. Increment saturates at capacity,
decrement saturates at zero, and reset returns zero. A trace is a finite list
of commands interpreted in chronological order. There is no concurrency,
integer overflow, I/O, hardware, or probabilistic behavior in this model.

## Main result

`run_safe` proves that all finite traces preserve `state ≤ capacity` from any
safe starting state. The induction reduces arbitrary trace length to the
one-step lemma `step_safe`. `initial_run_safe` specializes the result to zero.
`run_append` proves compositional trace semantics; `reset_erases_history`
proves that a reset removes dependence on the preceding history.

## Limits and future work

Safety does not imply progress or fairness. The theorem assumes the formal
transition definition, not an independent software implementation. A real
thesis should state its topic, semantics, related work, and correspondence
between this model and its target system before reusing this scaffold.
