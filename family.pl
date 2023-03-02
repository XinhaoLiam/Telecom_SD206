/*---------------------------------------------------------------*/
/* Telecom Paristech - J-L. Dessalles 2020                       */
/* LOGIC AND KNOWLEDGE REPRESENTATION                            */
/*            http://teaching.dessalles.fr/LKR                   */
/*---------------------------------------------------------------*/


% partial elementary English grammar

% --- Grammar

s --> np(Number), vp(Number).

s --> np(Sem),vp(Sem).

np --> det, n.		% Simple noun phrase
np --> det, n, pp.		% Noun phrase + prepositional phrase 
%np --> np, pp.		% Noun phrase + prepositional phrase 
np --> [kirk].

np(Number) --> det(Number), n(Number).

np(Sem) --> det, n(Sem).

vp --> v.           % Verb phrase, intransitive verb
vp --> v, np.		% Verb phrase, verb + complement:  like X
vp --> v, pp.		% Verb phrase, verb + indirect complement : think of X 
vp --> v, np, pp.	% Verb phrase, verb + complement + indirect complement : give X to Y 
vp --> v, pp, pp.	% Verb phrase, verb + indirect complement + indirect complement : talk to X about Y

vp(Sem) --> v(Sem,_).
vp(Sem1) --> v(Sem1,Sem2),np(Sem2).

vp --> v(none).
vp --> v(transitive), np.
vp --> v(intransitive),pp.
vp --> v(diintransitive), pp, pp.

vp(Number) --> v(Number).           % Verb phrase, intransitive verb
vp(Number) --> v(Number), np(_).		% Verb phrase, verb + complement:  like X
vp(Number) --> v(Number), pp.		% Verb phrase, verb + indirect complement : think of X 
vp(Number) --> v(Number), np(_), pp.	% Verb phrase, verb + complement + indirect complement : give X to Y 
vp(Number) --> v(Number), pp, pp.	% Verb phrase, verb + indirect complement + indirect complement : talk to X about Y

pp --> p, np.		% prepositional phrase

% -- Lexicon
det --> [the].
det --> [my].
det --> [her].
det --> [his].
det --> [a].
det --> [some].
det(_) --> [my].
det(_) --> [her].
det(_) --> [his].
det(singular) --> [a].
det(plural) --> [many].
det(_) --> [the].
det(plural) --> [some].

n --> [dog].
n --> [daughter].
n --> [son].
n --> [sister].
n --> [aunt].
n --> [neighbour].
n --> [cousin].
n(singular) --> [dog].
n(plural) --> [dogs].
n(singular) --> [daughter].
n(plural) --> [daughters].
n(singular) --> [son].
n(plural) --> [sons].
n(singular) --> [sister].
n(plural) --> [sisters].
n(singular) --> [aunt].
n(plural) --> [aunts].
n(singular) --> [neighbour].
n(plural) --> [neighbours].
n(singular) --> [cousin].
n(plural) --> [cousins].

n(sentient) --> [daughter];[son];[sister];[aunt];[neighbour].
n(noEdible) --> [door].
n(edible) --> [apple];[dog].

v --> [grumbles].
v --> [likes].
v --> [gives].
v --> [talks].
v --> [annoys].
v --> [hates].
v --> [cries].

v(none) --> [grumbles].
v(intransitive) --> [grumbles].
v(transitive) --> [likes].
v(transitive) --> [gives].
v(intransitive) --> [talks].
v(transitive) --> [annoys].
v(transitive) --> [hates].
v(none) --> [cries].
v(intransitive) --> [cries].
v(none) --> [knows].
v(transitive) --> [knows].
v(none) --> [talks];
v(intransitive) --> [talks].
v(diintransitive) --> [talks].

v(singular) --> [grumbles].
v(plural) --> [grumble].
v(singular) --> [likes].
v(plural) --> [like].
v(singular) --> [gives].
v(plural) --> [give].
v(singular) --> [talks].
v(plural) --> [talk].
v(singular) --> [annoys].
v(plural) --> [annoy].
v(singular) --> [hates].
v(plural) --> [hate].
v(singular) --> [cries].
v(plural) --> [cry].

v(sentient,_) --> [sleeps].
v(sentient,_) --> [likes].
v(sentient,edible) --> [eats].
v(sentient,_) --> [talks].
v(sentient,_) --> [gives].

p --> [of].
p --> [to].
p --> [about].