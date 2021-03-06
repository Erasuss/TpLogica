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

esCompetente(Alguien, Proyecto) :- cumpleElRolDe(Alguien,projectleader).
esCompetente(Alguien, Proyecto) :- cumpleElRolDe(Alguien,analista).
esCompetente(Alguien, Proyecto) :- seProgramaEn(Proyecto,Lenguaje),
	sabeProgramarEn(Alguien,Lenguaje).


estaBienAsignado(Alguien,Proyecto):- 
	trabajaEn(Alguien,Proyecto),
	esCompetente(Alguien, Proyecto).

%estaBienAsignado(Alguien,Proyecto):- 
%trabajaEn(Alguien,Proyecto),
%seProgramaEn(Proyecto,Lenguaje),
%sabeProgramarEn(Alguien,Lenguaje).
%estaBienAsignado(Alguien,Proyecto):-
%trabajaEn(Alguien,Proyecto),
%cumpleElRolDe(Alguien,analista).
%estaBienAsignado(Alguien,Proyecto):-
%trabajaEn(Alguien,Proyecto),
%cumpleElRolDe(Alguien,projectleader).

proyecto(Proyecto):- seProgramaEn(Proyecto,_).

esLider(Lider,Proyecto) :- trabajaEn(Lider,Proyecto), cumpleElRolDe(Lider, projectleader).

tieneUnSoloLider(Proyecto) :- esLider(Lider,Proyecto), not((esLider(LiderDos,Proyecto), Lider \= LiderDos)).

estanTodosBienAsignados(Proyecto) :- forall(trabajaEn(Alguien,Proyecto),estaBienAsignado(Alguien,Proyecto)).

estaBienDefinido(Proyecto):- proyecto(Proyecto), estanTodosBienAsignados(Proyecto), 
	tieneUnSoloLider(Proyecto).

%Esta otra solucion, a diferencia de lo de arriba, usa listas
%estaBienDefinido(Proyecto):- proyecto(Proyecto), forall(trabajaEn(Alguien,Proyecto),estaBienAsignado(Alguien,Proyecto)), 
%findall(trabajaEn(Persona,Proyecto),cumpleElRolDe(Persona, projectleader),L), length(L,1).

%____Consultas______

%---Punto 1

%a
%sabeProgramarEn(fernando, Lenguaje).
%Lenguaje = cobol ;
%Lenguaje = visualbasic .


%b
%sabeProgramarEn(Programador, java).
%Programador = fernando ;
%Programador = julieta .

%c
%sabeProgramarEn(_, assembler).
%false.

%d
%sabeProgramarEn(fernando, _).
%true 

%e
%cumpleElRolDe(fernando, Rol).
%Rol = analista.

%f
%sabeProgramarEn(Programador, _).
%Programador = fernando ;
%Programador = fernando .

%g
%cumpleElRolDe(_, projectleader).
%true.

%---Punto 2

%-1
%?- seProgramaEn(sumatra,Lenguaje).
%Lenguaje = java ;
%Lenguaje = net.

%-2
%?- not((seProgramaEn(prometeus,Lenguaje),Lenguaje\=cobol)).
%true.

%-3
%?- trabajaEn(fernando,Proyecto).
%Proyecto = prometeus.

%-4-
%?- trabajaEn(santiago,Proyecto).
%Proyecto = prometeus.

%-5
%̀?- trabajaEn(Personas,sumatra).
%Personas = julieta ;
%Personas = marcos ;
%Personas = andres.

%-6
%?- estaBienAsignado(Persona,sumatra).
%Persona = julieta ;
%Persona = marcos ;
%Persona = andres.

%-7
%?- estaBienAsignado(Persona,prometeus).
%Persona = fernando ;
%Persona = fernando ;
%false.

%-8
%?- estaBienAsignado(Persona,_).
%Persona = fernando ;
%Persona = julieta ;
% = marcos ;
%Persona = fernando ;
%Persona = andres.

%-9
%?- estaBienAsignado(_,Proyecto).
%Proyecto = prometeus ;
%Proyecto = sumatra ;
%Proyecto = sumatra ;
%Proyecto = prometeus ;
%Proyecto = sumatra.


%---Punto 3

%-1
%estaBienDefinido(sumatra).
%true;
%true.

%-2
%estaBienDefinido(prometeus).
%false.

%-3
%proyecto(Proyecto), not(estaBienDefinido(Proyecto)).
%Proyecto = prometeus.
