/* Facts */
sports([badminton, basketball, boxing, football, golf, hockey, swimming, tennis]).

badminton([court, racket, referee, shuttlecock, doubles, singles, teams_per_game=2]).
basketball([court, ball, referee, basket, scoreline, score, teamsize=5, teams_per_game=2]).
boxing([ring, gloves, timed, referee, score, knockout, teamsize=1, teams_per_game=2]).
football([pitch, penalty, ball, score, captain, referee, goalkeeper, manager, grass,  teamsize=11, teams_per_game=2]).
golf([ball, course, grass, water, sand, caddy, holes, bag, fairway, clubs, score, teamsize=1, teams_per_game=many]).
hockey([court, hockeystick, hockey, referee, score, captain, goalkeeper, teamsize=11, teams_per_game=2]).
swimming([water, pool, timed, referee, swimsuit, goggles, lane, swimcap, teamsize=1, teams_per_game=many]).
tennis([court, score, ball, racket, referee, doubles, singles, net, serve, baseline, ballgirl, ballboy, grass, clay, teams_per_game=2]).

/* Game starts */
startGame() :-
	sports(L),
	initGame(L),
    print('Enter "allSports()." to check all sports.'), nl,
    print('Enter "allOptions()." to check all available guessing options.'), nl,
    print('Enter "has(YourGuessOption)." to guess the specification of sport.'), nl,
    print('Enter "is(YourGuessSport)." to verify your guess.'), nl,
    print('Game started!'), nl,
	guess().

/* restart game anytime */
restartGame() :-
    startGame().

/* Guess the specification of sports */
has(Guess) :-
	selected(Sport),
	getList(Sport, L),
	member(Guess, L),
	print('Yes.'), nl,
	increment(),
	guess();
	
	concatAllFacts(FullList),
	member(Guess, FullList),
	print('No.'), nl,		 
	increment(),
	guess();
	
	print('Invalid option, enter "allOptions()." to check avaiable guessing options'),nl,
	guess().
	
/* Guess the sports */
is(Guess) :-
	selected(X),
	X==Guess,
	print('Yes, it was '),
	print(Guess), nl,
	gameOver();
	
	print('No, it is not '),
	print(Guess), nl,
	increment(), 
	guess().
	
/* Print all options */
allOptions() :-
	concatAllFacts(FullList),
	list_to_set(FullList, S),
	print('All possible options are displayed below : '), nl,
	print(S), nl,
	guess().

/* Print all options */
allSports() :-
    sports(FullList),
    list_to_set(FullList, S),
    print('All sports are displayed below : '), nl,
    print(S), nl,
    guess().


/* Guess process handler */
guess() :-
    checkCounter(),
    read(Input),
    Input;
    
    gameOver().

/* Gameover method for continuing play */
gameOver() :-
	print('Do you want to play again? (y/n)'),
	read(Input),
	restartGame(Input).
	

/* Method to check whether user wants to restart game or not */
restartGame(X) :-
	(X==y, startGame());
	(X==n, abort);
	gameOver().

/* Method to match input with list of sport facts */
getList(X, L) :-
	(X==badminton, badminton(L));
	(X==basketball, basketball(L));
	(X==boxing, boxing(L));
	(X==football, football(L));
	(X==golf, golf(L));
	(X==hockey, hockey(L));
	(X==swimming, swimming(L));
	(X==tennis, tennis(L)).

/* Counter for guessing tries */
increment() :-
	counter(X),
	Y is (X+1),
	retractall(counter(_)),
	assertz(counter(Y)).
		
/* Method to check how many times has user tried */
checkCounter() :-
	counter(X),
	(X<10);
	
	print('You ran out of guesses'), nl,
	print('The answer was '),
	selected(X),
	print(X), nl,
	gameOver().
	

/* Game initialization */
initGame(List) :-
	findnsols(100, X, alreadyPlayed(X), Played),
	subtract(List, Played, Valid),
	Valid\==[],
	random_member(Sport, Valid),
	assert(alreadyPlayed(Sport)),
	retractall(selected(_)),
	assertz(selected(Sport)),
	retractall(counter(_)),
	assertz(counter(0));
	
	print('Congratulations, You have guessed all the sports, well done!'), nl,
	abort.
	

/* Concat all the sports facts into a list */
concatAllFacts(L) :-
	badminton(L1),
	basketball(L2),
	boxing(L3),
	football(L4),
	golf(L5),
	hockey(L6),
	swimming(L7),
	tennis(L8),
	append(L1, L2, L9),
	append(L3, L4, L10),
	append(L5, L6, L11),
	append(L7, L8, L12),
	append(L9, L10, L13),
	append(L11, L12, L14),
	append(L13, L14, L).

alreadyPlayed().
selected(empty).
counter(0).

:- dynamic selected/1. :- dynamic selected/0.
:- dynamic counter/1. :- dynamic counter/0.
:- dynamic alreadyPlayed/1. :- dynamic alreadyPlayed/0.
