#!/usr/bin/env swipl

:- initialization(main, main).
:- use_module(library(dcg/basics)).

% Define file format: list of integers separated by whitespace.
input( [X|Xs] ) --> integer(X), blanks, input(Xs).
input( [] ) --> [].

% Read file Filename using the format described by input() into Input
input_list(Filename, Input) :-
  phrase_from_file( input( Input ), Filename ).


% Find two numbers in the list that add up to Sum
find_2( [X|Xs], Sum, Answer ) :-
  X =< Sum,
  Y is Sum - X,
  member( Y, Xs ),
  Answer = [X, Y];
  find_2( Xs, Sum, Answer ).

% Call find_2 to find two numbers in the List that add up to Sum, print them and their product.
find_two( List, Sum ) :-
  find_2( List, Sum, [X, Y] ),
  format('The two numbers are ~d and ~d~n', [X, Y]),
  format('The product is ~d~n', [X * Y]).


% Find three numbers in list that add up to Sum
find_3( [X|Xs], S, Answer ) :-
  X < S,
  Y is S - X,
  find_2( Xs, Y, Answer2 ),
  append( [X], Answer2, Answer );
  find_3( Xs, S, Answer ).

% Call find_3 to find three numbers in List that add up to Sum, print them and their product.
find_three( List, Sum ) :-
  find_3( List, Sum, [X, Y, Z] ),
  format( 'The three numbers are ~d, ~d and ~d~n', [X, Y, Z] ),
  format( 'The product is ~d~n', [X * Y * Z] ).


% Read a list of integers from a file and find both a pair of numbers and a triplet of numbers
% that add up to 2020, print them and their product.
main( _Argv ) :-
  input_list( 'input.txt', Input ),
  find_two( Input, 2020 ),
  find_three( Input, 2020 ).
