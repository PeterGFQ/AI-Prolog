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

new_pivoting(H,[],[],[]).
new_pivoting(H,[X|T],[X|L],G) :- \+elder(X,H), new_pivoting(H,T,L,G).
new_pivoting(H,[X|T],L,[X|G]) :- elder(X,H), new_pivoting(H,T,L,G).

new_quick_sort(List,Sorted) :- new_q_sort(List,[],Sorted).
new_q_sort([],Acc,Acc).
new_q_sort([H|T],Acc,Sorted) :-
	new_pivoting(H,T,L1,L2),
	new_q_sort(L1,Acc,Sorted1),new_q_sort(L2,[H|Sorted1],Sorted).

new_succession(Candidates,Sorted_Candidates) :- new_quick_sort(Candidates,Sorted_Candidates).
