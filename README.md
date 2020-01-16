# us-election

This repository combines some scripts to calculate probabilities for the result
of general (not statewide) elections in the United States.

## `waystowhitehouse.pl`

This script calculates a statistical probability for the result of a
presidential election in the US. It consists of the following files:

**`waystowhitehouse.pl`**: the general executable Perl script file  
**`Elections.pm`**: contains subroutines used by the Perl script  
**`statevals.dat`**: contains the current number of electoral votes per
state at-large or congressional district (for ME and NE)  
**`waystowhitehouse.dat`**: is a template file that contains a notifier for
each state at-large or congressional district (for ME & NE)

- "D" if the state or district is won by the democrats or safe for the
  democratic party
- "R" if the state or district is won by the republicans/GOP or safe for the GOP
- "X" if this state is open

Note that this script is purely probabilistic. This means, it does not contain
if a state or district is more likely to be won by a certain party.
