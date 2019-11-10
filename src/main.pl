start :-
    writeln('Hi'),
    get_facts(F),
    get_questions(Q),
    get_people(P),
    loop_entry(F, Q, P).

loop_entry([], [], People) :-
    write('It can be one of '),
    writeln(People).

loop_entry([F|Facts], [Y|Ys], People) :-
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

filter(Answer, F, People, Result) :-
    (   Answer =:= 1 -> include(F, People, Result)
    ;   Answer =:= 0 -> exclude(F, People, Result)
    ;   Result = People
    ).
