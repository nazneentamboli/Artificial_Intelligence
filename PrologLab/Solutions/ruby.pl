/*
Ruby wants to visit a city that is either interesting, or is sunny and inexpensive. 

A city is interesting to Ruby if it contains a heritage site and it has good public transportation.  
Ruby is considering Rome, which is located in Italy, and Suva and Levuka which are both located in Fiji.
The Coliseum is located in Rome, and it is a heritage site.  
Suva also contains a heritage site.
Rome's public transportation is not good, but all cities in Fiji have good 
public transportation.

All cities in Fiji are inexpensive.  
All cities in Italy are expensive.
Suva is sunny, but Levuka is not.  
Your top-level predicate should be vacation(C) which 
*/

vacation(C) :- interesting(C).
vacation(C) :- sunny(C), inexpensive(C).

sunny(suva).

interesting(C) :- heritage(C), transport(C).

located(rome, italy).
located(suva, fiji).
located(levuka, fiji).
located(col, rome).
located(sh, suva).

heritage(col).
heritage(sh).

transport(C) :- located(C, fiji).

inexpensive(C) :- located(C, fiji). 