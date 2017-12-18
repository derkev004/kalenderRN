%
% Author: Kevin Konrad, https://github.com/derkev004/boncalendar
%
% originally inspired by http://www.texample.net/tikz/examples/a-calender-for-doublesided-din-a4/
% Original author: Rolf Niepraschk, https://github.com/rolfn/kalenderRN
% License: Creative Commons attribution license (CC-BY-SA)


\setcounter{errorcontextlines}{100}
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{boncalendar}[2016/08/07 v0.2b Calendar class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,ngerman,10pt]{article}
\RequirePackage[headheight=2cm,margin=.5cm,top=3.2cm,nofoot]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{intcalc}
\RequirePackage{etoolbox}
\RequirePackage{forloop}


\renewcommand{\headrulewidth}{0.0pt}
\setlength{\headheight}{10ex}
\newcommand*\bon@title[1]{
  \chead{%
    \raisebox{-.3\height}[0pt][0pt]{\parbox[b]{\textwidth}{%
    \fontsize{60}{70}\selectfont\textbf{\bon@year}
    \textbf{\Huge#1}\hfill
    }}%
  }
}
\bon@title{}
\cfoot{}

\newif\ifbon@XeOrLua \bon@XeOrLuafalse
\RequirePackage{ifluatex,ifxetex}
\ifxetex\bon@XeOrLuatrue\else\ifluatex\bon@XeOrLuatrue\fi\fi

\newif\iftotalcalendar

\ifbon@XeOrLua
  \RequirePackage{fontspec}
  \setsansfont[Ligatures=TeX]{TeX Gyre Heros}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{textcomp}
  \RequirePackage{lmodern}
  \RequirePackage{tgheros}
\fi

\renewcommand*\familydefault{\sfdefault}

\RequirePackage[main=ngerman]{babel}

\RequirePackage[ngerman]{translator}

\newcommand{\longmonthnames}
{
  \deftranslation[to=German]{January}{Januar}
  \deftranslation[to=German]{February}{Februar}
  \deftranslation[to=German]{March}{März}
  \deftranslation[to=German]{April}{April}
  \deftranslation[to=German]{May}{Mai}
  \deftranslation[to=German]{June}{Juni}
  \deftranslation[to=German]{July}{Juli}
  \deftranslation[to=German]{August}{August}
  \deftranslation[to=German]{September}{September}
  \deftranslation[to=German]{October}{Oktober}
  \deftranslation[to=German]{November}{November}
  \deftranslation[to=German]{December}{Dezember}
  \deftranslation[to=German]{Mon}{Mo}
  \deftranslation[to=German]{Tue}{Di}
  \deftranslation[to=German]{Wed}{Mi}
  \deftranslation[to=German]{Thu}{Do}
  \deftranslation[to=German]{Fri}{Fr}
  \deftranslation[to=German]{Sat}{Sa}
  \deftranslation[to=German]{Sun}{So}
}
\longmonthnames

\newcommand{\shortmonthnames}
{
  \deftranslation[to=German]{January}{Jan.}
  \deftranslation[to=German]{February}{Feb.}
  \deftranslation[to=German]{March}{März}
  \deftranslation[to=German]{April}{Apr.}
  \deftranslation[to=German]{May}{Mai}
  \deftranslation[to=German]{June}{Juni}
  \deftranslation[to=German]{July}{Juli}
  \deftranslation[to=German]{August}{Aug.}
  \deftranslation[to=German]{September}{Sep.}
  \deftranslation[to=German]{October}{Okt.}
  \deftranslation[to=German]{November}{Nov.}
  \deftranslation[to=German]{December}{Dez.}
  \deftranslation[to=German]{Mon}{Mo}
  \deftranslation[to=German]{Tue}{Di}
  \deftranslation[to=German]{Wed}{Mi}
  \deftranslation[to=German]{Thu}{Do}
  \deftranslation[to=German]{Fri}{Fr}
  \deftranslation[to=German]{Sat}{Sa}
  \deftranslation[to=German]{Sun}{So}
}

\RequirePackage{tikz}
\usetikzlibrary{calc}
\usetikzlibrary{calendar}

\RequirePackage{varwidth}

\newif\ifevents
\eventstrue
\newcommand{\noevents}{\eventsfalse}
\newcommand{\events}{\eventstrue}

\newcommand*\bon@year{}
\AtBeginDocument{\xdef\bon@year{\the\numexpr\year}}

\newcommand{\eventscale}{1}
\newcommand{\seteventscale}[1]{\renewcommand{\eventscale}{#1}}

\newcommand*\event{%
    \@ifstar
    {\@tempswatrue\bon@event@i}
    {\@tempswafalse\bon@event@i}%
}
\newcommand*\bon@events@I{}
\newcommand*\bon@events@II{}
\newcommand*\bon@events@III{}
\newcommand*\bon@events@IV{}
\newcommand*\bon@events@V{}
\newcommand*\bon@events@VI{}
\newcommand*\bon@events@VII{}
\newcommand*\bon@events@VIII{}
\newcommand*\bon@events@IX{}
\newcommand*\bon@events@X{}
\newcommand*\bon@events@XI{}
\newcommand*\bon@events@XII{}

\newcommand*\bon@backgrounds{}
\newcommand*\bon@periods{}
\newcommand*\period[2]{%
  \edef\@tempa{%
    \noexpand\ifdate{between=#1 and #2}{%
      \noexpand\tikzset{every day/.style={fill=gray!30}}}{}%
  }%
  \expandafter\g@addto@macro\expandafter\bon@periods\expandafter{\@tempa}%
}

\newcommand{\geteom}[1]
{
\ifnum#1=1
  31
\else
  \ifnum#1=2
    \ifnum\intcalcMod{\bon@year}{4}=0
      29
      \else
          28
      \fi
  \else%ifnum#2=2
    \ifnum#1=3
      31
    \else
      \ifnum#1=4
        30
      \else
        \ifnum#1=5
          31
        \else
          \ifnum#1=6
            30
          \else
            \ifnum#1=7
              31
            \else
              \ifnum#1=8
                31
              \else
                \ifnum#1=9
                  30
                \else
                  \ifnum#1=10
                    31
                  \else
                    \ifnum#1=11
                      30
                    \else
                      \ifnum#1=12
                        31
                      \else
                        23
                      \fi
                    \fi
                  \fi
                \fi
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi
\fi
}

\renewcommand{\geteom}[1]
{
\ifcase#1
0\or%0
31\or%1
\ifnum\intcalcMod{\bon@year}{4}=0 29\else 28\fi \or%2
31\or%3
30\or%4
31\or%5
30\or%6
31\or%7
31\or%8
30\or%9
31\or%10
30\or%11
31\else%12
0%
\fi%
}

\newcommand{\getdayofweek}[3]
{
%Originale C-Implementierung mit jeweiliger Übersetzung
%y -= m < 3;
% -> Wird mittels dynamischer Berechnung realisiert, weil zur Laufzeit billig
%    \ifnum#2<3\numexpr#1-1\relax\else#1\fi
%static int t[] = {0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4};
% -> Zugriff auf statisches, unveränderliches Array auf ifcase abbilden
%    \ifcase#2\or0\or3\or2\or5\or0\or3\or5\or1\or4\or6\or2\or4\else0\fi
%return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7;
% -> hier fließen die Komponenten zusammen, vor dem abschließenden Modulo wird
%    6 addiert, da ich Sonntag mit 6 darstelle, nicht als 0 (cyclic shift)
\intcalcMod{%
\ifnum#2<3 #1-1\else#1\fi +%
\intcalcDiv{\ifnum#2<3 #1-1 \else#1\fi}{4} -%
\intcalcDiv{\ifnum#2<3 #1-1 \else#1\fi}{100} +%
\intcalcDiv{\ifnum#2<3 #1-1 \else#1\fi}{400} +%
\ifcase#2\or%
0\or%1
3\or%2
2\or%3
5\or%4
0\or%5
3\or%6
5\or%7
1\or%8
4\or%9
6\or%10
2\or%11
4\else%12
0\fi
+ #3 + 6}{7}
}

\newcommand{\seteasterdate}[1]
{
  \xdef\easterhelp@a{\intcalcMod{#1}{19}}
  \xdef\easterhelp@b{\intcalcDiv{#1}{100}}
  \xdef\easterhelp@c{\intcalcMod{#1}{100}}
  \xdef\easterhelp@d{\intcalcDiv{\easterhelp@b}{4}}
  \xdef\easterhelp@e{\intcalcMod{\easterhelp@b}{4}}
  \xdef\easterhelp@f{\intcalcDiv{\easterhelp@b + 8}{25}}
  \xdef\easterhelp@g{\intcalcDiv{\easterhelp@b - \easterhelp@f + 1}{3}}
  \xdef\easterhelp@h{\intcalcMod{ (19 * \easterhelp@a) + \easterhelp@b - \easterhelp@d - \easterhelp@g + 15 }{30}}
  \xdef\easterhelp@i{\intcalcDiv{\easterhelp@c}{4}}
  \xdef\easterhelp@k{\intcalcMod{\easterhelp@c}{4}}
  \xdef\easterhelp@l{\intcalcMod{ 32 + (2 * \easterhelp@e) + (2 * \easterhelp@i) - \easterhelp@h - \easterhelp@k }{7}}
  \xdef\easterhelp@m{\intcalcDiv{ \easterhelp@a + (11 * \easterhelp@h) + (22 * \easterhelp@l) }{451}}
  \xdef\easterhelp@n{\intcalcDiv{ \easterhelp@h + \easterhelp@l - (7 * \easterhelp@m) + 114 }{31}}
  \xdef\easterhelp@p{\intcalcMod{ \easterhelp@h + \easterhelp@l - (7 * \easterhelp@m) + 114 }{31}}
  \xdef\easter@mon{\easterhelp@n}
  \xdef\easter@day{\the\numexpr\easterhelp@p + 1}
  \xdef\geteasterdate{#1-0\easter@mon-\ifnum\easter@day<10 0\easter@day\else\easter@day\fi}
  \xdef\geteastermonth{\easter@mon}
  \xdef\geteasterday{\easter@day}
}

\newcounter{dayinc@day}
\newcounter{dayinc@month}
\newcounter{dayinc@increment}
\newcommand\dayinc[2]
{
  \setcounter{dayinc@day}{#2}
  \stepcounter{dayinc@day}
  \setcounter{dayinc@month}{#1}
  \ifnum\value{dayinc@day}>\geteom{#1}
    \setcounter{dayinc@day}{1}
    \stepcounter{dayinc@month}
  \fi
}
\newcommand\daydec[2]
{
  \setcounter{dayinc@day}{#2}
  \setcounter{dayinc@day}{\numexpr \value{dayinc@day} - 1 \relax}
  \setcounter{dayinc@month}{#1}
  \ifnum\value{dayinc@day}=0
    \setcounter{dayinc@month}{\numexpr \value{dayinc@month} - 1 \relax}
    \setcounter{dayinc@day}{\geteom{dayinc@month}}
\fi
}
\newcommand{\stepdayinc}[1][1]
{
  \forloop{dayinc@increment}{1}{\arabic{dayinc@increment} < \numexpr #1 + 1 \relax}
  {
    \dayinc{\value{dayinc@month}}{\value{dayinc@day}}
  }
}

\newcommand{\stepdaydec}[1][1]
{
  \forloop{dayinc@increment}{1}{\arabic{dayinc@increment} < \numexpr #1 + 1 \relax}
  {
    \daydec{\value{dayinc@month}}{\value{dayinc@day}}
  }
}

\newcommand{\setholiday}[3]
{
  \xdef\holiday@year{\number #1}
  \xdef\holiday@mon{\number #2}
  \xdef\holiday@day{\number #3}

  \def\holiday@bool{1=2}
  \ifthenelse{\holiday@day=1 \AND \holiday@mon=1}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=1 \AND \holiday@mon=5}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=3 \AND \holiday@mon=10}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=1 \AND \holiday@mon=11}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=24 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=25 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=26 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \seteasterdate{\holiday@year}

  \daydec{\geteastermonth}{\geteasterday}
  \stepdaydec
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Karfreitag: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \stepdayinc[2]
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Ostersonntag: \year-\geteastermonth-\geteasterday}

  \stepdayinc
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Ostermontag: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \stepdayinc[38]
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Christi Himmelfahrt: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \stepdayinc[10]
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Pfingstsonntag: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \stepdayinc
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Pfingstmontag: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \stepdayinc[10]
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}
  %\typeout{Fronleichnam: \year-\arabic{dayinc@month}-\arabic{dayinc@day}}

  \let\getholiday\holiday@bool
}

\newcommand{\setworkholiday}[3]
{
  \xdef\holiday@year{\number #1}
  \xdef\holiday@mon{\number #2}
  \xdef\holiday@day{\number #3}

  \def\holiday@bool{1=2}
  \ifthenelse{\holiday@day=24 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=25 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \ifthenelse{\holiday@day=26 \AND \holiday@mon=12}{\def\holiday@bool{1=1}}{}
  \seteasterdate{\holiday@year}

  \dayinc{\geteastermonth}{\geteasterday}
  \ifthenelse{\holiday@day=\value{dayinc@day} \AND \holiday@mon=\value{dayinc@month}}{\def\holiday@bool{1=1}}{}

  \let\getholiday\holiday@bool
}

\newcommand*\bon@event@i[2]{%
  \protected@edef\@tempa{\noexpand\@ifundefined{pgf@sh@ns@cal-#1}{}{%
    \noexpand\node[anchor=north west] at ($(cal-#1.north east)-(.6em,0em)$){%
      \noexpand\makebox[0pt][r]{\noexpand\resizebox{!}{1.15ex}{%
        \noexpand\varwidth{\cal@colwidth}\noexpand\scalebox{\eventscale}{#2}\noexpand\strut\noexpand\endvarwidth}}};}%
  }%
  \expandafter\ifx\csname bon@event-#1\endcsname\relax
  \expandafter\def\csname bon@event-#1\endcsname{\@ne}
  \pgfcalendarifdate{#1}{at most=01-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@I\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=02-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@II\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=03-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@III\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=04-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@IV\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=05-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@V\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=06-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@VI\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=07-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@VII\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=08-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@VIII\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=09-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@XI\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=10-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@X\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=11-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@XI\expandafter{\@tempa}}
  {
  \pgfcalendarifdate{#1}{at most=12-last}% first half-year?
  {\expandafter\g@addto@macro\expandafter\bon@events@XII\expandafter{\@tempa}}
  {}}}}}}}}}}}}

  \if@tempswa
    \edef\@tempa{%
      \noexpand\ifdate{equals=#1}{\noexpand\tikzset{%
        every day/.style={fill=medium}}}{}
    }%
    \expandafter\g@addto@macro\expandafter\bon@backgrounds\expandafter{\@tempa}%
  \fi
  \else
  \typeout{Warning: duplicate calendar entry for #1: #2}
  \fi
}

\definecolor{dark}{HTML}{A57C00}
\colorlet{medium}{dark!35}
\colorlet{bright}{dark!20}
\colorlet{period}{gray!30}

\newlength{\cal@colsep}
\newlength{\cal@colwidth}
\newlength{\cal@colheight}
\newlength{\cal@monthheight}
\newlength{\cal@weekdayshift}


\def\cal@colnum{6}
\def\cal@monthspread{25}
\setlength{\cal@colsep}{4mm}

\newcommand{\nogap}{\setlength{\cal@colsep}{6.7pt}}
\newcommand{\setgap}[1]{\setlength{\cal@colsep}{#1}}


\newcommand{\calccalendar}[2]{
  \def\cal@colnum{\intcalcAdd{ \intcalcSub{#2}{#1} }{1}}
  \setlength{\cal@colwidth}{\dimexpr (\textwidth / \cal@colnum) - \cal@colsep}
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 33 \relax }
  \setlength{\cal@monthheight}{\dimexpr \cal@colheight / \numexpr \cal@monthspread / 10 \relax}
  \setlength{\cal@weekdayshift}{\dimexpr ( \cal@colwidth / \numexpr -2 \relax ) + 0.4cm}
}
\calccalendar{1}{6}
\newif\ifbon@notFirstCalendar
\bon@notFirstCalendartrue

\newcounter{curmonth}%current month
\newcommand\addevents[2]
{
  \forloop{curmonth}{#1}{\value{curmonth}<\numexpr #2 + 1 \relax}
  {
    \ifcase\value{curmonth}\or
      \bon@events@I \or
      \bon@events@II \or
      \bon@events@III \or
      \bon@events@IV \or
      \bon@events@V \or
      \bon@events@VI \or
      \bon@events@VII \or
      \bon@events@VIII \or
      \bon@events@XI \or
      \bon@events@X \or
      \bon@events@XI \or
      \bon@events@XII
    \fi
  }
}

\newcommand\bon@makeKalender[4]{%
  \ifbon@notFirstCalendar
    \bon@notFirstCalendarfalse
  \else
    \newpage
  \fi
  \resizebox{\linewidth}{!}{
  \begin{tikzpicture}[every day/.style={anchor=north}]%
    \calendar[dates=#1 to #2,name=cal,day text={\%d=},day yshift=3em,%]
      day code={%
        \node[name=\pgfcalendarsuggestedname,every day,shape=rectangle,%
          minimum height=\cal@colheight,text width= \cal@colwidth,draw=gray]{\tikzdaytext};%
          \draw(\cal@weekdayshift,-.1ex) node[anchor=west]{\footnotesize
            \pgfcalendarweekdayshortname{\pgfcalendarcurrentweekday}};%
      },%
      execute before day scope={%
        \ifdate{day of month=1}{%
          \pgftransformxshift{\cal@colwidth + \cal@colsep}%TODO
          % Print month name
          \draw (0,0)node [shape=rectangle,minimum height=\cal@colheight,%
            text width=\cal@colwidth,fill=dark,text=white,draw=dark,text centered]{%
              \textbf{{\small{\pgfcalendarmonthname{\pgfcalendarcurrentmonth}}}}};}{}%
        \ifdate{workday}{%
          \tikzset{every day/.style={fill=white}}%
          \bon@periods}{}%
        \ifdate{Saturday}{\tikzset{every day/.style={fill=bright}}}{}%
        \ifdate{Sunday}{\tikzset{every day/.style={fill=medium}}}{}%
        \bon@backgrounds
      },%
      execute at begin day scope={%
        \pgftransformyshift{\dimexpr \cal@colheight *\numexpr -1 * \pgfcalendarcurrentday \relax}%
      }%
    ];%
    \addevents{#3}{#4}
    %\pgfcalendarifdate{#1}{at most=06-last}{\bon@events@I}{\bon@events@II}%
  \end{tikzpicture}
  }
}
%subtle, but necessary changes require most of this code to be duplicate
%due to readbility
\newcommand\bon@makeHalbkalender[4]{%
  \ifbon@notFirstCalendar
    \bon@notFirstCalendarfalse
  \else
    \newpage
  \fi
  \resizebox{\linewidth}{!}{
  \begin{tikzpicture}[every day/.style={anchor=north}]%
    \calendar[dates=#1 to #2,name=cal,day text={\%d=},%]
      day code={%
        \node[name=\pgfcalendarsuggestedname,every day,shape=rectangle,%
          minimum height=\cal@colheight,text width= \cal@colwidth,draw=gray]{\scalebox{1.25}{\tiny\tikzdaytext}};%
          \draw(\cal@weekdayshift,-.1ex) node[anchor=west]{\scalebox{0.95}{\tiny
            \pgfcalendarweekdayshortname{\pgfcalendarcurrentweekday}}};%
      },%
      execute before day scope={%
        \ifdate{day of month=1}{%
          \pgftransformxshift{\cal@colwidth + \cal@colsep}%TODO
          % Print month name
          \draw (0,0)node [shape=rectangle,minimum height=\cal@colheight,%
            text width=\cal@colwidth,fill=dark,text=white,draw=dark,text centered]{%
              \textbf{{\strut\footnotesize{\pgfcalendarmonthname{\pgfcalendarcurrentmonth}}}}};}{}%
        \ifdate{workday}{%
          \tikzset{every day/.style={fill=white}}%
          \bon@periods}{}%
        \ifdate{Saturday}{\tikzset{every day/.style={fill=bright}}}{}%
        \ifdate{Sunday}{\tikzset{every day/.style={fill=medium}}}{}%
        \bon@backgrounds
      },%
      execute at begin day scope={%
        \pgftransformyshift{\dimexpr \cal@colheight *\numexpr -1 * \pgfcalendarcurrentday \relax}%
      }%
    ];%
    \addevents{#3}{#4}
    %\pgfcalendarifdate{#1}{at most=06-last}{\bon@events@I}{\bon@events@II}%
  \end{tikzpicture}
  }
}

\newcommand*\makeTeilkalender[3][]{%
  \calccalendar{#2}{#3}
  \def\eom{\geteom{#3}}%end of month
  %\centering
  \bon@makeKalender{\bon@year-#2-01}{\bon@year-#3-\eom}{#2}{#3}%
  \bon@title{#1}%
}

\newcommand*\makeDoppelkalender[1][]{%
  \calccalendar{1}{6}
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 67 \relax}
  \def\eom{\geteom{6}}%end of month
  %\centering
    \bon@makeHalbkalender{\bon@year-01-01}{\bon@year-06-\eom}{1}{6}%
    \bon@title{#1}%
  \calccalendar{7}{12}
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 67 \relax}
  \bon@notFirstCalendartrue
  \def\eom{\geteom{12}}%end of month
  %\tikz \draw[color=white] (0,0) -- (\textwidth,0);
    \bon@makeHalbkalender{\bon@year-07-01}{\bon@year-12-\eom}{7}{12}%
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 33 \relax }
}

\newcommand*{\Doppelkalender}[1][]{
\totalcalendartrue
\AfterEndPreamble{\makeDoppelkalender[#1]}
}

\newcommand*{\Teilkalender}[3][]{
\totalcalendarfalse
\AfterEndPreamble{\makeTeilkalender[#1]{#2}{#3}}
}

\newcommand*{\Kalender}[1][]{
\totalcalendartrue
%\AfterEndPreamble{\makeKalender[#1]}
\AfterEndPreamble{\makeTeilkalender[#1]{1}{6}}
\AfterEndPreamble{\makeTeilkalender[#1]{7}{12}}
}

\AtBeginDocument{%
  \begingroup
    \let\year=\bon@year
    \ifevents
      \InputIfFileExists{events\bon@year.tex}{}{}%
    \fi
  \endgroup
}
\pagestyle{fancy}
\AfterEndPreamble{\centering}
\endinput
