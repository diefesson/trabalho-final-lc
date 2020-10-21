% Bibliotecas %%%%%%%%%%%%%%%%%%%%%%%%%%
use_module(library(clpfd)).

% Fatos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Vestidos
vestido(amarelo).
vestido(azul).
vestido(branco).
vestido(verde).
vestido(vermelho).

% Nomes
nome(alice).
nome(gisele).
nome(helen).
nome(luiza).
nome(raquel).

% Previsoes
previsao(amor).
previsao(familia).
previsao(saude).
previsao(viagem).
previsao(trabalho).

% Signos
signo(aquario).
signo(gemeos).
signo(leao).
signo(libra).
signo(sargitario).

% Profissoes
profissao(biologa).
profissao(corretora).
profissao(fotografa).
profissao(pedagoga).
profissao(veterinaria).

% Animais
animal(cachorro).
animal(coelho).
animal(gato).
animal(passaro).
animal(cavalo).

% regras %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nao_repetido([]). % Uma lista vazia não tem repetidos
nao_repetido([Primeiro | Outros]) :- % Primeiro, cabeça da lista, Outros, os outros valores da lista
	\+ member(Primeiro, Outros), % Não pode ter outro valor igual a Primeiro dentro da lista 
	nao_repetido(Outros). % Repete recursivamente para os valores restantes na lista

% bem mais rapido que nao_repete
% pois nao gera valores repetidos para serem descartados
permutacao([],[]).
permutacao(L1, [E | L3]) :-
	select(E, L1, L2),
	permutacao(L2, L3).


% Consultas %%%%%%%%%%%%%%%%%%%%%%%%%%%%

solucionar(
	(Vestido_1, Nome_1, Previsao_1, Signo_1, Profissao_1, Animal_1),
	(Vestido_2, Nome_2, Previsao_2, Signo_2, Profissao_2, Animal_2),
	(Vestido_3, Nome_3, Previsao_3, Signo_3, Profissao_3, Animal_3),
	(Vestido_4, Nome_4, Previsao_4, Signo_4, Profissao_4, Animal_4),
	(Vestido_5, Nome_5, Previsao_5, Signo_5, Profissao_5, Animal_5)
) :-

	% na terceira posicao esta a mulher de libra
	% na terceira posicao esta a garota que gosta de coelho
	% a amiga que gosta de coelho esta ao lado da que gosta de cavalo
	% a amiga que gosta de cavalos esta ao lado da que gosta de sargitario
	% percebi que a 1 ou 5 deve ser sargitario
	% a saude esta ao lado da sagitariana
	% percebi que cavalo deve ser a segundo ou quarto animal
	% percebi que gato é vizinho da cavalo
	% os dois espacos restantes so podem ser passaro ou cachorro
	% a de vestido verde esta ao lado de cachorro
	% a biologa esta ao lado da mulher que gosta de cachorro
	% a pedagoga esta em algum lugar entre a libriana e a corretora, nessa ordem
	% percebi que como a libriana esta no meio, pedagoga e corretora estao no final
	% luiza esta entre branco e biologa, mas biologa e a terceira
	% percebi que a de branco é a segunda
	% luiza é a segunda, e por exclusao entre segunda e terceira
	% helen é a terceira
	% veterinaria esta de lado da branco
	% logo é a segunda
	(
		% percebi isto é impossivel pois gemeos tem que vir antes de saude
		% mas aqui temos sargitario
		%(
			%Signos = [sargitario, SR_1, libra, SR_2, SR_3],
			%Previsoes = [PeR_1, saude, PeR_2, PeR_3, PeR_4],
			%(Animais = [gato, cavalo, coelho, passaro, cachorro]; Animais = [gato, cavalo, coelho, cachorro, passaro])
		%);
		(
			(
				Signos = [gemeos, SR_1, libra, SR_2, sargitario],
				(
					Previsoes = [PeR_1, amor, PeR_2, saude, PeR_3];
					Previsoes = [PeR_1, PeR_2, amor, saude, PeR_3]
				)
			);
			(
				Signos = [SR_1, gemeos, libra, SR_2, sargitario],
				Previsoes = [PeR_1, PeR_2, amor, saude, PeR_3]
			)
		),
		(
			% imposivel, pois luiza esta entre branco e biologa
			%(
			%	Animais = [cachorro, passaro, coelho, cavalo, gato],
			%	Vestidos = [VR_1, verde, VR_2, VR_3, VR_4],
			%	Profissoes = [PoR_1, biologa, PoR_2, pedagoga, corretora]
			%);
			(
				Animais = [passaro, cachorro, coelho, cavalo, gato],
				(
					% impossivel, pois a primeria é a de branco
					% Vestidos = [verde, VR_1, VR_2, VR_3, VR_4];
					Vestidos = [branco, VR_1, verde, VR_2, VR_3]
				),(
					% como tem alguem antes de biologa, isso é impossivel
					%Profissoes = [biologa, PoR_1, PoR_2, pedagoga, corretora];
					Profissoes = [fotografa, veterinaria, biologa, pedagoga, corretora]
				)
			)
		),
		Nomes = [NR_1, luiza, helen, NR_2, NR_3]
	),



	% usei permutaçoes para preencher os espacos restantes
	% o que, novamente, foi mais rapido que usar nao_repete
	permutacao([familia, viagem, trabalho], PrevisoesRestantes_1),
	select(PeR_1, PrevisoesRestantes_1, PrevisoesRestantes_2),
	select(PeR_2, PrevisoesRestantes_2, PrevisoesRestantes_3),
	select(PeR_3, PrevisoesRestantes_3, []),

	permutacao([aquario, leao], SignosRestantes_1),
	select(SR_1, SignosRestantes_1, SignosRestantes_2),
	select(SR_2, SignosRestantes_2, []),

	permutacao([amarelo, azul, vermelho], VestidosRestantes_1),
	select(VR_1, VestidosRestantes_1, VestidosRestantes_2),
	select(VR_2, VestidosRestantes_2, VestidosRestantes_3),
	select(VR_3, VestidosRestantes_3, []),

	permutacao([gisele, raquel, alice], NomesRestantes_1),
	select(NR_1, NomesRestantes_1, NomesRestantes_2),
	select(NR_2, NomesRestantes_2, NomesRestantes_3),
	select(NR_3, NomesRestantes_3, []),

	% helen esta entre gemeos e pedagoga
	nth0(IHelen, Nomes, helen),
	nth0(IGemeos, Signos, gemeos),
	nth0(IPedagoga, Profissoes, pedagoga),
	IGemeos < IHelen, IHelen < IPedagoga,

	% raquel esta ao lado da amiga que recebeu uma previsao sobre amor
	nth0(IRaquel, Nomes, raquel),
	nth0(IAmor, Previsoes, amor),
	(IRaquel =:= IAmor + 1; IRaquel =:= IAmor - 1),

	% a amiga de amarelo esta a esquerda da amiga que recebeu uma previsao sobre a familia
	nth0(IAmarelo, Vestidos, amarelo),
	nth0(IFamilia, Previsoes, familia),
	IAmarelo =:= IFamilia - 1,

	% gisele esta ao lado da amiga que recebeu uma previsao sobre viagem
	nth0(IGisele, Nomes, gisele),
	nth0(IViagem, Previsoes, viagem),
	(IGisele =:= IViagem + 1; IGisele =:= IViagem - 1),

	% raquel esta ao lado da mulher de vestido azul
	nth0(IAzul, Vestidos, azul),
	(IRaquel =:= IAzul + 1; IRaquel =:= IAzul - 1),

	% por fim, "desencapsula" a lista para gerar o resultado
	Vestidos = [Vestido_1, Vestido_2, Vestido_3, Vestido_4, Vestido_5],
	Nomes = [Nome_1, Nome_2, Nome_3, Nome_4, Nome_5],
	Previsoes = [Previsao_1, Previsao_2, Previsao_3, Previsao_4, Previsao_5],
	Signos = [Signo_1, Signo_2, Signo_3, Signo_4, Signo_5],
	Profissoes = [Profissao_1, Profissao_2, Profissao_3, Profissao_4, Profissao_5],
	Animais = [Animal_1, Animal_2, Animal_3, Animal_4, Animal_5],

	write("\n"),
	!.

escrever_solucao(Solucao) :-
	forall(nth0(I, Solucao, E), (
		write(I), write(". "), write(E), write("\n")
	)),
	write("\n"),
	write("\n").

main(Args) :-
	Args \= [] -> write("este algoritmo nao usa argumentos") ; write(""),
	forall(solucionar(A, B, C, D, E), escrever_solucao([A, B, C, D, E])).