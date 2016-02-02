% ------------------------------------------------------------------------
% This file is part of CWEB-NLS.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
%
% Copyright (C) 2002 W{\l}odek Bzyl
% ------------------------------------------------------------------------
\getCVSrevision$Revision: 1.1 $
\getCVSdate$Date: 2004/09/30 11:26:56 $
\getCVSsource$Source: /var/cvs/wyklady/JP1-L/80-ProgramowanieOpisowe/sample.w,v $
% ------------------------------------------------------------------------

% Polskie litery w nazwach zmiennych
\noatl
@l b1 xa
@l e6 xc
@l ea xe
@l b3 xl
@l f1 xn
@l f3 xo
@l b6 xs
@l bc xx
@l bf xz
@l a1 xA
@l c6 xC
@l ca xE
@l a3 xL
@l d1 xN
@l d3 xO
@l a6 xS
@l ac xX
@l af xZ

% Do not insert discretionary break in the middle of the string
%\def\){\discretionary{\hbox{\tentex\BS}}{}{}}
\def\){}

\def\floor#1{\lfloor#1\rfloor}
\def\dts{\mathinner{\ldotp\ldotp}}

% Strona tytu�owa --

\def\title{SAMPLE}
\def\topofcontents{\null\vfill
  \centerline{\titlefont PR�BKA LOSOWA}
  \bigskip
  \centerline{\titlefont przyk�ad programu opisowego}
  \bigskip
  \centerline{(wersja \CVSrevision)}
  \vskip1in
  \vfill}
\def\botofcontents{\parskip=0pt \parindent=0pt
  \vfill
  Copyright \copyright\ 2002 W�odek Bzyl
  \bigskip
  Program ten generuje ci�g przypadkowych liczb naturalnych
  uporz�dkowanych rosn�co. Jest to wersja programu, 
  kt�ry po raz pierwszy pojawi� si� w czasopi�mie CACM w 1984 roku.
  \bigskip
  \line{\tt\CVSsource\hfil\CVSdate}\par}

@* Wst�p.
Program ten jest jednym z~rozwi�za� nast�puj�cego problemu:
\medskip
{\narrower\narrower
\noindent Na wej�ciu dane s� dwie liczby naturalne $M$ i~$N$ takie,
�e $M\xle N$. Na wyj�ciu otrzymujemy $M$-elementowy, rosn�cy ci�g 
losowo wybranych liczb z~przedzia�u $[1\dts N]$.\par}
\medskip\noindent
Problem ten wraz z~rozwi�zaniem pojawi� si� w~kolumnie ,,Programming
Pearls'' [CACM 1984]. Wed�ug D.~E. Knutha, autora rozwi�zania,
poni�sze podej�cie prowadzi do najefektywniejszego programu, gdy |M|
jest do�� du�e i~jednocze�nie ma�e wzgl�dem |N|.
\medskip
Program ten mo�na wykorzysta� do generowania ,,sz�stek'' w~{\sc
TOTO\=LOTKA}. Liczby do zaznaczenia na kuponie otrzymamy uruchamiaj�c
go w~nast�puj�cy spos�b:
\.{sample 6 49}.
\medskip
Wygenerowany ci�g liczb losowych zale�y od liczby sekund, kt�re
up�yn�y od dnia 1~stycznia 1970 roku. I~tak, po uruchomieniu programu
dnia 24~wrze�nia 1996 roku o~godzinie 13:05:53 (czas podany z~zegara
komputera), zosta�y wygenerowane nast�puj�ce liczby:
\.{5 19 24 29 30 31}.
@^Knuth D.~E.@>
@^CACM@>
@^TOTO\=LOTEK@>

@ Zmienne |M| i~|N| to dane programu, opisane powy�ej.  
Oto ich deklaracje.

@d  M_max 1001 /* maksymalna wielko�� |M| dozwolona w tym programie */

@<Zmienne globalne@>=
int M; /* liczba element�w w~pr�bce */
int N; /* losujemy liczby z przedzia�u $[1,N]$ */

@ Funkcje generuj�ce liczby losowe s� zadeklarowane w~pliku
\.{<stdlib.h>}. Tam te� zdefiniowano sta�� |RAND_MAX|.  
Do inicjalizacji generatora liczb losowych wykorzystamy
liczb� sekund zwracan� przez funkcj� |time|.

@c
#include <stdio.h>
#include <stdlib.h> /* deklaracje funkcji |exit|, |rand| i |srand| */
#include <time.h> /* deklaracja funkcji |time| */

@ B�dziemy te� potrzebowa� funkcji |liczba_losowa(i)| wybieraj�cej losowo
liczb� z~przedzia�u $[1\dts i]$. Strona podr�cznika dotycz�ca funkcji
|rand| zaleca aby u�y� poni�szego wyra�enia.

@c
unsigned int
liczba_losowa(i)
unsigned int i;
{
  return 1+(unsigned int)((float) i*rand()/(RAND_MAX+1.0));
}

@ @<Zainicjalizuj generator liczb losowych@>=
srand ((unsigned int) time((time_t) NULL));

@* Og�lny zarys programu.  Po wczytaniu liczb |M| i~|N| z~linii
polece� i~inicjalizacji generatora liczb losowych, generujemy 
kolejno elementy ci�gu w p�tli |while|.

@c
@<Zmienne globalne@>@;
int main(argc,argv)
  int argc; /* liczba argument�w w linii polece� */
  char *argv[]; /* argumenty  */
{
  @<Wczytaj warto�ci |M| i |N| z linii polece�@>@;
  @<Zainicjalizuj generator liczb losowych@>@;
  @#
  @<Zacznij od zbioru pustego |S|@>@;
  liczba_element�w=0;
  while (liczba_element�w<M) {
    t=liczba_losowa(N);
    @<Je�li |t| nie nale�y do |S|, 
      to wstaw |t| i zwi�ksz |liczb�_element�w|@>@;
  }
  @<Wypisz elementy |S| w porz�dku rosn�cym@>@;
  @#
  return EXIT_SUCCESS;
}

@ W schemacie opisanym powy�ej pojawi�o si� kilka nowych zmiennych,
zadeklarujmy je teraz.
Reprezentacja zbioru |S| zostanie wprowadzona w~sekcji 11.

@<Zmienne globalne@>=
unsigned int liczba_element�w; /* liczba element�w zbioru |S| */
unsigned int t; /* nowy kandydat na element zbioru |S| */

@ @<Wczytaj warto�ci |M| i |N| z linii polece�@>=
switch (argc) {
case 3:
  if (sscanf((char *) argv[1], "%d", &M)==1 &&
      sscanf((char *) argv[2], "%d", &N)==1) break;
default: wypisz_spos�b_u�ycia:
  fprintf(stderr, "U�ycie: %s M N\n\
  gdzie M nale�y do przedzia�u [1..N] i 1<=N<=%d\n",*argv,M_max);
  exit(-1);
}
@<Sprawd� poprawno�� danych wej�ciowych@>

@ @<Sprawd� poprawno�� danych wej�ciowych@>=
if (N<1 || M<1 || M>N || M>M_max || N>M_max) {
  fprintf(stderr,"! Nale�y poda� liczby M, N takie, �e M<=N.\n");
  goto wypisz_spos�b_u�ycia;
}

@ @<Zacznij od zbioru pustego |S|@>=
H_max=2*M-1;
alpha=(2.0*M)/N;
for(h=0;h<=H_max;h++) hash[h]=0;

@* Uporz�dkowane tablice rozproszone.
Kluczowym pomys�em prowadz�cym do sprawnie dzia�aj�cego programu jest
tworzenie zbioru |S| w~taki spos�b, aby jego elementy mo�na by�o �atwo
i szybko uporz�dkowa�. Jak zobaczymy, metoda ,,uporz�dkowanych tablic
rozproszonych'' [Amble i Knuth, {\it The Computer Journal} {\bf 17},
135--142] idealnie nadaje si� do tego zadania.
@^uporz�dkowane tablice rozproszone@>
@^Amble@>
@^Knuth D.~E.@>
\medskip
Tablice rozproszone posiadaj� nast�puj�c� w�asno��:
{\it Elementy uporz�dkowanej tablicy rozproszonej nie zale��
od kolejno�ci w~kt�rej by�y wstawiane}. Dlatego uporz�dkowana
tablica rozproszona stanowi ,,kanoniczn�'' reprezentacj� zbioru
jej element�w.

Zbi�r |S| b�dzie reprezentowany przez tablic� sk�adaj�c� si�
z~|2M| liczb ca�kowitych.

@<Zmienne globalne@>=
unsigned int hash[2*M_max]; /* uporz�dkowana tablica rozproszona */
unsigned int h; /* indeks w |hash| */
unsigned int H_max; /* maksymalna liczba element�w do wstawienia w~|hash| */
float alpha; /* $\hbox{rozmiar tablicy}/N$ */

@ Tutaj zajmiemy si� umieszczeniem elementu |t| w~tablicy
rozproszonej.  W~tym celu u�yjemy funkcji mieszaj�cej obliczaj�cej
adres |h| wed�ug wzoru:
$$
h=\floor{2M(t-1)/N}.
$$
Zauwa�my, �e jest to funkcja rosn�ca wzgl�dem |t| o~prawie jednostajnym
rozk�adzie w~przedziale $0\xle h<2M$.

@<Je�li |t| nie nale�y do |S|, to wstaw |t| i zwi�ksz |liczb�_element�w|@>=
h=(int)alpha*(t-1);@/
while (hash[h]>t) if (h==0) h=H_max; @+else h--;
if (hash[h]<t) { /* |t| nie wyst�puje w |S| */
  liczba_element�w++;
  @<Wstaw |t| w uporz�dkowan� tablic� rozproszon�@>
}

@ Najwa�niejsz� cz�� algorytmu stanowi metoda wstawiania elementu
do tablicy rozproszonej. Nowy element |t| jest wstawiany w~miejsce
poprzedniego elementu $t_1<t$, kt�ry zostanie wstawiony w~miejsce
$t_2<t_1$ itd., a� do znalezienia wolnego miejsca.

@<Wstaw |t| w uporz�dkowan� tablic� rozproszon�@>=
while (hash[h]>0) {
   t_1=hash[h]; /* mamy $0<t_1<t$ */
   hash[h]=t;
   t=t_1;
   do {
     if (h==0) h=H_max; @+else h--;
   } while (hash[h]>=t);
}
hash[h]=t;

@ @<Zmienne globalne@>=
unsigned int t_1; /* przesuwany element tablicy */

@* Sortowanie w czasie liniowym.  
Kulminacyjnym fragmentem tego programu jest mo�liwo�� prostego
odczytania w porz�dku rosn�cym element�w z~tablicy rozproszonej.
Dlaczego jest to mo�liwe? Jak to powiedziano, ostateczny
stan tablicy nie zale�y od kolejno�ci, w~kt�rej wstawiano elementy.
Poniewa� u�ywamy monotonicznej funkcji mieszaj�cej,
�atwo mo�na sobie wyobrazi�, jak tablica si� zmienia w~przypadku
wstawiania element�w od najwi�kszego do najmniejszego.

Przyjmijmy, �e niezerowe elementy w~tablicy |hash|, to
$T_1<\cdots<T_M$. Je�li $k$ z~nich, w~trakcie wstawiania,
przesuni�to z pocz�tku tablicy na jej koniec (tj. kiedy |h|
zmienia�o warto�� z |0| na |H_max| $k$ razy), to |hash[0]| b�dzie
zawiera� zero (w~tym przypadku $k$ te� musi by� r�wne zero), albo
b�dzie zawiera� $T_{k+1}$. W~tym przypadku, elementy
$T_{k+1}<\cdots<T_M$ i~$T_1<\cdots<T_k$ pojawi� si� w tablicy
uporz�dkowane od lewej do prawej. Dlatego wstawione elementy mo�na
wypisa� w~porz�dku rosn�cym w~wyniku dwukrotnego przejrzenia
tablicy!

@d wypisz_element printf("%u ", hash[h])
@d wypisz_nl printf("\n")

@<Wypisz elementy |S| w porz�dku rosn�cym@>=
if (hash[0]==0) { /* nie by�o przesuni�cia na pozycj� |H_max| */
  for (h=1; h<=H_max; h++)
    if (hash[h]>0) wypisz_element; }
else { /* by�o przesuni�cie na pozycj� |H_max| */
  for (h=1; h<=H_max; h++)
    if (hash[h]>0) if (hash[h]<hash[0]) wypisz_element;
  for (h=0; h<=H_max; h++)
    if (hash[h]>=hash[0]) wypisz_element;
}
wypisz_nl;

@* Skorowidz. 
   Poni�ej znajdziesz list� identyfikator�w u�ytych w~programie 
\.{hello.w}. Liczba wskazuje na numer sekcji, w~kt�rej u�yto identyfikatora,
a~liczba podkre�lona --- numer sekcji w~kt�rej zdefiniowano identyfikator.
