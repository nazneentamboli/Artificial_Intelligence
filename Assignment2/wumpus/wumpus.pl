/**
  THIS COMMENT IS FOR YOUR INFORMATION.
  DELETE THIS COMMENT PRIOR TO HANDING IN YOUR CODE
  
  First test the game by consulting this file, then try the following commands
      *  look.   -- Tells you about your surroundings
	  *  move(north). move(south). move(east). move(west).  -- Moves the agent
      *  pickup(type) -- picks up an object of any liftable type;  initially gold is the only 
	        liftable type.  The agent must be in the same cell as cell containing the object.  
			After picking up the object, the agent is holding the object, and the
			object is no longer contained in the cell.  The agent may hold more than 
			one object, but may not hold more than one object of the same type.

  Now extend the game in the three following ways:

	1.  Showing what the agent is holding  
	2.  Putting down objects
	3.  Winning the game
	4.  Wumpus repellant

1.  The agent can pick up gold, but the game is not
    showing what the agent is holding.  Modify the code
	so the look command also displays the types of the 
	objects the agent is holding.

2.  Implement an action putdown(Type).  The agent must be
	holding an object of that type.  After putting down an 
	object, it is contained in the cell where the agent is located,
	and the agent is no longer holding the object.
	
3.  Winning the game.  If the agent is at (1,1) and is
    holding gold, the agent wins. The look command should 
	display that the agent has won, and having won, 
	the agent can no longer move anywhere.
	
4.  Wumpus Repellent.  Wumpus repellent is an object that
      can be found at various cells.  The agent can pick 
      it up, and if the agent is holding Wumpus Repellent
      and enters a cell with a Wumpus, the wumpus does not
      kill the agent.  However, if the agent puts down 
      the wumpus repellent in a cell containing a Wumpus, 
      the agent then dies. 	The type for these objects must 
	  be wumpus_repellant.
	  
**/

/**

This is how the map and coordinate system works, and
also how the world is configured for this example.

north   -- move to smaller index row
south   -- move to larger index row
west   -- move to smaller index column
east  -- move to larger index column

Coordinate system:  [1,1] is at upper left, order is (row, col)
[1,1]   [1,2]  [1,3]
|-----|------|-------|
|
|  A      
|-----|------|-------|
|         P
|  WR 
|-----|------|-------|
|               
|  W       G
|------|------|------|

**/

% Initial state

:- dynamic(agent_at/1).
:- dynamic(agent_holding/1).
:- dynamic(cell_contains/2).

% Every object except the agent has a type

type(g1, gold).
type(w1, wumpus).
type(p1, pit).

liftable(gold).

size(3).

agent_at((1,1)).
cell_contains((2,2), p1).
cell_contains((3,1), w1).
cell_contains((3,2), g1).

/** Look **/
look :- look_location,
				look_dead, look_stench, look_breeze,
				look_contains.

look_location :- agent_at(P), write('You are at '), 
			write(P), write('\n').

look_contains :- agent_at(P), cell_contains(P, T), 
					type(T, Type), 
					write('There is '), write(Type) , write(' here\n').
look_contains :- !.

look_dead :- dead, write('You are dead!\n'),!.
look_dead :- !.

look_stench :- agent_at(C), adjacent(C, C2), cell_contains(C2, W), type(W, wumpus), 
		write('You smell a stench!\n'), !.
look_stench :- !.

look_breeze :- agent_at(C), adjacent(C, C2), cell_contains(C2, P), type(P, pit), 
		write('You feel a breeze!\n'), !.
look_breeze :- !.

dead :- agent_at(C), cell_contains(C, T), type(T, wumpus), !.
dead :- agent_at(C), cell_contains(C, T), type(T, pit), !.

pickup(Type) :- \+ dead,
	agent_at(C),
	cell_contains(C,T), type(T, Type), liftable(Type),
	retract(cell_contains(C,T)),
	asserta(agent_holding(T)).
	
move(D) :- \+ dead, 
			agent_at(C), 
			cell_toward(C, D, C2), 
			retract(agent_at(C)), 
			asserta(agent_at(C2)).

cell_toward((R, C), south, (R2, C)) :- size(S), R < S, R2 is R + 1.
cell_toward((R, C), north, (R2, C)) :- R > 1, R2 is R - 1.
cell_toward((R, C), east,  (R, C2)) :- size(S), C < S, C2 is C + 1.
cell_toward((R, C), west,  (R, C2)) :- C > 1, C2 is C - 1.

adjacent(C1, C2) :- cell_toward(C1, south, C2).
adjacent(C1, C2) :- cell_toward(C1, north, C2).
adjacent(C1, C2) :- cell_toward(C1, east, C2).
adjacent(C1, C2) :- cell_toward(C1, west, C2).



