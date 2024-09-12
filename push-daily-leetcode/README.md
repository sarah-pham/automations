# push_to_git.zsh
A script to automate pushing a Java solution to the daily Leetcode problem to Git.

# What it does
Creates a new directory within git repository, copies the file `./Solution.java` over to the new directory, and pushes it to git.

The new directory is named in the format: `YYYY-MM-DD_problem-name`. The problem name is extracted from the name of the first method of class Solution in `Solution.java` (modified to kebab case).

## Usage
Run `./push_to_git.zsh`.
