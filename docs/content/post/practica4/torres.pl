% Caso base: mover un disco
hanoi(1, Origen, Destino, _) :-
    write('Mover disco de '), write(Origen),
    write(' a '), writeln(Destino).

% Caso recursivo
hanoi(N, Origen, Destino, Aux) :-
    N > 1,
    N1 is N - 1,
    hanoi(N1, Origen, Aux, Destino),
    write('Mover disco de '), write(Origen),
    write(' a '), writeln(Destino),
    hanoi(N1, Aux, Destino, Origen).