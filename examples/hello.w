% --------------------------------------------------------------------
% This file is part of CWEB-NLS.
% It is distributed WITHOUT ANY WARRANTY, express or implied.
%
% Copyright (C) 2002 W{\l}odek Bzyl
% --------------------------------------------------------------------
\getCVSrevision$Revision: 1.1 $
\getCVSdate$Date: 2004/09/30 11:26:56 $
\getCVSsource$Source: /var/cvs/wyklady/JP1-L/80-ProgramowanieOpisowe/hello.w,v $
% --------------------------------------------------------------------

% Strona tytu�owa --

\def\title{HELLO}
\def\topofcontents{\null\vfill
  \centerline{\titlefont HELLO.W --- SZABLON PROGRAMU OPISOWEGO}
  \vskip 15pt
  \centerline{(wersja \CVSrevision)}
  \vskip1in
  \vfill}
\def\botofcontents{\parskip=0pt \parindent=0pt
  \vskip 0pt plus 1filll
  Copyright \copyright\ 2002 W�odek Bzyl
  \bigskip
  Dokument ten zawiera najwa�niejsze elementy programu opisowego
  ({\it literate program}).
  \bigskip
  \line{\tt\CVSsource\hfil\CVSdate}\par}

% -- albo data --

%\datethis

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

\secpagedepth=2 % sekcje `@@*1' nie b�d� zaczyna� si� od nowej strony

@* Wst�p.  
Najlepszym sposobem na nauczenie si� j�zyka \CEE/ jest samodzielne
pisanie program�w w~tym j�zyku. Jest ju� zwyczajem, �e pierwszy
program ma za zadanie wypisa� tekst:
$$\leftline{\hskip5em\tt hello, world}$$
Oto wersja opisowa ({\it literate\/}) takiego programu.

@ Program \.{hello} sk�ada si� z~jednej funkcji o~nazwie
|main|. Nazwa ta ma specjalne znaczenie w~ka�dym programie napisanym
w~j�zyku \CEE/. Ka�dy program rozpoczyna dzia�anie od pocz�tku funkcji
|main|.

@c
@<W��czane pliki nag��wkowe i definicje zmiennych zewn�trznych@>@#
int main()
{
  @<Wypisz przywitanie@>@;
  return EXIT_SUCCESS;
}

@ Ci�g znak�w uj�ty w~cudzys�owy nazywamy {\it napisem}.  Napis |"\n"|
reprezentuje znak nowego wiersza. Powoduje on przerwanie wypisywania
napisu w~bie��cym wierszu.  Wypisywanie zostanie wznowione od pocz�tku
nast�pnego wiersza.

@<Wypisz przywitanie@>= 
printf("hello, world\n");

@ Do wypisania napisu |"hello, world\n"| na standardowym wyj�ciu u�yto
funkcji |printf|.  Poni�ej zlecamy kompilatorowi do��czenie zawarto�ci
pliku nag��wkowego \.{stdio.h} do tekstu programu.  Plik ten zawiera
definicje standardowych funkcji wej�cia/wyj�cia (I/O), w~tym deklaracj�
funkcji |printf|.

@<W��czane pliki nag��wkowe i definicje zmiennych zewn�trznych@>=
#include <stdio.h> /* definicja |printf| */
#include <stdlib.h> /* definicja |EXIT_SUCCESS| */

@ Drugim (i~ostatnim) do��czanym plikiem nag��wkowym jest \.{config.h}.

@(config.h@>=
#define VERSION "0.0.0 (alpha)"

@ Numer wersji tego programu umie�cimy w~kodzie jako warto�� zmiennej
|version|. W~ten spos�b b�dziemy mogli odr�ni� program \.{hello},
kt�ry powstanie po przet�umaczeniu tego programu przy pomocy polecenia:
$$\leftline{\hskip5em\tt ct hello.w ; cc hello.c -o hello}$$
od innych program�w o~tej samie nazwie.

@<W��czane pliki nag��wkowe i definicje zmiennych zewn�trznych@>=
#include "config.h"
char version[] = VERSION;

@* Skorowidz. 
Poni�ej znajdziesz list� identyfikator�w u�ytych w~programie 
\.{hello.w}. Liczba wskazuje na numer sekcji, w~kt�rej u�yto identyfikatora,
a~liczba podkre�lona --- numer sekcji w~kt�rej zdefiniowano identyfikator.
