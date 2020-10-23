% AVISOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% o site swish.swi-prolog.org usa uma versão antiga do swipl
% e algumas regras sem argumento nao sao detectadas

% BIBLIOTECAS %%%%%%%%%%%%%%%%%%%%%%%%%%
% biblioteca para operacoes com listas e inteiros
?- use_module(library(clpfd)).


% FATOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% REGRAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

permutacao([], []).
permutacao(Elementos, [Primeiro | Outros]) :-
	select(Primeiro, Elementos, Restante),
	permutacao(Restante, Outros).

% CONSULTAS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

solucionar() :-

	Vestidos = [_, _, _, _, _],
	Nomes = [_, _, _, _, _],
	Previsoes = [_, _, _, _, _],
	Signos = [_, _, _, _, _],
	Profissoes = [_, _, _, _, _],
	Animais = [_, _, _, _, _],

	% na terceira posicao esta a mulher de libra
	ILibra = 2,
	nth0(ILibra, Signos, libra),

	% na terceira posicao esta a mulher que gosta de coelho
	ICoelho = 2,
	nth0(ICoelho, Animais, coelho),

	% a mulher que gosta de cavalo estao ao lado da que gosta de coelho
	(ICavalo #= ICoelho - 1; ICavalo #= ICoelho + 1), 
	nth0(ICavalo, Animais, cavalo),
	% o prolog faz menas verificacoes se primeiro for calculado o indice
	% para entao fazer uma afirmacao sobre ele

	% a amiga de amarelo esta exatamente a esquerda da amiga que recebeu 
	% uma previsao sobre familia
	nth0(IFamilia, Previsoes, familia),
	IAmarelo #= IFamilia - 1,
	nth0(IAmarelo, Vestidos, amarelo),

	% raquel esta ao lado da amiga que recebeu uma previsao sobre vida amorosa
	nth0(IAmor, Previsoes, amor),
	(IRaquel #= IAmor - 1; IRaquel #= IAmor + 1),
	nth0(IRaquel, Nomes, raquel),

	% a garota de vestido verde esta ao lado da que gosta de cachorro
	nth0(ICachorro, Animais, cachorro),
	(IVerde #= ICachorro - 1; IVerde #= ICachorro + 1),
	nth0(IVerde, Vestidos, verde),

	% a pedagoga esta em algum lugar entre a de signo libra e corretora, nessa ordem
	ILibra #< IPedagoga, IPedagoga #< ICorretora,
	nth0(ICorretora, Profissoes, corretora),
	nth0(IPedagoga, Profissoes, pedagoga),

	% a biologa estao do lado da que gosta de cachorro
	(IBiologa #= ICachorro - 1; IBiologa #= ICachorro + 1),
	nth0(IBiologa, Profissoes, biologa),

	% gisele esta do lado da amiga que recebeu uma previsao sobre viagem
	nth0(IViagem, Previsoes, viagem),
	(IGisele #= IViagem - 1; IGisele #= IViagem + 1),
	nth0(IGisele, Nomes, gisele),

	% a mulher que recebeu uma previsao sobre amor esta em algum lugar
	% entre a de signo gemeos e a que reecebeu uma previsao sobre saude, nessa ordem
	IGemeos #< IAmor, IAmor #< ISaude,
	nth0(IGemeos, Signos, gemeos),
	nth0(ISaude, Previsoes, saude),

	% raquel esta ao lado de vestido azul
	(IAzul #= IRaquel - 1; IAzul #= IRaquel + 1),
	nth0(IAzul, Vestidos, azul),

	% a garota de gemeos esta entre a garota de aquario e a
	% que recebeu uma previsao sobre amor, nessa ordem
	IAquario #< IGemeos, IGemeos < IAmor,
	nth0(IAquario, Signos, aquario),

	% quem gosta de passaro esta ao lado de quem gosta de cachorro
	(IPassaro #= ICachorro - 1; IPassaro #= ICachorro + 1),
	nth0(IPassaro, Animais, passaro),

	% a mulher que recebeu uma previsao sobre saude esta de lado da de sargitario
	(ISargitario #= ISaude - 1; ISargitario #= ISaude + 1),
	nth0(ISargitario, Signos, sargitario),

	% helen esta entre a mulher de gemeos e a pedagoga, nessa ordem
	IGemeos #< IHelen, IHelen #< IPedagoga,
	nth0(IHelen, Nomes, helen),

	% a amiga que gosta de cavalos esta do lado da que nasceu em dezembro (sargitario)
	(ICavalo #= ISargitario - 1; ICavalo #= ISargitario + 1),

	% luiza esta em algum lugar entre a garota de branco e a biologa, nessa ordem
	IBranco #< ILuiza, ILuiza #< IBiologa,
	nth0(IBranco, Vestidos, branco),
	nth0(ILuiza, Nomes, luiza),

	% a veterinaria esta do lado da de vestido branco
	(IVeterinaria #= IBranco - 1; IVeterinaria #= IBranco + 1),
	nth0(IVeterinaria, Profissoes, veterinaria),

	% biologa esta em algum lugar a direita da mulher que gosta de pasaros
	IPassaro #< IBiologa,


	setof(V, vestido(V), TodoVestido),
	setof(N, nome(N), TodoNome),
	setof(Pe, previsao(Pe), TodaPrevisao),
	setof(S, signo(S), TodoSigno),
	setof(Po, profissao(Po), TodaProfissao),
	setof(A, animal(A), TodoAnimal),

	permutacao(TodoVestido, Vestidos),
	permutacao(TodoNome, Nomes),
	permutacao(TodaPrevisao, Previsoes),
	permutacao(TodoSigno, Signos),
	permutacao(TodaProfissao, Profissoes),
	permutacao(TodoAnimal, Animais),


	Vestidos = [Vestido_1,Vestido_2,Vestido_3,Vestido_4,Vestido_5],
	Nomes = [Nome_1,Nome_2,Nome_3,Nome_4,Nome_5],
	Previsoes = [Previsao_1,Previsao_2,Previsao_3,Previsao_4,Previsao_5],
	Signos = [Signo_1,Signo_2,Signo_3,Signo_4,Signo_5],
	Profissoes = [Profissao_1,Profissao_2,Profissao_3,Profissao_4,Profissao_5],
	Animais = [Animal_1,Animal_2,Animal_3,Animal_4,Animal_5],

	Format = "|~w~t~8+|~w~t~10+|~w~t~8+|~w~t~10+|~w~t~12+|~w~t~13+|~w~t~10+|~n",
	write("|----------------------------------------------------------------------|\n"),
	format(Format, ['MULHER', 'VESTIDO', 'NOME', 'PREVISAO', 'SIGNO', 'PROFISSAO', 'ANIMAL']),
	write("|----------------------------------------------------------------------|\n"),

	format(Format, [0, Vestido_1, Nome_1, Previsao_1, Signo_1, Profissao_1, Animal_1]),
	format(Format, [1, Vestido_2, Nome_2, Previsao_2, Signo_2, Profissao_2, Animal_2]),
	format(Format, [2, Vestido_3, Nome_3, Previsao_3, Signo_3, Profissao_3, Animal_3]),
	format(Format, [3, Vestido_4, Nome_4, Previsao_4, Signo_4, Profissao_4, Animal_4]),
	format(Format, [4, Vestido_5, Nome_5, Previsao_5, Signo_5, Profissao_5, Animal_5]),

	write("|----------------------------------------------------------------------|\n").
	
main :- solucionar().