# Minimalni-Kostra (Minimum Spanning Tree)

## Hledání minimální kostry grafu
Tento program řeší problém nalezení minimální kostry souvislého neorientovaného grafu. Popis úlohy</br>
hledání minimální kostry grafu zde nebudu popisovat. V čem je program výjimečný?</br>
Program proběhne velmi rychle a to v čase O(Hα(V)), kde H je počet hran, V počet vrcholů a</br>
α(n) je inverzní Ackermannova funkce. Pro praktické účely to je téměř lineární časová složitost.</br>
### Vstupní data a omezení
Uživatel zapíše do textového souboru „vstup.txt“ na první řádek počet hran, poté bude zapisovat po řádcích</br>
trojice čísel. Na prvních dvou místech jsou zadaná čísla vrcholů, mezi kterými vede hrana,</br>
na třetí ohodnocení hrany. Program nerozlišuje chybně zadaná data a program má omezení na 10000 hran</br>
a na počet různých ohodnocení taky 10000. Tato omezení jsou kvůli použití přihrádkového tříděni.</br>
Cílem tohoto programu je nalézt minimální kostru v časové složitosti rovné nebo lepší než H*log(log (V)).</br>
Pro takovou časovou složitost nemůže existovat třídící algoritmus, který by nevyžadoval nějakou</br>
informaci o vstupních datech předem a přihrádkové třídění potřebuje znát velikost dat, které má setřídit.</br>
Jeho výhodou ale je, že setřídí data v lineární časové složitosti, tudíž určitě nebude zpomalovat celý program.</br>
### Výstupní data
Program vypíše po řádcích trojici čísel ve stejném pořadí, v jakém data byla zadána.</br>
### Algoritmus
Program používá Kruskalův algoritmus s využitím datové struktury disjoint set. Program nejdřív přihrádkovým</br>
tříděním setřídí hrany podle ohodnocení, potom vybere hranu s nejnižším ohodnocením. Pokud s již vypsanými</br>
hranami nevytvoří kružnici, pak hranu vypíše.</br> 
### Algoritmus pro zjištění, zda přidáním hrany vytvoříme kružnici
Při vybírání hran, které budou tvořit minimální kostru, se jejím vrcholům bude přiřazovat číslo komponenty,</br>
které si program pamatuje pomocí ukazatelů na rekord, který se skládá z id a rank.</br>
Rank bude ukazovat hloubku stromu,který vzniká právě při sjednocování komponent se stejným rank-em.</br>
Tady nastává situace, kdy ukazatel na komponentu daného vrcholu si ukazuje na tu správnou komponentu</br>
přes jinou komponentu. Proto se v programu využívá tzv. Path compression,</br>
která přesměruje ukazatel daného vrcholu na komponentu v níž se skutečně nachází.</br>
Path compression proběhne při každém zjišťování čísla komponenty.</br>

Tento algoritmus můžeme rozdělit na čtyři části
1. Vrcholy přidávané hrany zatím nejsou v žádné komponentě.
	* vrcholům se přiřadí číslo a komponentě rank rovný nule. 
2. Vrchol jedné z přidávaných hran se nachází v nějaké komponentě.
	* přiřadí se mu číslo komponenty, v níž se nachází druhý vrchol, rank komponenty se nezmění
3. Vrcholy přidávané hrany jsou v různých komponentách, jejích rank se liší
	* vrchol, který se nachází v komponentě s nižším rank-em se přiřadí ke komponentě s vyšším rank-em
4. Vrcholy přidávané hrany jsou v různých komponentách, ale jejích rank se neliší
	* sjednotí se komponenty a zvýší se rank o jeden bod té komponentě, ke které se přiřadí druhá komponenta
