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
\newcommand*\bon@title{}
\chead{%
  \raisebox{-.3\height}[0pt][0pt]{\parbox[b]{\textwidth}{%
  \fontsize{60}{70}\selectfont\textbf{\bon@year}
  \textbf{\Huge\bon@title}\hfill
  }}%
}
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
      \ifnum\intcalcMod{\bon@year}{100}=0
        \ifnum\intcalcMod{\bon@year}{400}=0\else
          28
        \fi
      \fi
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


\newcommand*\bon@event@i[2]{%
  \protected@edef\@tempa{\noexpand\@ifundefined{pgf@sh@ns@cal-#1}{}{%
    \noexpand\node[anchor=north west] at ($(cal-#1.north east)-(.6em,0em)$){%
      \noexpand\makebox[0pt][r]{\noexpand\resizebox{!}{1.15ex}{%
        \noexpand\varwidth{\cal@colwidth}\noexpand\scalebox{\eventscale}{#2}\noexpand\strut\noexpand\endvarwidth}}};}%
  }%
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
    \ifnum\value{curmonth}=1% first half-year?
    {\bon@events@I}
    \else
    \ifnum\value{curmonth}=2% first half-year?
    {\bon@events@II}
    \else
    \ifnum\value{curmonth}=3% first half-year?
    {\bon@events@III}
    \else
    \ifnum\value{curmonth}=4
    {\bon@events@IV}
    \else
    \ifnum\value{curmonth}=5
    {\bon@events@V}
    \else
    \ifnum\value{curmonth}=6
    {\bon@events@VI}
    \else
    \ifnum\value{curmonth}=7
    {\bon@events@VII}
    \else
    \ifnum\value{curmonth}=8
    {\bon@events@VIII}
    \else
    \ifnum\value{curmonth}=9
    {\bon@events@XI}
    \else
    \ifnum\value{curmonth}=10
    {\bon@events@X}
    \else
    \ifnum\value{curmonth}=11
    {\bon@events@XI}
    \else
    \ifnum\value{curmonth}=12
    {\bon@events@XII}
    \fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi\fi
  }
}

\newcommand\bon@makeKalender[4]{%
  \ifbon@notFirstCalendar
    \bon@notFirstCalendarfalse
  \else
    \pagebreak
  \fi
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
%subtle, but necessary changes require most of this code to be duplicate
%due to readbility
\newcommand\bon@makeHalbkalender[4]{%
  \ifbon@notFirstCalendar
    \bon@notFirstCalendarfalse
  \else
    \pagebreak
  \fi
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

\newcommand*\makeKalender[1][]{%
  \gdef\bon@title{#1}%
  \calccalendar{1}{6}
  \centering
    \bon@makeKalender{\bon@year-01-01}{\bon@year-06-30}{1}{6}%
    \pagebreak
    \bon@makeKalender{\bon@year-07-01}{\bon@year-12-31}{7}{12}%
}

\newcommand*\makeTeilkalender[3][]{%
  \def\bon@title{#1}%
  \calccalendar{#2}{#3}
  \def\eom{\geteom{#3}}%end of month
  \centering
    \bon@makeKalender{\bon@year-#2-01}{\bon@year-#3-\eom}{#2}{#3}%
}

\newcommand*\makeDoppelkalender[1][]{%
  \def\bon@title{#1}%
  \calccalendar{1}{6}
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 66 \relax}
  \def\eom{\geteom{6}}%end of month
  \centering
    \bon@makeHalbkalender{\bon@year-01-01}{\bon@year-06-\eom}{1}{6}%
  \calccalendar{7}{12}
  \setlength{\cal@colheight}{\dimexpr \textheight / \numexpr 66 \relax}
  \def\eom{\geteom{12}}%end of month
  \tikz \draw[color=white] (0,0) -- (\textwidth,0);
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
\AfterEndPreamble{\makeKalender[#1]}
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
\endinput
