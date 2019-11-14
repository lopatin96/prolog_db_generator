% Removing unnecessary questions.

start :-
    writeln('Hi'),
    get_facts(F),
    get_questions(Q),
    get_people(P),
    loop_entry(F, Q, P).

loop_entry([], [], People) :-
    write('It can be one of '),
    writeln(People).

loop_entry(FOld, QOld, People) :-
    find_the_best_question(People, FOld, QOld, [F|Facts], [Y|Ys]),
    writeln(Y),
    read(Answer),  % 1 - Yes; 0 - No; anything else - I don't know
    filter(Answer, F, People, Result),
    length(Result, L),
    (
        L > 1 ->
        loop_entry(Facts, Ys, Result)
        ;
        write('I think it\'s '),
        write(Result)
    ).

find_the_best_question(People, F, Q, FNew, QNew) :-
    estimate(F, People, ER),
    remove_un_q(ER, F, Q, RER, RF, RQ),  % Remove unnecessary questions.
    subtract(2, RER, SR),
    maplist(abs, SR, MR),
    findMin(MR, M),
    indexOf(MR, M, I),
    reorganize(RF, I, FNew),
    reorganize(RQ, I, QNew).

estimate(F, P, R) :-
    estimate_facts(F, P, [], R).

estimate_facts([], P, R, Reversed) :-
    my_reverse(R, Reversed).

estimate_facts([F|Fs], People, Rs, Result) :-
    estimate_fact(F, People, R),
    estimate_facts(Fs, People, [R|Rs], Result).

estimate_fact(Fact, People, Result) :-
    mycount(People, CountOfPeople),
    filter(1, Fact, People, R),
    mycount(R, CountOfFilteredResult),
    (   CountOfFilteredResult =:= 0 -> Result is 0 % then delete this question, because there is no sense to ask about it.
    ;   Result is CountOfPeople / CountOfFilteredResult
    ).

% Reverse a list.
my_reverse(L, R) :- my_reverse(L,[],R).
my_reverse([H],L,[H|L]) :- !.
my_reverse([X|T],L,R) :- my_reverse(T,[X|L],R).

mycount([], 0).
mycount([_|As], TotalCount) :-
    mycount(As, Count),
    TotalCount is Count + 1.

filter(Answer, F, People, Result) :-
    (   Answer =:= 1 -> include(F, People, Result)
    ;   Answer =:= 0 -> exclude(F, People, Result)
    ;   Result = People
    ).

subtract(_, [], []) :- !.
subtract(N, [A|As], [B|R]) :-
    B is N - A,
    subtract(N, As, R).

findMin(L, M) :-
    findMin(L, 9999, M).

findMin([], M, M).
findMin([L|Ls], CurrentM, M) :-
    (
        L <  CurrentM ->
        findMin(Ls, L, M)
        ;
        findMin(Ls, CurrentM, M)
    ).

indexOf([Element|_], Element, 0):- !.
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1),
  !,
  Index is Index1+1.

reorganize(L, N, R) :-
    split(L, N, L1, L2),
    append(L2, L1, R).

% Split a list into two parts; the length of the first part is given.
% split([1,2,3,4], 2, L1, L2).
% L1 = [1, 2],
% L2 = [3, 4]
split(L, 0, [], L).
split([H|T], N, [H|X], L2) :-
        N > 0,
        M is N - 1,
        split(T, M, X, L2).

remove_un_q(List1, List2, List3, R1, R2, R3) :-
    ( indexOf(List1, 0, I) ->
        IncrementedIndex is I + 1,
        away(List1, IncrementedIndex, R1),
        away(List2, IncrementedIndex, R2),
        away(List3, IncrementedIndex, R3)
    ;
        copy(List1, R1),
        copy(List2, R2),
        copy(List3, R3)
    ).

away([G|H], 1, H) :- !.
away([G|H], N, [G|L]) :- N > 1,
    Nn is N - 1, !,
    away(H, Nn, L).

copy(L,R) :- accCp(L,R).

accCp([],[]).
accCp([H|T1],[H|T2]) :-
    accCp(T1,T2).

