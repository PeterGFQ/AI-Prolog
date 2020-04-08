monarch(elizabeth).
prince(charles).
prince(andrew).
prince(edward).
princess(ann).
older(charles,ann).
older(ann,andrew).
older(andrew,edward).

elder(X,Y) :- older(X,Y);
                (older(X,_),older(_,Y)).
old_rank(X,Y) :- (prince(X),princess(Y));
                        (prince(X),prince(Y),elder(X,Y));
                        (princess(X),princess(Y),elder(X,Y)).

pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G) :- \+old_rank(X,H), pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]) :- old_rank(X,H), pivoting(H,T,L,G).

quick_sort(List,Sorted) :- q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted) :-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

old_succession(Candidates,Sorted_Candidates) :- quick_sort(Candidates,Sorted_Candidates).
