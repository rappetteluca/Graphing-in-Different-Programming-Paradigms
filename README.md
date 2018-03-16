#  Graphing-in-Different-Programming-Paradigms
## CS421

## Author(s):

Lucas Rappette

## Date:

3/16/18


## Description:

- __Path Finding and Graphing in Haskell.hs__ describes graphing functions in Haskell. This is a full library for directed graphs, and should be considered standalone. The Data.List module is a seriously stellar way to pick up this (almost) pure functional programming lanaguage quickly.
- __Path Finding in Prolog.pl__ describes a few list functions and graph functions I made when I was just learning Prolog. The library clpfd is necessary for almost all functions.
	- __grows__ checks a list of numbers. Returns the next number in the list if it is larger than the last. Fails otherwise.
	- __sumrunner__ provides the running total of summing over a list of numbers
	- __edge(X, Y, C)__ describes an edge from X to Y with cost C in a directed graph
	- __path(FROM, TO, COST)__ finds all paths from a starting node to a goal node
- __There is an additional readme for this project, which is the original assignment description.__ This file is called *Graphing in Haskell and Prolog.pdf*.


## How to build the software

Haskell compiles at run-time.

Prolog builds by loading file into SWISH (SWI - Prolog)


## How to use the software

Haskell runs with GHCi.

Prolog runs with SWISH / SWI - Prolog


## How the software was tested

Testing was completed by using outlier-like input arguments in order to stress
test graphing features and functor behavior.


## Known bugs and problem areas

None.