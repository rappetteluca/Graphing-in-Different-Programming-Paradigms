:- use_module(library(clpfd)).

%grows checks a list of numbers. Returns the next number in the list if it is larger than the last
%grows fails otherwise.
grows([]).
grows([X, Y]) :- number(X), number(Y), Y > X.
grows([X, Y | T]) :- number(X), number(Y), Y > X, grows([Y|T]).
grows([X, Y | _]) :- Y < X, !, fail.

%Provides the running total of summing over a list of numbers
sumrunner(L, S) :- sumrunner(L, 0, S).
sumrunner([], _, []).
sumrunner([H|T], S0, [S1|T2]) :- S1 #= H + S0, sumrunner(T, S1, T2).

%Describes an edge from X to Y with cost C in a directed graph
edge(X, Y, C) :- edges(X, Y, C).

%Finds all paths from a starting node to a goal node
path(FROM, TO, COST) :- path(FROM, TO, COST, [_|_]). 
path(X, Y, P, [X|Es]) :- path(X, Y, [X], Es, 0, P).
path(X, X, _, [], P, P).
path(X, Y, Visited, [Z|Es], S, P) :- edge(X,Z,W), maplist(dif(Z),Visited), S1 #= S+W, S1 #=< P, path(Z,Y,[Z|Visited],Es, S1, P).
