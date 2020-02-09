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

For 15 open states/districts or less, all possible szenarios are shown.
Similar szenarios are grouped. Also, states a certain candidate has to win to
win the election are shown as well as states a candidate does not need.

**Usage:** `waystowhitehouse.pl link/to/waystowhitehouse.dat`

## `presprob.pl`

This script calculates a statistical probability for the result of a
presidential election in the US. It consists of the following files:

**`presprob.pl`**: the general executable Perl script file  
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

**Usage:** `presprob.pl link/to/waystowhitehouse.dat`

## `presprob-pc.pl`

This script calculates a statistical probability for the result of a
presidential election in the US. It consists of the following files:

**`presprob-pc.pl`**: the general executable Perl script file  
**`Elections.pm`**: contains subroutines used by the Perl script  
**`statevals.dat`**: contains the current number of electoral votes per
state at-large or congressional district (for ME and NE)  
**`waystowhitehouse.dat`**: is a template file that contains a notifier for
each state at-large or congressional district (for ME & NE)
**`prespercent.dat`**: is a template file containing the probabilities in each state or
congressional district for the Democrats (2nd column) and the Republicans (3rd
column) to win the respective state/district

- "D" if the state or district is won by the democrats or safe for the
  democratic party
- "R" if the state or district is won by the republicans/GOP or safe for the GOP
- "X" if this state is open

This script is not only probabilistic. This means, it contains
if a state or district is more likely to be won by a certain party.

**Usage:** `presprob-pc.pl link/to/waystowhitehouse.dat link/to/prespercent.dat`

## `presprob-hist.pl`

This script calculates a statistical probability for the result of a
presidential election in the US based on the electoral college of a previous election. It consists of the following files:

**`presprob-hist.pl`**: the general executable Perl script file  
**`HistElections.pm`**: contains subroutines used by the Perl script  
**`waystowhitehouse.dat`**: is a template file that contains a notifier for
each state at-large or congressional district (for ME & NE)

- "D" if the state or district is won by the democrats or safe for the
  democratic party
- "R" if the state or district is won by the republicans/GOP or safe for the GOP
- "X" if this state is open

Note that this script is purely probabilistic. This means, it does not contain
if a state or district is more likely to be won by a certain party.

**Usage:** `presprob-hist.pl year link/to/waystowhitehouse.dat`

**Hint:** The year has to be given as a four-digit number that can be divided by 4. The
first presidential election of 1788-1789 is counted as 1788.
