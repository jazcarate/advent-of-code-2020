# Advent of Code
## 2020 edition
### Crystal

Challenges for advent 2020 in crystal-lang.

All this code was run in [repl.it](https://repl.it), so forking this repo should be enough to run it on your own, with no installation required


## Usage
Evey advent day is in it's own folder in `src/`, and all have the same structure:

1. `main.cr` has the code that does the interesting thing
1. `run.cr` has the code te read the big input and use ☝️
1. Other files as input

And in `spec` there are some tests I wrote down, mostly the ones in text form that the problem provides.

### Commands

- To run all the specs: `$ crystal spec` (or the run button in Repl.it)
- To run a specific challenge: `$ crystal run src/[NUMBER]/run.cr`