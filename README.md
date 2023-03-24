# TacitDiff

A library for differentiating tacit BQN expressions in different ways.

Currently supported:
- Symbolic differentiation (by [saltysylvi])
- Tape-based reverse-mode algorithmic differentiation

Planned features:
- Forward-mode algorithmic differentiation
- (Accurate) finite differencing

[saltysylvi]: https://saltysylvi.github.io/blog/bqn-macros.html


## Why do this?
I wanted to learn more about what goes into writing and optimising an autodiff library.
I also wanted to challenge myself to come up with a recursive algorithm for generating and evaluating Wengert lists aka gradient tapes.
BQN is a very designed language and autodiff fits well into its array programming paradigm.
Finally, I just wanted to write something bigger than a few one liners in BQN.
