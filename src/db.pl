get_questions(Q) :-
    Q = ['Is it a man?', 'Is your person dead?', 'Has children?', 'Comedian actor?', 'Older than 50', 'Bald?', 'Was/Is a president?', 'Black?'].

get_facts(F) :-
    F = [man, dead, has_children, actor_comedian, older_than_50, bald, was_is_president, black].

man(jim_carrey).
has_children(jim_carrey).
actor_comedian(jim_carrey).
older_than_50(jim_carrey).
man(donald_trump).
has_children(donald_trump).
older_than_50(donald_trump).
was_is_president(donald_trump).
man(barack_obama).
has_children(barack_obama).
older_than_50(barack_obama).
was_is_president(barack_obama).
black(barack_obama).
dead(marilyn_monroe).
man(bruce_willis).
has_children(bruce_willis).
older_than_50(bruce_willis).
bald(bruce_willis).
get_people(P) :-
    P = [jim_carrey, donald_trump, barack_obama, marilyn_monroe, bruce_willis].
