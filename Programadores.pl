personas(Persona) :- cumpleElRolDe(Persona, _).
personas(Persona) :- sabeProgramarEn(Persona, _).
lenguajes(Lenguaje) :- sabeProgramarEn(_, Lenguaje).

lenguajes(assembler).

sabeProgramarEn(fernando,cobol).
sabeProgramarEn(fernando,visualbasic).
sabeProgramarEn(fernando,java).
sabeProgramarEn(julieta,java).
sabeProgramarEn(marcos,java).
sabeProgramarEn(santiago,java).
sabeProgramarEn(santiago,ecmascript).

cumpleElRolDe(fernando,analista).
cumpleElRolDe(andres,projectleader).

esProgramador(Alguien):-sabeProgramarEn(Alguien,_).

seProgramaEn(sumatra,java).
seProgramaEn(sumatra,net).
seProgramaEn(prometeus,cobol).

trabajaEn(fernando,prometeus).
trabajaEn(santiago,prometeus).
trabajaEn(julieta,sumatra).
trabajaEn(marcos,sumatra).
trabajaEn(andres,sumatra).

esCompetente(Alguien, _) :- cumpleElRolDe(Alguien,projectleader).
esCompetente(Alguien, _) :- cumpleElRolDe(Alguien,analista).
esCompetente(Alguien, Proyecto) :- seProgramaEn(Proyecto,Lenguaje),
				 sabeProgramarEn(Alguien,Lenguaje).

estaBienAsignado(Alguien,Proyecto):- 
	trabajaEn(Alguien,Proyecto),
	esCompetente(Alguien, Proyecto).
%estaBienAsignado(Alguien,Proyecto):- trabajaEn(Alguien,Proyecto),seProgramaEn(Proyecto,Lenguaje),
%sabeProgramarEn(Alguien,Lenguaje).
%estaBienAsignado(Alguien,Proyecto):-trabajaEn(Alguien,Proyecto),cumpleElRolDe(Alguien,analista).
%estaBienAsignado(Alguien,Proyecto):-trabajaEn(Alguien,Proyecto),cumpleElRolDe(Alguien,projectleader).

proyecto(Proyecto):- seProgramaEn(Proyecto,_).

esLider(Lider,Proyecto) :- trabajaEn(Lider,Proyecto), cumpleElRolDe(Lider, projectleader).

tieneUnSoloLider(Proyecto) :- esLider(Lider,Proyecto), not((esLider(LiderDos,Proyecto), Lider \= LiderDos)).

estanTodosBienAsignados(Proyecto) :- forall(trabajaEn(Alguien,Proyecto),estaBienAsignado(Alguien,Proyecto)).

estaBienDefinido(Proyecto):- proyecto(Proyecto), 
	estanTodosBienAsignados(Proyecto), 
	tieneUnSoloLider(Proyecto).
	
esCopadoCon(fernando,santiago).
esCopadoCon(santiago,julieta).
esCopadoCon(santiago,marcos).
esCopadoCon(julieta,andres).


puedeEnseniar(Alguien,Lenguaje,Otro):-
	personas(Otro),
	sabeProgramarEn(Alguien,Lenguaje),
	not(sabeProgramarEn(Otro,Lenguaje)),
	Alguien \= Otro,
	seCopan(Alguien,Otro).

seCopan(Alguien,Otro):-
	esCopadoCon(Alguien,Otro).
seCopan(Alguien,Otro):-
	personas(Persona),
     esCopadoCon(Alguien,Persona),
	Persona\=Otro,
	seCopan(Persona,Otro).
	
	

tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algorítmica(150)).
tarea(marcos, algorítmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)). 

puntosTarea(evolutiva(compleja), 5).
puntosTarea(evolutiva(simple), 3).
puntosTarea(algorítmica(Lineas), Puntos) :- Puntos is Lineas/10.
puntosTarea(correctiva(_, brainfuck), 4).
puntosTarea(correctiva(Lineas, _), 4) :- Lineas > 50.

puntajeDeTarea(Programador, Puntos) :- tarea(Programador, Tarea), puntosTarea(Tarea, Puntos).

seniority(Persona, Seniority) :- personas(Persona), findall(Puntos, puntajeDeTarea(Persona, Puntos), Puntajes), sumlist(Puntajes, Puntaje), Seniority is Puntaje.
%---Punto4----

%1)
%?- esCopadoCon(fernando,santiago).
%true.

%2)
%?- esCopadoCon(fernando,julieta).
%false.

%3)
%?- puedeEnseniar(fernando,cobol,santiago).
%true .
%?-  puedeEnseniar(fernando,cobol,julieta).
%true .
%?-  puedeEnseniar(fernando,cobol,marcos).
%true .
%?-  puedeEnseniar(fernando,cobol,andres).
%true .

%4)
%?- puedeEnseniar(fernando,haskell,Alguien).
%false.

%5)
%?- puedeEnseniar(andres,java,fernando).
%false.
%andres no puede enseniar a fernando ya que fernando ya sabe java.
%?- puedeEnseniar(andres,java,julieta).
%false.
%?- puedeEnseniar(andres,java,santiago).
%false.

%6)
%?- puedeEnseniar(fernando,cobol,Alguien).
%Alguien = andres ;
%Alguien = andres ;
%Alguien = julieta ;
%Alguien = julieta ;
%Alguien = marcos ;
%Alguien = marcos ;
%Alguien = santiago ;
%Alguien = santiago ;
%false.

%?- puedeEnseniar(fernando,visualbasic,Alguien).
%Alguien = andres ;
%Alguien = andres ;
%Alguien = julieta ;
%Alguien = julieta ;
%Alguien = marcos ;
%Alguien = marcos ;
%Alguien = santiago ;
%Alguien = santiago ;
%false.

%?-  puedeEnseniar(fernando,java,Alguien).
%Alguien = andres ;
%Alguien = andres ;
%false.

%7)
%?- puedeEnseniar(marcos,Lenguaje,Alguien).
%false.

%seniority(fernando, Seniority).
%Seniority = 24.
%?- seniority(Personas,0).
%Personas = andres ;
%Personas = santiago ;
%Personas = santiago.
%?- not(seniority(julieta,6)).
%true.

