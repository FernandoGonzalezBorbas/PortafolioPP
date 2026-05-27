% Caminar hacia la caja
caminar(estado(_, suelo, Caja, Banana),
        estado(Caja, suelo, Caja, Banana)) :-
    write('Camina hacia la caja'), nl.

% Empujar la caja al centro
mover_caja(estado(Pos, suelo, Pos, no),
           estado(centro, suelo, centro, no)) :-
    write('Empuja la caja al centro'), nl.

% Subirse a la caja
subir(estado(centro, suelo, centro, no),
      estado(centro, encima, centro, no)) :-
    write('Sube a la caja'), nl.

% Agarrar la banana
agarrar(estado(centro, encima, centro, no),
        estado(centro, encima, centro, si)) :-
    write('Agarra la banana!'), nl.

% Solución
solucionar(E0) :-
    caminar(E0, E1),
    mover_caja(E1, E2),
    subir(E2, E3),
    agarrar(E3, _).