%%	Класс документа (с 2025) LaTeX, разработанный для конвертирования фанфиков
%%	с сайта ficbook.net в формат pdf.
%%	
%%	(c) Rikudo_Sannin, 2016--2017, 2019, 2020, 2021, 2024--2025

%% TODO LIST
% 0. Узнать, как восстановить значение false для if-команд (для
%    пакета indentfirst)
% 1. Сделать выбор цветовой схемы в стиле «ключ-значение»
% 2. Сделать выбор языка и локалей через пакет Babel, узнавать всю информацию
%    из выбранного языка (возможно, всё же переделать в \if'ы)
%    \BCPdata{tag} % e. g., en-US / ru-RU
% 3. Сделать шапки разными в зависимости от того, какой это язык — или, лучше,
%    в зависимости от того, какой это сайт. Опционально — в зависимости от
%    того, какие опции есть, а какие нет.
% 4. Сделать так, чтобы оно работало.
% 5. \everypar{\hangindent=2\parindent} или что-то вроде того
% 6. Или лучше через description? Всё придумано до нас

\NeedsTeXFormat{LaTeX2e}[2023-01-01]%
%
\ProvidesClass{fbs}[%
	Rikudo's style class for fanfics formatting from Ficbook and Archive Of Our Own%
]%

% =============================================================================

\newcommand*{\mal}{\makeatletter}%
\newcommand*{\mao}{\makeatother}%
\newcommand*{\gmal}{\global\makeatletter}%
\newcommand*{\gmao}{\global\makeatother}%
%
\mal

\newif\iffbs@debugmode
\fbs@debugmodefalse

\newif\iffbs@phonemode
\newif\iffbs@printmode

\newif\iffbs@indentfirstmode
\fbs@indentfirstmodetrue

\newif\iffbs@pscyr
\fbs@pscyrfalse

\newif\iffbs@redacton
\fbs@redactonfalse

\mao

% ===================== Declaring how to process options ======================

\mal

\DeclareOption{debug}{%
	\fbs@debugmodetrue
	\tracingmacros=1
	\typeout{Debug mode activated; tracingmacros = 1.}%
}%

\DeclareOption{nodebug}{%
	\fbs@debugmodefalse
	\tracingmacros=0
}%

\DeclareOption{phone}{%
	\fbs@phonemodetrue
	\fbs@printmodefalse
}

\DeclareOption{print}{%
	\fbs@phonemodefalse
	\fbs@printmodetrue
}

\DeclareOption{pscyr}{%
	\fbs@pscyrtrue
}

\DeclareOption{mynoindentfirst}{%
	\fbs@indentfirstmodefalse
}

\DeclareOption{redact}{%
	\fbs@redactontrue
}


\DeclareOption*{\PackageWarning{fbs}{%
		Unknown option `\CurrentOption'.%
	}%
}

% For example, to pass every unknown option on to the article class,
% you can use:
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{extbook}%
	\typeout{fbs class: `\CurrentOption' ~> extbook}%
}

\mao

% ---------------------	Actually __process__ the options ----------------------

\ProcessOptions\relax

% -----------------	Загружаем класс, на котором основан наш -------------------

\LoadClass{extbook}%

% Все ключи передаются прямо в extbook
% \LoadClassWithOptions{extbook}%

% =============================================================================

% \renewcommand*{\normalsize}{\fontsize{14pt}{16.8pt}\selectfont}%
% \pagenumbering{arabic}

\gmal

%\RequirePackage{xkeyval}

%\newcommand*{\fbs@encoding}{}
%\DeclareOptionX{encoding}[utf8]{\renewcommand*{\fbs@encoding}{#1}}
%\ProcessOptionsX

% =============================================================================

\RequirePackage[T2A, T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\inputencoding{utf8}

\RequirePackage[main = russian, english, francais, dutch]{babel}
% \texten, \textru, ...
\babeltags{en = english, ru = russian, fr = francais, de = dutch}

% =============================================================================

% \usepackage{fontspec}
% 	\setmainfont{DejaVu Serif}
% 	\newfontfamily\cyrillicfont{DejaVu Serif}
% 	\usepackage[babelshorthands]{polyglossia}
% %\usepackage{tabularx}
% 	\setdefaultlanguage{russian}
% 	\setotherlanguage{english}

% =============================================================================

% ifthenelse{<условие>}{<действия, если истинно>}{<действия, если ложно>}
\RequirePackage{ifthen}		

% =============================================================================

%\newwrite\ouf
%\immediate\openout\ouf=test.out

%\obeylines
%\immediate\write\ouf{\fbs@encoding}

%\immediate\closeout\ouf

% =============================================================================

\iffbs@indentfirstmode
	\RequirePackage{indentfirst}
\fi

\RequirePackage{soul}
% \newcommand*{\np}{\relax}
\RequirePackage[np]{numprint}

\RequirePackage{xifthen}

% Действия над числами
\RequirePackage{calculator}

\RequirePackage{geometry}
%\geometry{top = 3cm, bottom = 2.5cm , left = 2.5cm, right = 2.5cm}
%% \geometry{margin = 0.95in, top = 1in}
%% \geometry{%
%% 	%bottom = 0.55in,
%% 	bottom = 1.0in,
%% 	top = 1.0in,
%% 	left = 0.77in,
%% 	right = 0.77in,
%% }
%% % a5
%% \geometry{%
%% 	%bottom = 0.55in,
%% 	bottom = 1.0in,
%% 	top = 1.0in,
%% 	left = 0.70in,
%% 	right = 0.70in,
%% }
%% \geometry{%
%% 	%bottom = 0.55in,
%% 	bottom = 1.0in,
%% 	top = 1.0in,
%% 	left = 0.60in,
%% 	right = 0.60in,
%% }

\iffbs@printmode
	% Для печати
	\geometry{%
		a5paper,
		margin=1cm,
		top=1.9cm,
		bottom=1.7cm
	}
\fi

\iffbs@phonemode
	% Для телефонов
	\geometry{%
		a5paper,
		margin=5mm,
		includehead,
		includefoot
	}
\fi

% =============================================================================

% !!!
% \RequirePackage{tempora}
% \RequirePackage{erewhon}


% =============================================================================

\iffbs@pscyr
	\RequirePackage[math]{pscyr}
	\renewcommand*{\rmdefault}{ftm}
	%\renewcommand*{\rmdefault}{fha}
	%\renewcommand*{\rmdefault}{fsv}
	%\renewcommand*{\rmdefault}{flz}
	%\renewcommand*{\rmdefault}{fjn}
	% \renewcommand*{\rmdefault}{ftm}
	% \renewcommand*{\ttdefault}{\sfdefault}
\else
	\RequirePackage[libertinus, varbb, varg]{newtx}
	\AtBeginDocument{%
		\DeclareFontFamilySubstitution{T2A}{\scdefault}{Tempora-TLF}%
	}
\fi

% \RequirePackage{dejavu}
% \renewcommand{\baselinestretch}{1.15}	% !!!


%\RequirePackage[scaled=0.95]{cabin}

% \RequirePackage{setspace}
%\renewcommand{\baselinestretch}{1.2}
%\setlength{\baselineskip}{3ex}
%\onehalfspacing
%\singlespacing

% =============================================================================

\RequirePackage{arrayjob} % Массивы
\RequirePackage{multido}  % Циклы

% ================================== Colors ===================================

\RequirePackage{xcolor}

%\definecolor{toclinkcolor}{rgb}{1,0.41,0.13}%{0.92,0.5,0.4}%%{rgb}%{0.74,0.024,1.0}%{0.74,0.024,0.92}
%\definecolor{toclinkcolor}{rgb}{0.58,0,0.82}
\definecolor{toclinkcolor}{rgb}{0,0,0.82}
%\definecolor{urllinkcolor}{rgb}{0,0,1}
\definecolor{urllinkcolor}{rgb}{0,0,0.82}

% https://coolors.co/d64045-f3f7f0-09bc8a-467599-1d3354
\definecolor{Poppy}    {HTML}{d64045}
\definecolor{MintCream}{HTML}{F3F7F0}
\definecolor{Mint}     {HTML}{09BC8A}
\definecolor{UCLABlue} {HTML}{467599}
\definecolor{DelftBlue}{HTML}{1D3354}

% https://coolors.co/0fa3b1-0a1128-001f54-034078-fefcfb
\definecolor{Moonstone} {HTML}{0fa3b1}
\definecolor{OxfordBlue}{HTML}{0a1128}
\definecolor{PennBlue}  {HTML}{001f54}
\definecolor{Indigo}    {HTML}{034078}
\definecolor{White}     {HTML}{fefcfb}

% https://coolors.co/18206f-17255a-f5e2c8-d88373-bd1e1e
\definecolor{MidnightBlue}{HTML}{18206f}
\definecolor{PennBlueTwo} {HTML}{17255a}
\definecolor{Champagne}   {HTML}{f5e2c8}
\definecolor{CoralPink}   {HTML}{d88373}
\definecolor{CornellRed}  {HTML}{bd1e1e}
\definecolor{CaribbeanCurrent}{HTML}{3C6E71}

% https://coolors.co/eaebed-420039-d72638-ff570a-007090

\colorlet{myurlcolor}{PennBlue}
\colorlet{mylinkcolor}{PennBlue}
\colorlet{myredactwrong}{CornellRed}
\colorlet{myredactcorrect}{CaribbeanCurrent}

% =================================	Hyperref ==================================

\RequirePackage{hyperref}	% Для ссылок
\hypersetup{%
	breaklinks=true,%
	colorlinks=true,%
	extension=pdf,%
	urlcolor=myurlcolor,%
	linkcolor=mylinkcolor,%
	unicode=true,%
	draft=false,%
	pdfpagemode={},%
	plainpages=false,%
	pdfpagelabels=true,%
	linktocpage=false,%
%	pageanchor=true%
}

%\renewcommand*{\UrlFont}{\fontfamily{arial}\selectfont}
% \renewcommand*{\UrlFont}{\sf}
\urlstyle{sf}

% ===============================	Typesetting =================================

\RequirePackage{tocloft}
\RequirePackage{fnpct}
\RequirePackage[%
	kerning=true,
	spacing=true,
	protrusion=true,
	babel=true,
	factor=1000
]{microtype}

% \RequirePackage{enumitem}
% \RequirePackage{enumerate}
\RequirePackage[shortlabels]{enumitem}
% \RequirePackage[np]{numprint}

% ================================== Errors ===================================

% Отлов ошибок
\newcommand*{\Error}{\textsc{\textcolor{red}{Error}}}%

% ============================== Прочие команды ===============================

% Отступ абзаца по умолчанию
\newlength{\fbs@indent}{\value{parindent}}

% Создание нового условия: «существует ли вторая часть?»
\newif\if@fbs@existsSecondSection@

% Инициализация значением false
\@fbs@existsSecondSection@false

% Первая ли компиляция? (Важно для корректной генерации оглавления,
% колонтитулов и номеров страниц.)
\newif\if@fbs@firstCompilation@
																		
% Инициализация значением true
\@fbs@existsSecondSection@true

% !..
\newcommand*{\edots}{%
	\mbox{%
		\mbox{%
			\hphantom{\ensuremath{\ldotp}}!%
		}%
		\ensuremath{\ldotp\ldotp}%
	}%
}

% ?..
\newcommand*{\qdots}{%
	\mbox{%
		\mbox{%
			\hphantom{\ensuremath{\ldotp}}?%
		}%
		\ensuremath{\ldotp\ldotp}%
	}%
}

% ?!
\newcommand*{\qedot}{%
	\mbox{%
		\mbox{%
			\hphantom{\ensuremath{\ldotp}}?%
		}%
		\mbox{%
			\hphantom{\ensuremath{\ldotp}}!%
		}%
		\ensuremath{\ldotp}%
	}%
}

% ==============================================================================
% Контейнеры для текста в виде команд и массивов. Инициализация пустой строкой:

\newcommand*{\fbs@TitleBox}{}
\newcommand*{\fbs@TitleColontitulBox}{}
\newcommand*{\fbs@FicLinkBox}{}
\newcommand*{\fbs@TitleFootnoteBox}{}
%
\newarray\fbs@AuthorsBox
\newarray\fbs@AuthorsLinkBox
\newarray\fbs@TranslatorsBox
\newarray\fbs@TranslatorsLinkBox
\newarray\fbs@BetasBox
\newarray\fbs@BetasLinkBox
\newarray\fbs@GammasBox
\newarray\fbs@GammasLinkBox
\newarray\fbs@PairingBox
\newarray\fbs@FandomBox
\newarray\fbs@CharactersBox
\newarray\fbs@RatingBox
\newarray\fbs@GenresBox
\newarray\fbs@WarningsBox
%
\newarray\fbs@MarksBox
\newarray\fbs@MarksBox
%
\newcommand*{\fbs@SizeBox}{}
\newcommand*{\fbs@PartsNumBox}{}
\newcommand*{\fbs@StatusBox}{}
%
\newcommand{\fbs@DescriptionBox}{}
\newcommand{\fbs@DedicationBox}{}
\newcommand{\fbs@PublicationBox}{}
\newcommand{\fbs@AuthorsCommentsBox}{}
%
\newcommand{\fbs@AuthorsNotesBox}{}
\newcommand{\fbs@SummaryBox}{}
\newcommand{\fbs@DirectionBox}{}

% ============================== Названия полей ================================

\newif\iffbs@english
\newif\iffbs@russian

\AtBeginDocument{%
	\mal
	\newcommand*{\fbs@makeBoxName}[3]{%
		\let\fbs@tempname=\undefined
		\let\fbs@tempval=\undefined
		\gdef\fbs@tempname{\csname #1\endcsname}
		\newcommand{\fbs@tempval}{%
			\iffbs@russian
				#2%
			\else
				\iffbs@english
					#3%
				\fi
			\fi
		}%
		\iffbs@debugmode
			\begingroup
				\sffamily
				\begin{align*}
					\text{fbs@tempname} &=%
					\text{%
						\expandafter
						\expandafter
						\expandafter
						\string\fbs@tempname
					}
					\\
					\text{%
						fbs@tempval%
					} &=
					\text{%
						\fbs@tempval
					}
				\end{align*}
			\endgroup
		\fi
		% \iffbs@debugmode
		% 	\begingroup
		% 		\par
		% 		\sfshape
		% 		fbs@tempname=%
		% 			\expandafter
		% 			\expandafter
		% 			\expandafter
		% 			\string\fbs@tempname
		% 			\par
		% 		fbs@tempval=\fbs@tempval\par
		% 	\endgroup
		% \fi
	}%
	%
	% \fbs@makeBoxName{fbs@AuthorsBoxSingle}{Автор}{Author}
	% \fbs@makeBoxName{fbs@AuthorsBoxPlural}{Авторы}{Authors}
	%
	% \fbs@makeBoxName{fbs@AuthorsBoxSingle}{Автор}{Author}
	% \fbs@makeBoxName{fbs@AuthorsBoxPlural}{Авторы}{Authors}
	%
	\mao
}


% ==============================================================================

\newcommand*{\fbsclearfields}{%
	\begingroup
	\ignorespaces
	\mal
	%
	\renewcommand*{\fbs@TitleBox}{}
	\renewcommand*{\fbs@TitleColontitulBox}{}
	\renewcommand*{\fbs@FicLinkBox}{}
	\renewcommand*{\fbs@TitleFootnoteBox}{}
	%
	\delarray\fbs@AuthorsBox
	\newarray\fbs@AuthorsBox
	\delarray\fbs@AuthorsLinkBox
	\newarray\fbs@AuthorsLinkBox
	\delarray\fbs@TranslatorsBox
	\newarray\fbs@TranslatorsBox
	\delarray\fbs@TranslatorsLinkBox
	\newarray\fbs@TranslatorsLinkBox
	\delarray\fbs@BetasBox
	\newarray\fbs@BetasBox
	\delarray\fbs@BetasLinkBox
	\newarray\fbs@BetasLinkBox
	\delarray\fbs@GammasBox
	\newarray\fbs@GammasBox
	\delarray\fbs@GammasLinkBox
	\newarray\fbs@GammasLinkBox
	\delarray\fbs@PairingBox
	\newarray\fbs@PairingBox
	\delarray\fbs@FandomBox
	\newarray\fbs@FandomBox
	\delarray\fbs@CharactersBox
	\newarray\fbs@CharactersBox
	\delarray\fbs@RatingBox
	\newarray\fbs@RatingBox
	\delarray\fbs@GenresBox
	\newarray\fbs@GenresBox
	\delarray\fbs@WarningsBox
	\newarray\fbs@WarningsBox
	%
	\delarray\fbs@MarksBox
	\newarray\fbs@MarksBox
	\delarray\fbs@MarksBox
	\newarray\fbs@MarksBox
	%
	\renewcommand*{\fbs@SizeBox}{}
	\renewcommand*{\fbs@PartsNumBox}{}
	\renewcommand*{\fbs@StatusBox}{}
	%
	\renewcommand{\fbs@DescriptionBox}{}
	\renewcommand{\fbs@DedicationBox}{}
	\renewcommand{\fbs@PublicationBox}{}
	\renewcommand{\fbs@AuthorsCommentsBox}{}
	%
	\renewcommand{\fbs@AuthorsNotesBox}{}
	\renewcommand{\fbs@SummaryBox}{}
	\renewcommand{\fbs@DirectionBox}{}
	%
	\setcounter{fbs@TotSections@cnt}{0}
	%
	\mao
	\endgroup
}

% ===================	Подсчёт количества страниц и частей ======================

\newcounter{fbs@TotSections@cnt}
\setcounter{fbs@TotSections@cnt}{0}

% ================================ Оглавление ==================================

\newcommand*{\fbs@settocpagestyle}
{%
	\renewcommand{\cfttoctitlefont}{%
		\hfill
		% \Huge
		\LARGE
		\bfseries
	}%
	\renewcommand{\cftaftertoctitle}{%
		\hfill\rule{0pt}{0pt}%
		\thispagestyle{empty}%
		\pagestyle{empty}%
	}%
	\setlength{\cftbeforetoctitleskip}{0pt}%
}

% Колонтитулы
\newcommand*{\fbs@setpagestyle}
{%
	\ignorespaces%
	\pagestyle{myheadings}%
	%
	\makeatletter%
	\renewcommand*{\@oddhead}%	Односторонняя печать
	{%
		\raisebox{0pt}[\headheight][0pt]%	Начало блока
		{%
			\vbox%
			{%
				\hbox to \textwidth%
				{%
					\if@fbs@existsSecondSection@
						\normalfont%
						\strut%
						\thepage%
						\hfil%
						\slshape%
						\leftmark%
						\normalfont%
					\else
						% \normalfont
						% \strut
						% \thepage
						% \hfil
						% \scshape
						% \fbs@TitleColontitulBox
						% \normalfont%
						\normalfont
						\strut
						% \scshape
						\itshape
						\fbs@TitleColontitulBox
						\normalfont
						\hfil
						\thepage
						\normalfont%
					\fi
					%\normalfont
					%\strut
					%\slshape
					%\rightmark
					%\normalfont
					%\hfil
					%\thepage%
				}%
				\hrule%
			}%
		}%
	}%
	%
	\renewcommand*{\@evenhead}%	Двусторонняя печать
	{%
		\raisebox{0pt}[\headheight][0pt]%	Начало блока
		{%
			\vbox%
			{%
				\hbox to \textwidth%
				{%
					\if@fbs@existsSecondSection@
						\normalfont%
						\strut%
						% \scshape%
						\itshape
						\fbs@TitleColontitulBox%
						\normalfont%
						\hfil%
						\thepage%
						\normalfont%
					\else
						\normalfont%
						\strut%
						\thepage%
						\hfil%
						% \scshape%
						\itshape
						\fbs@TitleColontitulBox%
						\normalfont%
					\fi
				}%
				\hrule
			}%
		}%
	}%
	\makeatother%
}

% ================================== Языки =====================================

% TODO: возможно, стоит переделать работу с языками на команды, предоставляемые
% пакетом babel

\newcommand*{\fbsrussian}{%
	\selectlanguage{russian}%
	\fbs@russiantrue
	\fbs@englishfalse
	\fbs@dutchfalse
}

\newcommand*{\fbsenglish}{%
	\selectlanguage{english}%
	\fbs@russianfalse
	\fbs@englishtrue
	\fbs@dutchfalse
}

\newcommand*{\fbsdutch}{%
	\selectlanguage{dutch}%
	\fbs@russianfalse
	\fbs@englishfalse
	\fbs@dutchtrue
}

% ==============================================================================


% ==============================================================================


% ==============================================================================


\newlength{\fbs@preprint@length}
\setlength{\fbs@preprint@length}{1\parindent}

% Устанавливает значение \hangindent — втяжки абзаца
\newcommand*{\fbs@preprint}[2][1\parindent]%[1.5cm]%
{%
	\mal%
	% \settowidth{\fbs@preprint@length}{#1}%
	\setlength{\fbs@preprint@length}{#1}%
	\par
	\hangindent=\fbs@preprint@length\noindent{}#2%
	\mao%
}

\newcommand*{\fbs@CustomItem}[3]%
{%
	\mal%
	\def\fbs@CustomItem@check{\csname check#1\endcsname}%
	%
	% Проверка элемента № 1 в массиве, переданном в качестве аргумента
	\fbs@CustomItem@check(1)%					
	\ifemptydata\else						% Если первый элемент не пуст,
		\fbs@CustomItem@check(2)%	% то проверить ещё и второй.
		\bfseries%
		\ifemptydata							% Если второй элемент пуст,
			% то печатаем второй аргумент (aka первый после названия массива);
			\def\fbs@CustomItem@text{\textbf{#2:\ }}%	
		\else
			% иначе — третий (aka второй после названия массива).
			\def\fbs@CustomItem@text{\textbf{#3:\ }}%
		\fi
		\fbs@preprint{\fbs@CustomItem@text}%
		\normalfont%
	\fi%
	\mao%
}

% \fbs@PrintItem[разделитель]{Имя массива без '\'}
\newcommand*{\fbs@PrintItem}[2][, ]%
{%
	\ignorespaces%
	\mal%
	%
	\def\fbs@PrintItem@cnt{i#2}%
	\def\fbs@PrintItem@check{\csname check#2\endcsname}%
	\def\fbs@PrintItem@array{\csname #2\endcsname}%
	%
	\newcounter{\fbs@PrintItem@cnt}%
	\setcounter{\fbs@PrintItem@cnt}{1}%
	% Проверяем, не пуст ли элемент с номером имя_массиваi.
	% Результат проверки заносится в переменную с именем emptydata.
	\fbs@PrintItem@check(\the\value{\fbs@PrintItem@cnt})%
	\whiledo{\not\boolean{emptydata}}%
	{%
		\fbs@PrintItem@array(\the\value{\fbs@PrintItem@cnt})%
		\stepcounter{\fbs@PrintItem@cnt}%
		\fbs@PrintItem@check(\the\value{\fbs@PrintItem@cnt})%
		\ifthenelse{\not\boolean{emptydata}}{#1}{}%
	}%
	%
	\mao%
}
%	[разделитель]{Массив имён}{Массив ссылок}
\newcommand*{\fbs@PrintItemTwo}[3][\\]%
{%
	\ignorespaces%
	\makeatletter%
	%
	\def\fbs@PrintItem@count{i#2}%
  \def\fbs@PrintItem@ArrayNames@array{\csname #2\endcsname}%
  \def\fbs@PrintItem@ArrayNames@check{\csname check#2\endcsname}%
  %
  \def\fbs@PrintItem@ArrayLinks@array{\csname #3\endcsname}%
  \def\fbs@PrintItem@ArrayLinks@check{\csname check#3\endcsname}%
  %
  \newcounter{\fbs@PrintItem@count}%
  \setcounter{\fbs@PrintItem@count}{1}%
	\fbs@PrintItem@ArrayNames@check(\the\value{\fbs@PrintItem@count})%
	\whiledo{\not\boolean{emptydata}}%
	{%
		\fbs@PrintItem@ArrayNames@array(\the\value{\fbs@PrintItem@count})%
		\fbs@PrintItem@ArrayLinks@check(\the\value{\fbs@PrintItem@count})%
		\ifemptydata\else
			\ (\fbs@PrintItem@ArrayLinks@array(\the\value{\fbs@PrintItem@count}))%
		\fi
		\stepcounter{\fbs@PrintItem@count}%
		\fbs@PrintItem@ArrayNames@check(\the\value{\fbs@PrintItem@count})%
		\ifemptydata\else
			#1%
		\fi
	}%
	%
	\makeatother%	
}

% ==============================================================================

%	\fbstitle{Название фанфика}
\providecommand*{\fbstitle}[3][]%
{%
	\ifthenelse{\equal{#1}{}}{%
		\renewcommand*{\fbs@TitleColontitulBox}{#2}%
	}{%
		\renewcommand*{\fbs@TitleColontitulBox}{#1}%
	}%
	\renewcommand*{\fbs@TitleBox}{#2}%
	\renewcommand*{\fbs@FicLinkBox}{#3}%
}

%	\fbstitlefnt{Название фанфика}{Сноска}
\providecommand{\fbstitlefnt}[4][]%
{%
	\fbstitle[#1]{#2}{#3}%
	\renewcommand*{\fbs@TitleFootnoteBox}{#4}%
}

% \fbsauthors{Имя автора(-ов) (c URL-адресами на их страницы)
\providecommand*{\fbsauthors}[2]
{\readarray{fbs@AuthorsBox}{#1}\readarray{fbs@AuthorsLinkBox}{#2}}		

% \fbstranslators{Имя переводчика(-ов)}
\providecommand*{\fbstranslators}[2]
{\readarray{fbs@TranslatorsBox}{#1}\readarray{fbs@TranslatorsLinkBox}{#2}}

%\fbsbetas{Беты}
\providecommand*{\fbsbetas}[2]
{\readarray{fbs@BetasBox}{#1}\readarray{fbs@BetasLinkBox}{#2}}

%\fbsgammas{Гаммы}
\providecommand*{\fbsgammas}[2]
{\readarray{fbs@GammasBox}{#1}\readarray{fbs@GammasLinkBox}{#2}}

% \fbsfandom{фэндом(-ы)}
\providecommand*{\fbsfandom}[1]
{\readarray{fbs@FandomBox}{#1}}			

% Персонажи
\providecommand*{\fbscharacters}[1]
{\readarray{fbs@CharactersBox}{#1}}

% Пейринг                  
\providecommand*{\fbspairings}[1]
{\readarray{fbs@PairingBox}{#1}}

% \fbsrating{G / PG-13 / NC-17 / NC-21 / R}
\providecommand*{\fbsrating}[1]
{\readarray{fbs@RatingBox}{#1}}

% \fbsgenres{Жанры}
\providecommand*{\fbsgenres}[1]
{\readarray{fbs@GenresBox}{#1}}			

% \fbswarnings{Предупреждения}
\providecommand*{\fbswarnings}[1]
{\readarray{fbs@WarningsBox}{#1}}

% \fbswarnings{Метки}
\providecommand*{\fbsmarks}[1]
{\readarray{fbs@MarksBox}{#1}}

% Подсчёт страниц
\newarray\fbs@PageSuffixRus
\readarray{fbs@PageSuffixRus}{&а&ы&ы&ы&&&&&&&&&&&&&&&&}%
\newarray\fbs@PageSuffixEng
\readarray{fbs@PageSuffixEng}{&&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s&s}%

\providecommand*{\fbssize}[1]%
{%
	\makeatletter
	\renewcommand*{\fbs@SizeBox}%
	{%
		\makeatletter
		\@ifundefined{fbs@TotPages@getNum}{}%
		{%
			\MODULO{\fbs@TotPages@getNum}{10}{\fbs@TotPages@temp}%
			\ifnum \fbs@TotPages@getNum>9
				\ifnum \fbs@TotPages@getNum<20
					\let\fbs@TotPages@temp=\fbs@TotPages@getNum
				\fi
			\fi
			#1,\ \fbs@TotPages@getNum\ 
			\iflanguage{russian}{страниц}{}%
			\iflanguage{english}{page}{}%
			\ADD{\fbs@TotPages@temp}{1}{\fbs@TotPages@temp}%
			\iflanguage{russian}{\fbs@PageSuffixRus(\fbs@TotPages@temp)}{}%
			\iflanguage{english}{\fbs@PageSuffixEng(\fbs@TotPages@temp)}{}%
		}%
		\makeatother
	}%
	\makeatother
}

\renewcommand*{\fbs@PartsNumBox}%
{%
	\makeatletter
	\@ifundefined{fbs@TotSections@getNum}{}%
	{%
		\makeatletter
		\if@fbs@existsSecondSection@
			\fbs@TotSections@getNum
		\else
			1%
		\fi
	%	\ifnum \fbs@TotSections@getNum=0 1 \else \fbs@TotSections@getNum \fi%
		\makeatother
	}%
	\makeatother
}%

%% У команды \fbsstatus есть один аргумент --- целое число:
%% 1 --- в процессе;
%% 2 --- заморожен;
%% 3 --- завершён.
\providecommand*{\fbsstatus}[1]%
{%
	\renewcommand*{\fbs@StatusBox}{%
		\ifnum #1=1
			{\color{red}%
				\iflanguage{russian}{в~процессе}{}%
				\iflanguage{english}{in~progress}{}%
			}%
			\else\ifnum #1=2
				{\color{blue}%
					\iflanguage{russian}{заморожен}{}%
					\iflanguage{english}{frozen}{}%
				}%
				\else\ifnum #1=3
					{\color[rgb]{0,0.58,0}%
						\iflanguage{russian}{завершён}{}%
						\iflanguage{english}{completed}{}%
					}%
				\else
					\iflanguage{russian}{неверный параметр}{}%
					\iflanguage{english}{wrong parameter}{}%
				\fi
			\fi
		\fi
	}%
}

% \fbsdescription{Описание}
\providecommand{\fbsdescription}[1]%
{\renewcommand{\fbs@DescriptionBox}{#1}}

% \fbsdedication{Посвящение}
\providecommand{\fbsdedication}[1]%
{\renewcommand{\fbs@DedicationBox}{#1}}

% \fbspublication{Публикация на других ресурсах}
\providecommand{\fbspublication}[1]%
{\renewcommand{\fbs@PublicationBox}{#1}}

% \fbsauthorsComments{Комментарии автора}
\providecommand{\fbsauthorscomments}[1]%
{\renewcommand{\fbs@AuthorsCommentsBox}{#1}}

% \fbsauthorsnotes{Author's Notes}
\providecommand{\fbsauthorsnotes}[1]%
{\renewcommand{\fbs@AuthorsNotesBox}{#1}}

% \fbsnotes{Notes}
\providecommand{\fbsnotes}[1]%
{\fbsauthorsnotes{#1}}

% \fbssummary{Summary}
\providecommand{\fbssummary}[1]%
{\renewcommand{\fbs@SummaryBox}{#1}}

% \fbsdirection{Направленность}
\providecommand*{\fbsdirection}[1]%
{\renewcommand{\fbs@DirectionBox}{#1}}

% ==============================================

% Нумерация разделов заканчивается на уровне 0, то есть не начинается совсем.
\setcounter{secnumdepth}{0}

% !!!!!!!!!!!!!
% Почему не нужна эта команда?
%\renewcommand{\chaptermark}[1]{\markboth{#1}{#1}}

% \providecommand*{\fbssection}[1]%
% {\chapter*{#1}\addcontentsline{toc}{section}{#1}\markboth{#1}{}\stepcounter{fbs@TotSections@cnt}}

\providecommand*{\fbssection}[2][]{%
	\clearpage%
	\thispagestyle{plain}%
	%\rule{0pt}{0pt}%
	%\vspace*{50pt plus 10pt minus 10pt}%
	%\vspace*{6\baselineskip}%
	\vspace*{5\baselineskip}%
	%\hspace*{\parindent}%
	%\section*{#2}%
	\par\noindent
	{%
		\LARGE
		\bfseries
		%\flushleft
		\hyphenpenalty=10000%
		\rule{0pt}{0pt}%
		\hspace{1\parindent}%
		#2%
		\par
	}%
	%\bigskip
	\addvspace{1\baselineskip}%
	\ifthenelse{\equal{#1}{}}{%
		\addcontentsline{toc}{section}{#2}%
		\markboth{#2}{}%
	}{%
		\addcontentsline{toc}{section}{#1}%
		\markboth{#1}{}%
	}%
	\stepcounter{fbs@TotSections@cnt}%
}

%\providecommand*{\fbssection}[1]
%{\section*{#1}\addcontentsline{toc}{section}{#1}\markright{#1}\stepcounter{fbs@TotSections@cnt}}%


\providecommand*{\fbssubsection}[1]%
{\subsection*{#1}\addcontentsline{toc}{subsection}{#1}\markboth{#1}{}}

\providecommand*{\fbssubsubsection}[1]%
{\subsubsection*{#1}}

\providecommand*{\fbsparagraph}[1]%
{\paragraph*{#1}}

\providecommand*{\fbssubparagraph}[1]%
{\subparagraph*{#1}}

% =============================	Шапка и сведения ================================

\newcommand{\fbs@printnoindentitem}[4][]{%
	\ifthenelse{\equal{\csname #4\endcsname}{}}{}{%
		\begingroup
			\noindent
			\hangindent=1\parindent
			{\bfseries
				\iflanguage{russian}{#2}{}%
				\iflanguage{english}{#3}{}%
			}%
			\csname #4\endcsname
			% \par
		\endgroup
	}%
}

\newlength{\saveparindent}
\setlength{\saveparindent}{\parindent}

\newcommand{\fbs@printnoindentitempar}[3]{%
	\ifthenelse{\equal{\csname #3\endcsname}{}}{}%
	{%
		\medskip
		\noindent
		{\bfseries
			\iflanguage{russian}{#1}{}%
			\iflanguage{english}{#2}{}%
			\par
		}%
		\addpenalty{10000}%
		\begingroup
			%\setlength{\parindent}{0pt}
			\everypar{\hangindent=1\saveparindent}
			% \setlength{\parskip}{\medskipamount}
			\csname #3\endcsname
			% \expandafter\fbs@preprint{\csname #3\endcsname}%
			\par
		\endgroup
	}%
}

% Печать заголовка
\providecommand{\fbsmaketitle}
{%
%	\inputencoding{utf8}
	\makeatletter%
	\clearpage%
	\pagestyle{empty}%
	\setcounter{page}{-100}
%	\pagenumbering{empty}%
	\rule{0pt}{0pt}%
	\hrule%
	\vskip 0.5in%
	{\centering
	%\begin{center}
		\bfseries%
		\huge\fbs@TitleBox%
		\ifthenelse{\equal{\fbs@TitleFootnoteBox}{}}{}%
		{%
			\footnote{%
				\fbs@TitleFootnoteBox\par
			}%
		}%
		\ifthenelse{\equal{\fbs@FicLinkBox}{}}{}%
		{%
			\par
			\addvspace{1.5\bigskipamount}
			\large
			\fbs@FicLinkBox
		}%
		\par
	%\end  {center}
	}
	\par%
	\normalfont%
	\vskip 0.5in
	\hrule%
	\vspace{30pt}%
	%
	%
	\fbs@CustomItem{fbs@AuthorsBox}{%
		% \fbs@AuthorsBoxSingle
		\iflanguage{russian}{Автор}{}%
		\iflanguage{english}{Author}{}%
	}{%
		% \fbs@AuthorsBoxPlural
		\iflanguage{russian}{Авторы}{}%
		\iflanguage{english}{Authors}{}%
	}%
	\fbs@PrintItemTwo[\\]{fbs@AuthorsBox}{fbs@AuthorsLinkBox}

	\fbs@CustomItem{fbs@TranslatorsBox}{%
		\iflanguage{russian}{Переводчик}{}%
		\iflanguage{english}{Translator}{}%
	}{%
		\iflanguage{russian}{Переводчики}{}%
		\iflanguage{english}{Translators}{}%
	}%

	\fbs@PrintItemTwo[\\]{fbs@TranslatorsBox}{fbs@TranslatorsLinkBox}

	\fbs@CustomItem{fbs@BetasBox}{%{Бета}{Беты}%
		\iflanguage{russian}{Бета}{}%
		\iflanguage{english}{Beta}{}%
	}{%
		\iflanguage{russian}{Беты}{}%
		\iflanguage{english}{Betas}{}%
	}%

	\fbs@PrintItemTwo{fbs@BetasBox}{fbs@BetasLinkBox}

	% \fbs@CustomItem{fbs@GammasBox}{Гамма}{Гаммы}%
	\fbs@CustomItem{fbs@GammasBox}{%
		\iflanguage{russian}{Гамма}{}%
		\iflanguage{english}{Gamma}{}%
	}{%
		\iflanguage{russian}{Гаммы}{}%
		\iflanguage{english}{Gammas}{}%
	}%

	\fbs@PrintItemTwo{fbs@GammasBox}{fbs@GammasLinkBox}
	
	% \fbs@CustomItem{fbs@FandomBox}{Фэндом}{Фэндомы}%
	\fbs@CustomItem{fbs@FandomBox}{%
		\iflanguage{russian}{Фэндом}{}%
		\iflanguage{english}{Fandom}{}%
	}{%
		\iflanguage{russian}{Фэндомы}{}%
		\iflanguage{english}{Fandoms}{}%
	}%
	\fbs@PrintItem{fbs@FandomBox}%
	\checkfbs@FandomBox(2)%
	\ifthenelse{\boolean{emptydata}}{}%
	{%
		\ 
		(%
			\iflanguage{russian}{кроссовер}{}%
			\iflanguage{english}{crossover}{}%
		)%
	}%
	
	%\fbs@CustomItem{fbs@CharactersBox}{Основные персонажи}{Основные персонажи}%
	\fbs@CustomItem{fbs@CharactersBox}{%
		\iflanguage{russian}{Основные персонажи}{}%
		\iflanguage{english}{Main characters}{}%
	}{%
		\iflanguage{russian}{Основные персонажи}{}%
		\iflanguage{english}{Main characters}{}%
	}%
	\fbs@PrintItem{fbs@CharactersBox}

	% \fbs@CustomItem{fbs@PairingBox}{Пэйринг}{Пэйринги}%
	\fbs@CustomItem{fbs@PairingBox}{%
		\iflanguage{russian}{Пейринг}{}%
		\iflanguage{english}{Pairing}{}%
	}{%
		\iflanguage{russian}{Пейринги}{}%
		\iflanguage{english}{Pairings}{}%
	}%
	\fbs@PrintItem{fbs@PairingBox}

	% \fbs@CustomItem{fbs@RatingBox}{Рейтинг}{Рейтинги}%
	\fbs@CustomItem{fbs@RatingBox}{%
		\iflanguage{russian}{Рейтинг}{}%
		\iflanguage{english}{Rating}{}%
	}{%
		\iflanguage{russian}{Рейтинг}{}%
		\iflanguage{english}{Rating}{}%
	}%
	\fbs@PrintItem{fbs@RatingBox}

	\fbs@CustomItem{fbs@GenresBox}{%
		\iflanguage{russian}{Жанр}{}%
		\iflanguage{english}{Genre}{}%
	}{%
		\iflanguage{russian}{Жанры}{}%
		\iflanguage{english}{Genres}{}%
	}%
	\fbs@PrintItem{fbs@GenresBox}

	% \fbs@CustomItem{fbs@WarningsBox}{Предупреждения}{Предупреждения}%
	\fbs@CustomItem{fbs@WarningsBox}{%
		\iflanguage{russian}{Предупреждение}{}%
		\iflanguage{english}{Warning}{}%
	}{%
		\iflanguage{russian}{Предупреждения}{}%
		\iflanguage{english}{Warnings}{}%
	}%
	\fbs@PrintItem{fbs@WarningsBox}


%	\ifthenelse{\equal{\fbs@SizeBox}{}}{}%
	% {\noindent\textbf{Размер: }\fbs@SizeBox\par}
	% \fbs@printnoindentitem{Размер: }{Size: }{fbs@sizeBox}
	{\noindent\textbf{\iflanguage{russian}{Размер: }{}\iflanguage{english}{Size: }{}}\fbs@SizeBox\par}

%	\ifthenelse{\equal{\PartsNumBox}{}}{}%
	% {\noindent\textbf{Количество частей: }\fbs@PartsNumBox\par}
	\fbs@printnoindentitem{Количество частей: }{Number of parts: }{fbs@PartsNumBox}

	%\ifthenelse{\equal{\St@usBox}{}}{}%
	% {\noindent\textbf{Статус: \fbs@StatusBox}\par}
	\fbs@printnoindentitem{Статус: }{Status: }{fbs@StatusBox}

	% \ifthenelse{\equal{\fbs@DirectionBox}{}}{}%
	% {%
	% 	\noindent
	% 	\textbf{Direction:}
	% 	\fbs@DirectionBox%
	% 	\par
	% }%
	\fbs@printnoindentitem{Направленность: }{Direction: }{fbs@DirectionBox}

	% \ifthenelse{\equal{\fbs@DescriptionBox}{}}{}%
	% {\medskip\noindent\textbf{Описание:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@DescriptionBox\par}
	\fbs@printnoindentitempar{Описание:}{Description:}{fbs@DescriptionBox}
		
	% \ifthenelse{\equal{\fbs@DedicationBox}{}}{}%
	% {\medskip\noindent\textbf{Посвящение:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@DedicationBox\par}
	\fbs@printnoindentitempar{Посвящение:}{Dedication:}{fbs@DedicationBox}
		
	% \ifthenelse{\equal{\fbs@PublicationBox}{}}{}%
	% {\medskip\noindent\textbf{Публикация на других ресурсах:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@PublicationBox\par}
	\fbs@printnoindentitempar{%
		Публикация на других ресурсах:%
	}{%
		Publication on other resources:%
	}{fbs@PublicationBox}
	
	% \ifthenelse{\equal{\fbs@AuthorsCommentsBox}{}}{}%
	% {\medskip\noindent\textbf{Примечания автора:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@AuthorsCommentsBox\par}
	\fbs@printnoindentitempar{%
		Примечания автора:%
	}{%
		Author's Comments:%
	}{fbs@AuthorsCommentsBox}

	% \ifthenelse{\equal{\fbs@AuthorsNotesBox}{}}{}%
	% {\medskip\noindent\textbf{Author's Notes:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@AuthorsNotesBox\par}
	\fbs@printnoindentitempar{%
		Заметки автора:%
	}{%
		Author's Notes:%
	}{fbs@AuthorsNotesBox}

	% \ifthenelse{\equal{\fbs@SummaryBox}{}}{}%
	% {\medskip\noindent\textbf{Summary:}%
	% \par%
	% \addpenalty{10000}%
	% \fbs@SummaryBox\par}
	\fbs@printnoindentitempar{%
		Summary:%
	}{%
		Summary:%
	}{fbs@SummaryBox}
	\par
	\clearpage
	\makeatletter
	%\fbs@setpagestyle%
	\pagestyle{empty}
	\if@fbs@firstCompilation@
		\fbs@maketoc
	\fi
	\if@fbs@existsSecondSection@
 	% Оглавление
		\fbs@maketoc
	\fi
%	\fbs@maketoc
	\fbs@setpagestyle
	\makeatother%	
	\setcounter{page}{1}%
%	\inputencoding{\fbs@encoding}
}
%
\newcommand*{\fbs@maketoc}%
{%
	\mal
	\fbs@settocpagestyle
	\mao
	\tableofcontents
	\clearpage
}
%
\newcommand*{\fbsepauthorbox}{}
\newcommand*{\fbsepauthor}[1]{%
	\renewcommand*{\fbsepauthorbox}{#1}%
}
\newenvironment{fbsepigraph}[1]
{%	
	\ifthenelse{\equal{#1}{}}{}%
	{%
		\fbsepauthor{#1}
	}
	\par\begin{flushright}%
		\begin{minipage}{0.45\linewidth}%
}{%
	\par%
	\addpenalty{10000}%
	\addvspace{\bigskipamount}%
	\addpenalty{10000}%
	\hrule%
%	\begin{flushright}\textsl{\fbsepauthor}\end{flushright}%
	\addpenalty{10000}%
	\addvspace{\medskipamount}%
	\addpenalty{10000}%
	\hfill%
	\textsl{\fbsepauthorbox}%
	\end{minipage}\end{flushright}\par%
	\renewcommand{\fbsepauthor}[1]{}%
}


\newcommand*{\fbssignaturebox}{}
\newcommand{\fbssignature}[1]{\renewcommand*{\fbssignaturebox}{#1}}
\newenvironment{fbshandwritten}
{%
	\par%
	\addvspace{\bigskipamount}%
	\itshape%
}
{%
	\ifthenelse{\equal{\fbssignaturebox}{}}{}{%
		\par\noindent%
		\hspace*{\fill}\fbssignaturebox%
	}%
	\par%
	\addvspace{\bigskipamount}%
	\normalfont%
}

\newcommand{\epigraph}[2]{%
	\begin{fbsepigraph}{#2}
		#1
	\end{fbsepigraph}%
}

\newenvironment{fbsremark}[1][%
	\iflanguage{russian}{Примечание к части.}{}%
	\iflanguage{english}{Note.}{}%
]%
{%
	\addvspace{\bigskipamount}%
	\par%
	% \par
	%\noindent%
	\textbf{#1}%
	%\textbf{#1}
	\par
	%\indent
	\nopagebreak[4]%
	\makeatletter%
	\hangindent=1\fbs@indent
	\makeatother%
}%
{%
	\par%
	\addvspace{\bigskipamount}%
}

\newenvironment{fbremark}[1][%
	\iflanguage{russian}{Примечание к части.}{}%
	\iflanguage{english}{Note.}{}%
]{\begin{fbsremark}}{\end{fbsremark}}

% \usefont{ENC}{family}{series}{shape}
% \selectfont
\newenvironment{fbsitalic}%
{%
	\normalfont\itshape
}%
{%
	\normalfont
}

\newenvironment{fbsbold}%
{%
	\normalfont\bfseries
}%
{%
	\normalfont
}

\newenvironment{fbsupright}%
{%
	\normalfont\rmfamily
}%
{%
	\normalfont
}

\newlength{\textstarsverticallength}
%\setlength{\textstarsverticallength}{1em minus 0.3em}
%\setlength{\textstarsverticallength}{%
%	2.0ex
%	%plus  1ex
%	%minus 1\baselineskip
%}
\setlength{\textstarsverticallength}{0.79\baselineskip}

\newcommand*{\textstars}{%
	\begingroup
		\setlength{\parskip}{0pt}%
		\setlength{\parindent}{0pt}%
		\par
		\addpenalty{10000}%
		\addvspace{\textstarsverticallength}%
		\vbox{%
			%\hbox{%
			%	\rule{\textstarsverticallength}{\textstarsverticallength}%
			%}
			\hbox to \textwidth {%
				\hfill
				\raisebox{0pt}[0pt][0pt]{%
					%\ensuremath{-\ *\ *\ *\ -}%
					\ensuremath{*\ *\ *}%
				}%
				\hfill
			}
			%\hbox{%
			% \rule{\textstarsverticallength}{\textstarsverticallength}%
			%}%
		}%
		\par
		%\addpenalty{10000}%
		\addvspace{\textstarsverticallength}%
		%\vspace{\textstarsverticallength}%
	\endgroup
}

\newlength{\journalLength}
\setlength{\journalLength}{0.5\parindent}

\newenvironment{journal}[1][]{%
	\par%
	\addvspace{\bigskipamount}%
	\begingroup
	\sffamily
	\noindent
	%\centering
	\rule{0pt}{0pt}
	\hspace{\journalLength}
	\ifthenelse{\equal{#1}{}}{%
		\hrulefill
	}{%
		%\hbox to 0.7in {\hrulefill}
		%\hspace{\fill}
		\hrulefill
		\hspace{1em}%
		#1%
		\hspace{1em}%
		\hrulefill
		%\hspace{\fill}
		%\hbox to 0.7in {\hrulefill}
	}
	\hspace{\journalLength}
	\rule{0pt}{0pt}
	\par%
	\medskip
	%\sloppy
	%\hyphenpenalty=10000
}{%
	\par%
	\noindent
	\rule{0pt}{0pt}%
	\hspace{\journalLength}
	\hrulefill
	% \hbox to 0.7in {\hrulefill}
	\hspace{\journalLength}
	%\hfill
	\rule{0pt}{0pt}%
	\par
	\addvspace{\bigskipamount}%
	%\normalfont
	\endgroup
}

% \renewcommand*{\date}[1]{\fbsubsection{#1}}
\newcommand*{\shortruler}{%
\par\noindent\medskip{%
	\hspace*{\fill}%
	\hbox to 7cm {\hrulefill}%
	\hspace*{\fill}%
}%
\par\medskip}

\renewcommand*{\date}[1]{%
	\addvspace{%
		1\baselineskip
		plus
		0.5\baselineskip
		minus
		0.1\baselineskip
	}%
	{%
		\par
		\large
		\bfseries
		#1%
	}%
	\addcontentsline{toc}{subsection}{#1}%
	\markboth{#1}{}%
	\nopagebreak[4]%
	\vspace{0.5\baselineskip minus 0.1\baselineskip}%
	\par
}

\newcommand*{\spell}[1]{\textit{#1}}

\AtBeginDocument{%
	% Минимальное количество символов, оставляемое до переноса слова
	% См. newllang, 117.
	\righthyphenmin=2
	\lefthyphenmin=2

	% Растяжение пробелов.
	% Рекомендация — использовать в виде
	%
	% 	Абзац
	% 	{\sloppy\par}
	%
	% 	{Абзац
	% 	\sloppy\par}
	%
	% 	{\sloppy
	% 	Абзац
	% 	\par}
	%
	% или
	%
	% 	Абзац
	% 	\sloppy\par
	% 	\fuzzy

	% \sloppy
	% \fbs@russiantrue
}

\AtEndDocument%
{%
	\makeatletter%
	\immediate\write\@mainaux%
	{%
		\string\gdef\string\fbs@TotPages@getNum{\number\value{page}}\par
		\string\gdef\string\fbs@TotSections@getNum{\number\value{fbs@TotSections@cnt}}\par
		\ifnum \number\value{fbs@TotSections@cnt}>0%
			\string\global\string\@fbs@existsSecondSection@true\par
		\else
			\string\global\string\@fbs@existsSecondSection@false\par
		\fi
		\string\global\string\@fbs@firstCompilation@false\par
	}
	\makeatother%
}

%\ifthenelse{\equal{\fbs@encoding}{utf8}}{}%
%{%
%	\RequirePackage{soul}
%}%

%\inputencoding{\fbs@encoding}

\global\makeatother

\newcommand{\when}[1]{%
	\addvspace{1\baselineskip}%
	{\itshape #1}%
	\par%
	\addvspace{0.79\baselineskip}%
}%
\let\where=\when

\newcounter{commentcounter}
\setcounter{commentcounter}{0}
\renewcommand*{\thecommentcounter}{%
	%{\color[rgb]{1,0.2,0.1}
		\arabic{commentcounter})
	%}%
}

\newcommand*{\comment}[2]{%
%	{%
%		\color[rgb]{1,0.2,0.1}%
		#1%
%	}%
%	%\refstepcounter{commentcounter}%
%	\commentfootnote{#2}%
%	%\footnotemark{\thecommentcounter}%
%	%\footnotetext{#2}%
}

\newcounter{savefootnotecounter}

\newcommand*{\commentfootnote}[1]{%
	{
		\setcounter{savefootnotecounter}{\value{footnote}}%
		\setcounter{footnote}{\value{commentcounter}}%
		\renewcommand*{\thefootnote}{\arabic{footnote}]}%
		\footnote{#1}%
		\setcounter{footnote}{\value{savefootnotecounter}}%
	}%
}

\newcommand*{\langnameen}{%
	\iflanguage{russian}{англ.}{}%
	\iflanguage{english}{eng.}{}%
}
\newcommand*{\Langnameen}{%
	\iflanguage{russian}{Англ.}{}%
	\iflanguage{english}{Eng.}{}%
}
\newcommand*{\langnameru}{%
	\iflanguage{russian}{рус.}{}%
	\iflanguage{english}{rus.}{}%
}
\newcommand*{\Langnameru}{%
	\iflanguage{russian}{Рус.}{}%
	\iflanguage{english}{Rus.}{}%
}
\newcommand*{\langnamede}{%
	\iflanguage{russian}{нем.}{}%
	\iflanguage{english}{deut.}{}%
}
\newcommand*{\Langnamede}{%
	\iflanguage{russian}{Нем.}{}%
	\iflanguage{english}{Deut.}{}%
}
\newcommand*{\langnamefr}{%
	\iflanguage{russian}{фр.}{}%
	\iflanguage{english}{fr.}{}%
}
\newcommand*{\LangnameFr}{%
	\iflanguage{russian}{Фр.}{}%
	\iflanguage{english}{Fr.}{}%
}

\mal

\newif\if@capital@letter@

\newcommand*{\phrasetranslate}{%
	\@ifstar\@phrasetranslate@star\@phrasetranslate@
}

\newcommand*{\@phrasetranslate@star}{%
	\@capital@letter@false
	\@phrasetranslate
}

\newcommand*{\@phrasetranslate@}{%
	\@capital@letter@true
	\@phrasetranslate
}

\newcommand*{\@phrasetranslate}[3][de]{%
	{\csname text#1 \endcsname{\textit{#2}}}%
	\footnote{%
		%#2 (\textit{#3}) --- #4
		#3 (\textit{%
			%#3
			\if@capital@letter@
				\csname Langname#1\endcsname
			\else
				\csname langname#1\endcsname
			\fi
		})
	}%
}

\renewcommand*{\dots}{...}

\newcommand*{\handwr}[1]{\emph{#1}}

\mao

\let\fbsnewsection=\fbssection
\let\fbsection=\fbssection
\let\fbsubsection=\fbssubsection
\let\fbsubsubsection=\fbssubsubsection
\let\fbsubparagraph=\fbssubparagraph

\newcommand{\sms}[1]{%
	\begin{quote}
		\sffamily
		#1%
	\end{quote}%
}

\newcommand{\interlude}[1]{%
	\par
	\addvspace{\medskipamount}%
	{\itshape
		#1%
	\par}%
	\nopagebreak
	\addvspace{\medskipamount}%
}

\newcommand*{\myhref}[3][]{%
	\href[#1]{#2}{#3}%
	\protect\footnote{\url{#2}}%
}

\let\fnhref=\myhref

\renewcommand*{\thefootnote}{%
	\arabic{footnote})%
}

\makeatletter

\newcommand*{\redact}[1]{%
	\iffbs@redacton
		\footnote{%
			#1%
			. --- \textit{Прим. ред.}\par
		}%
	\fi
}

\newcommand{\corr}[2]{%
	\iffbs@redacton
		{\color{myredactwrong}\so{#1}}%
		{\color{myredactcorrect}#2}%
	\else
		#1%
	\fi
}

\makeatother

% vim:ts=2:sw=2:nolist
