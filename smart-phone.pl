competitor(sumsum,appy).
developed(sumsum,galacticas3).
smartphonetech(galacticas3).
steal(stevey,galacticas3).
boss(appy,stevey).

business(X) :- smartphonetech(X).
rival(X,Y) :- competitor(X,Y); competitor(Y,X).
unethical(W) :- boss(X,W), steal(W,Y), rival(X,Z), developed(Z,Y), business(Y).
