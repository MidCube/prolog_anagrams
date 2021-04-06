:- [words].

take([H|T], H, T).
take([H|T], R, [H|S]) :-
    take(T, R, S).

perm([], []).
perm(L, [R|S]) :-
    take(L, R, T),
    perm(T, S).

% different(O1, O2) succeeds if O1 and O2 do not unify (more on negation later!)
different(O1, O2) :-
    O1\=O2.

anagram(Word, Anagram) :-
    word(Word),
    anagram(_,Word,Anagram,[]).

len([],Acc,Acc).
len([_|T],Acc,R):-B is Acc+1,
    len(T,B,R).
len(N,List):-len(List,0,N),!.

anagram(N,Word,Anagram):-
   len(N,Word),
   anagram(N,Word,Anagram,[]).

anagram(N,Word,AnagramOne,AnagramTwo):-
    len(N,Word),
    word(Word),
    split(Word,X,Y),
    perm(X,AnagramOne),
    word(AnagramOne),
    different(Word,AnagramOne),
    perm(Y,AnagramTwo),
    word(AnagramTwo),
    different(Word,AnagramTwo).

split([],[],[]).
split([X|L],[X|L1],L2):-
    split(L,L1,L2).

split([X|L],L1,[X|L2]):-
    split(L,L1,L2).

:- anagram([c,a,t],Anagram), format('~w is an anagram of cat~n',[Anagram]).
:- anagram([s,w,i,n,e],Anagram), format('~w is an anagram of swine~n',[Anagram]).
