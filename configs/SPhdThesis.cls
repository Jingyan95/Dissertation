
% SPhdThesis v1.0
% By Saurabh Garg (saurabhgarg@mysoc.net)
% Version 1.0 released 11.06.2013
% -----------------------------------------------------------------------------
% Modified by Jack Li, September 2023

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SPhdThesis}[2013/06/11 v1.0 SPhdThesis class]

\RequirePackage{xkeyval}
\RequirePackage{fontawesome}%Icon for copy right

% -----------------------------------------------------------------------------
% Define option for formatting for [screen] and print.
% When formatting for screen colors are used for links, tables, and algorithms.
% When formatting for print black color is used for links, tables, and algorithms.
\define@choicekey*[Sg]{PhDThesis}{media}{screen,print}[screen]{\def \SgIntMedia{#1}}
\setkeys[Sg]{PhDThesis}{media}

% -----------------------------------------------------------------------------
% Define option for formatting title page in lower or [upper] case.
\define@choicekey*[Sg]{PhDThesis}{titlecase}{upper,lower}[upper]{\def \SgIntTitleCase{#1}}
\setkeys[Sg]{PhDThesis}{titlecase}

% -----------------------------------------------------------------------------
% Define line spacing. The valid values are [onehalf] and double.
% Note that before using \SgLineSpacing setspace package must be loaded.
\define@choicekey*[Sg]{PhDThesis}{linespacing}[\val\nr]{onehalf,double}[onehalf]{%
	\ifcase\nr\relax
		\def \SgIntLineSpacing{\onehalfspacing}
	\or
		\def \SgIntLineSpacing{\doublespacing}
	\fi
}
\setkeys[Sg]{PhDThesis}{linespacing}

% -----------------------------------------------------------------------------
% Define font size. The valid values are [11pt] and 12pt.
\define@choicekey*[Sg]{PhDThesis}{fontsize}{11pt,12pt}[11pt]{\def \SgIntFontSize{#1}}
\setkeys[Sg]{PhDThesis}{fontsize}

% -----------------------------------------------------------------------------
% Define font family to be used. Default is cm.
\define@choicekey*[Sg]{PhDThesis}{font}{cm,times,helvet,palatino}[cm]{\def \SgIntFont{#1}}
\setkeys[Sg]{PhDThesis}{font}

% -----------------------------------------------------------------------------
% Define open. The valid values are right and [any].
% Right makes chapters and entries in frontmatter begin  only on right hand pages 
% or on the next page available. Any puts them on the next available page.
\define@choicekey*[Sg]{PhDThesis}{open}[\val\nr]{right,any}[any]{%
	\ifcase\nr\relax
		\def \SgIntOpen {openright}
	\or
		\def \SgIntOpen {openany}
	\fi
}
\setkeys[Sg]{PhDThesis}{open}

% -----------------------------------------------------------------------------
% Define pageside. The valid values are oneside and [twoside].
% Specifies whether double or single sided output should be generated.
\define@choicekey*[Sg]{PhDThesis}{pageside}{oneside,twoside}[twoside]{\def \SgIntPageSide{#1}}
\setkeys[Sg]{PhDThesis}{pageside}


% Process all options defined above with default values.
\ProcessOptionsX[Sg]<PhDThesis>

% Finally load the report class.
\LoadClass[a4paper, \SgIntFontSize, \SgIntOpen, \SgIntPageSide]{report}



% -----------------------------------------------------------------------
% F O N T S.

\RequirePackage[T1]{fontenc}  % Use T1 encoded cm-super fonts.
\RequirePackage{microtype}    % Improve typesetting.
\RequirePackage{fix-cm}       % Support for arbitrary font size for cm.

% Specify the format for the section titles in toc.
\newcommand{\SgIntTocSectionFormat}{\sffamily\bfseries}

% Specify the format for chapter name and number in chapter headings.
\setcounter{chapter}{-1}
\newcommand{\SgIntChapNameFormat}{\fontsize{20}{50}\fontshape{sc}\selectfont}
\newcommand{\SgIntChapNumberFormat}{\fontsize{76}{80}\selectfont\textcolor{red}}

% Specify the format for chapter, section, and subsection titles.
\newcommand{\SgIntChapTitleFormat}{\LARGE\sffamily\bfseries}
\newcommand{\SgIntSecTitleFormat}{\Large\sffamily}
\newcommand{\SgIntSubsecTitleFormat}{\large\sffamily}

% Specify the format for displaying chapter in fancy header.
\newcommand{\SgIntHeaderFormat}{\large\sffamily\bfseries}
\newcommand{\SgIntPageNumFormat}{\sffamily\bfseries}

% small pmatrix
\newenvironment{psmallmatrix}
  {\left(\begin{smallmatrix}}
  {\end{smallmatrix}\right)}

% -----------------------------------------------------------------------------
% C A P T I O N S
% 
% Nicer captions for figures and tables. 
% caption package must be included before subfig and hyperref.

% Change the font of the caption to sans serif and make label bold.
\RequirePackage[textfont={sf}, labelfont={bf,sf}]{caption}
\RequirePackage{multirow}



% -----------------------------------------------------------------------
% P A C K A G E S
% 
% Include important packages.

\RequirePackage{graphicx, subfig}                     % Figures.
\RequirePackage{amsmath, amssymb, amsthm, sansmath}             % Math symbols and fonts.
\RequirePackage{upgreek}
\RequirePackage{float}                                % Must be done before hyperref.
\RequirePackage[usenames,dvipsnames,hyperref]{xcolor} % For defining colors.
\RequirePackage{ifthen}                               % For comparison.

% -----------------------------------------------------------------------
% MACRO
\input{configs/marco}

% -----------------------------------------------------------------------
% P A G E   L A Y O U T.

% Use geometry package to set up margins.
% A4 paper is 8.27 x 11.69 inch.
\RequirePackage[a4paper, left=1.25in, right=1in, top=1in, bottom=1in, includehead, \SgIntPageSide]{geometry}

\ifthenelse{\equal{\SgIntOpen}{openright}}
{
	% For adding extra blank page, if necessary, after chapter.
	\RequirePackage{emptypage}
	
	% Define a command to leave a blank page. This is used in frontmatter to add 
	% an empty page between ack, abstract, toc, lof and lot.
	\newcommand{\SgIntClearDoublePage}{\clearpage{\pagestyle{empty}\cleardoublepage}}
}
{
	\newcommand{\SgIntClearDoublePage}{\clearpage}
}

% For disabling paragraph indenting and using a blank line between paragraphs.
\RequirePackage{parskip}

% Set line spacing.
\RequirePackage{setspace}
\SgIntLineSpacing

% Fix footnote spacing
\setlength{\footnotesep}{0.5cm}   % Distance between two footnotes.
\setlength{\skip\footins}{0.5cm}  % Distance between last line of text and first footnote.

% By default Latex centers images vertically on a float page.
% Modify Latex internal variables so that figures are placed from top.
\makeatletter
    \setlength{\@fptop}{0.25cm}
    \setlength{\@fpsep}{1.00cm}
\makeatother

\setlength{\textfloatsep}{1.5cm} % Set the distance between a float and text.
\setlength{\floatsep}{1.0cm}     % Set the distance between two floats.

% Prevent latex from adding extra space between paragraphs so that
% the last line is at the bottom margin on each page.
\raggedbottom

% Define horizontal spacing between subfigures.
\newcommand{\SgIntHSpaceBetweenSubfloats}{\hspace{0.5cm}}



% -----------------------------------------------------------------------
% T A B L E
% 
% Set table layout and design.

\RequirePackage{booktabs, colortbl} % Tables.
\RequirePackage{tabularx}           % Auto column sizing.

\renewcommand{\arraystretch}{1.5}     % Set space between rows in a table.
\renewcommand{\tabcolsep}{0.20cm}     % Set space between columns in a table.
\heavyrulewidth = 0.15em              % Set width of heavy rules.
\lightrulewidth = 0.07em              % Set width of light rules.
\abovetopsep    = 0.1cm               % Set separation between caption and top rule.
\aboverulesep   = 0.4ex               % Set separation to use above a rule.
\belowrulesep   = 0.4ex               % Set separation to use below a rule.

% Set color for table rules.
\ifthenelse{\equal{\SgIntMedia}{screen}}{\arrayrulecolor[rgb]{0.0, 0.6, 0.9}}{}
\ifthenelse{\equal{\SgIntMedia}{print}}{\arrayrulecolor[rgb]{0.0, 0.0, 0.0}}{}



% -----------------------------------------------------------------------
% A L G O R I T H M

\RequirePackage[algo2e, ruled, linesnumbered, algochapter]{algorithm2e}
\DontPrintSemicolon                      % Dont print semicolons at end of lines.
\algoheightrule       = \heavyrulewidth  % Set the width of the top and bottom rules.
\algotitleheightrule  = \lightrulewidth  % Set the width of the middle rule.
\SetAlgoInsideSkip{medskip}              % Set distance between middle rule and algorithm.
\interspacetitleruled = 0.2cm            % Set distance between caption and rules.
\setlength{\algomargin}{2.25em}          % Set the margin of the algorithm text.
\SetNlSkip{1.25em}                       % Set the spacing between line numbers and text.

\newenvironment{SgAlgorithm}[1][t]
{%
	\begin{algorithm2e}[#1]
    \linespread{1.3} % Set the line spacing to one and half.
    \selectfont      % The linespread is effective only after selectfont.%
}
{%
	\end{algorithm2e}
}



% -----------------------------------------------------------------------
% B I B L I O G R A P H Y

% Rename bibliography to references.
\renewcommand{\bibname}{References}

% Define a new command to include the bibliography file and 
% set the formatting options.
\newcommand{\SgIncludeBib}[1]
{%
	\clearpage                                 % Fix the page number in TOC.
	\phantomsection                            % Fix the link in PDF.
	\addcontentsline{toc}{chapter}{References} % Add the bibliography to TOC.
	\bibliographystyle{configs/unsrturl}                  % Set the bibliography style.
	\bibliography{#1}                          % Include the bibliography file.
}

% -----------------------------------------------------------------------
% F A N C Y   H E A D E R

\RequirePackage{fancyhdr}

% Set page style to fancy.
\pagestyle{fancy}

% By default fancyhdr converts the chapter headings to uppercase,
% so restore the chapter casing.
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}

% Define header consisting of Chapter #. Chapter_Name on left side and 
% page number on right side.
% \nouppercase is used on left header to force bibliography in lowercase.
\fancyhead{} 
\fancyhead[L]{\nouppercase{\SgIntHeaderFormat\leftmark}}
\fancyhead[R]{\SgIntPageNumFormat\thepage}
\renewcommand{\headrulewidth}{1pt}
\addtolength{\headheight}{10pt}

% Disable footer.
\fancyfoot{}
\renewcommand{\footrulewidth}{0pt}

% Define header and footer for plain pages.
\fancypagestyle{plain}
{%
    % Disable header.
    \fancyhead{}
    \renewcommand{\headrulewidth}{0pt}
    
    % Footer contains the page number on right side.
    \fancyfoot{}
    \fancyfoot[R]{\SgIntPageNumFormat\thepage}
    \renewcommand{\footrulewidth}{0pt}
}

% -----------------------------------------------------------------------
% Acronyms
% 
% 
\RequirePackage{acronym}

% -----------------------------------------------------------------------
% T O C    L O F    L O T    L O A
% 
% Change the appearance of toc, lof, lot, etc.

% Using tocloft, the toc can be formatted easily.
\RequirePackage[titles, subfigure]{tocloft}

%% Remove dots.
%\renewcommand{\cftdotsep}{\cftnodots}

% Remove dots from list of algorithms.
% This is necessary because we use algorithm2e which mananges its own list of algorithms.
\makeatletter
	\renewcommand{\@dotsep}{5000}
\makeatother

% Format chapter entries differently in toc.
\renewcommand{\cftchapfont}{\SgIntTocSectionFormat}

% Fix the indentation of figure and table entries in the lof, lot, and loa.
\setlength{\cftfigindent}{0in}
\setlength{\cfttabindent}{0in}

\newcommand{\SgAddToc}{\renewcommand\contentsname{Table of Contents}\subpdfbookmark{Table of Contents}{}\tableofcontents\SgIntClearDoublePage}

\makeatletter%Add a chapter outside of a part
\newcommand{\ChapterOutsidePart}{%
   \def\toclevel@chapter{-1}\def\toclevel@section{0}\def\toclevel@subsection{1}}
\newcommand{\ChapterInsidePart}{%
   \def\toclevel@chapter{0}\def\toclevel@section{1}\def\toclevel@subsection{2}}
\makeatother

\makeatletter%Add description to a part
\let\old@endpart\@endpart
\renewcommand\@endpart[1][]{%
\begin{quote}#1\end{quote}%
\old@endpart}
\makeatother

\RequirePackage{titlesec}%Add text to part page
\titleclass{\part}{top}
\titleformat{\part}[display]
  {\huge\bfseries\centering\color{red}}{\partname~\thepart}{0pt}{}
\titlespacing*{\part}{0pt}{1.25in}{1in}

\setcounter{tocdepth}{1}%Only show parts, chapters, and sections in TOC
\renewcommand{\cftpartfont}{\color{red}\sffamily\bfseries}%chapter font in TOC
\setlength{\cftbeforepartskip}{9pt}%part spacing
\renewcommand{\cftchapfont}{\sffamily\bfseries}%chapter font in TOC
\renewcommand{\cftchappagefont}{\sffamily\bfseries}%chapter page font in TOC
\setlength{\cftbeforechapskip}{3pt}%chap spacing
\renewcommand{\cftsecfont}{\sffamily}
\renewcommand{\cftsecpagefont}{\sffamily}
\renewcommand{\cftsubsecfont}{\sffamily}
\renewcommand{\cftsubsecpagefont}{\sffamily}
\newcommand{\SgAddLof}{%
	\newpage
	\phantomsection % Requires hyperref; this is to fix the link.
	\addcontentsline{toc}{section}{\numberline{}\hspace{-.35in}{\SgIntTocSectionFormat{}List of Figures}}
	\listoffigures
	\SgIntClearDoublePage
}
\renewcommand\cftfigfont{\sffamily}%font in list of figure entry
\renewcommand\cftfigpagefont{\sffamily}
\newcommand{\SgAddLot}{%
	\newpage
	\phantomsection % Requires hyperref; this is to fix the link.
	\addcontentsline{toc}{section}{\numberline{}\hspace{-.35in}{\SgIntTocSectionFormat{}List of Tables}}
	\listoftables
	\SgIntClearDoublePage
}
\renewcommand*{\acsfont}[1]{\sffamily #1}
\newcommand{\SgAddAcr}{%
	\newpage
	\phantomsection % Requires hyperref; this is to fix the link.
	\addcontentsline{toc}{section}{\numberline{}\hspace{-.35in}{\SgIntTocSectionFormat{}List of Acronyms}}
	\thispagestyle{plain}
	\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
%	\sectionfont{\LARGE\bfseries\sffamily}
	\chapter*{List of Acronyms}
	\lhead{\sffamily\bfseries{List of Acronyms}}
	\input{configs/acronym}
	\SgIntClearDoublePage
	\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}
}
\renewcommand\cfttabfont{\sffamily}%font in list of tables entry
\renewcommand\cfttabpagefont{\sffamily}
\newcommand{\SgAddLoa}{%
	\newpage
	\phantomsection % Requires hyperref; this is to fix the link.
	\addcontentsline{toc}{section}{\numberline{}\hspace{-.35in}{\SgIntTocSectionFormat{}List of Algorithms}}
	\listofalgorithmes % Note an extra e, it is required because we use algorithm2e.
	\SgIntClearDoublePage
}



% -------------------------------------------------------------------------------------
% C H A P T E R   H E A D I N G
% 
% Change the appearance of chapter headers and section titles.

% Change the fonts for chapter heading.
\RequirePackage[Lenny]{fncychap}
\ChNameVar{\SgIntChapNameFormat}
\ChNumVar{\SgIntChapNumberFormat}
\ChTitleVar{\SgIntChapTitleFormat}

% Set the format of the section and subsection titles.
\RequirePackage{sectsty}
\sectionfont{\SgIntSecTitleFormat}
\subsectionfont{\SgIntSubsecTitleFormat}

% Adjust the spacing between titles and surrounding matter.
\RequirePackage{etoolbox}
\makeatletter
	% Reduce the space between chapter title and text.
	\patchcmd{\DOTI}{\vskip 40\p@}{\vskip 20\p@}{}{}
	\patchcmd{\DOTIS}{\vskip 40\p@}{\vskip 20\p@}{}{}% for unnumbered chapters
	
	% http://tex.stackexchange.com/questions/13357/fncychap-package-reduce-vertical-gap-space-between-header-and-chapter-heading
	% Reduce the spacing between top margin and chapter title.
	\renewcommand*{\@makechapterhead}[1]
	{%
		\vspace*{10\p@}
		{%
			\parindent \z@ \raggedright \normalfont
			\ifnum \c@secnumdepth >\m@ne
				\if@mainmatter % Fix for frontmatter, mainmatter, and backmatter 040920
					\DOCH
				\fi
			\fi    
			\interlinepenalty\@M    
			\if@mainmatter     % Fix for frontmatter, mainmatter, and backmatter 060424
				\DOTI{#1}%
			\else%      
				\DOTIS{#1}%
			\fi
		}
	}
	
	% For the case \chapter*:
	\renewcommand*{\@makeschapterhead}[1]
	{%
		\vspace*{10\p@}%
		{%
			\parindent \z@ \raggedright \normalfont 
			\interlinepenalty\@M \DOTIS{#1} \vskip 10\p@
		}
	}
\makeatother



% -----------------------------------------------------------------------
% H Y P E R E F
% 
% Set hyperlink settings.

\RequirePackage[hyphens]{url} % Embedding URL's in document.

% Enable hyperlinks only in the PDF.
\RequirePackage[bookmarks=true, pdfstartview=Fit, linktoc=page, pdfpagemode=UseNone, pagebackref]{hyperref}
\renewcommand*{\backrefalt}[4]{
    \ifcase #1 %
        \relax 
    \or 
        (Cited on page #2.) 
    \else 
        (Cited on pages #2.) 
    \fi
}

%capitalize chapter in autoref
\AtBeginDocument{\def\chapterautorefname{Chapter}}%
\AtBeginDocument{\def\sectionautorefname{Section}}%

% Define the colors of the hyperlink.
\ifthenelse{\equal{\SgIntMedia}{screen}}
{%
	\definecolor{webgreen}{rgb}{0,.5,0} % previously used magenta.
	\definecolor{webblue}{rgb}{0,0,1}   % previously used orange.
	
	\hypersetup
	{%
		colorlinks = true,
		linkcolor  = red,%
		citecolor  = cyan,
		urlcolor   = webblue
	}
}{}
\ifthenelse{\equal{\SgIntMedia}{print}}
{%
	\hypersetup{colorlinks=false,pdfborder={0 0 0}}
}{}

% Define the proerties describing PDF.
\newcommand{\SgIntSetupPdfProps}%
{%
	\hypersetup
	{%
		pdfauthor   = \SgIntAuthor, 
		pdftitle    = \SgIntTitle, 
		pdfsubject  = \SgIntSubject, 
		pdfkeywords = \SgIntKeywords
	}
}



% -----------------------------------------------------------------------
% D O C U M E N T   P R O P E R T I E S
% 
% Important variables used for creating PDF properties and the title page.

% Define empty variables for creating title and setting PDF properties.
\newcommand{\SgIntTitle}{}
\newcommand{\SgIntAuthor}{}
\newcommand{\SgIntAuthorDegrees}{}
\newcommand{\SgIntYear}{}
\newcommand{\SgIntSubject}{}
\newcommand{\SgIntKeywords}{}
\newcommand{\SgIntDegree}{}
\newcommand{\SgIntDepartment}{}
\newcommand{\SgIntUniversity}{}
\newcommand{\SgIntDeclarationDate}{}

% Define commands for setting  the above variables.
\newcommand{\SgSetTitle}[1]{\renewcommand{\SgIntTitle}{#1}\SgIntSetupPdfProps}
\newcommand{\SgSetAuthor}[1]{\renewcommand{\SgIntAuthor}{#1}\SgIntSetupPdfProps}
\newcommand{\SgSetAuthorDegrees}[1]{\renewcommand{\SgIntAuthorDegrees}{#1}}
\newcommand{\SgSetYear}[1]{\renewcommand{\SgIntYear}{#1}}
\newcommand{\SgSetSubject}[1]{\renewcommand{\SgIntSubject}{#1}\SgIntSetupPdfProps}
\newcommand{\SgSetKeywords}[1]{\renewcommand{\SgIntKeywords}{#1}\SgIntSetupPdfProps}
\newcommand{\SgSetDegree}[1]{\renewcommand{\SgIntDegree}{#1}}
\newcommand{\SgSetDepartment}[1]{\renewcommand{\SgIntDepartment}{#1}}
\newcommand{\SgSetUniversity}[1]{\renewcommand{\SgIntUniversity}{#1}}
\newcommand{\SgSetDeclarationDate}[1]{\renewcommand{\SgIntDeclarationDate}{#1}}



% -----------------------------------------------------------------------
% C L E V E R E F
% 
% Must come as late as possible, especially after hyperref.
\RequirePackage[capitalize]{cleveref}

% Disable the automatic abbreviations of equations and figures.
\crefname{equation}{Equation}{Equations}
\crefname{figure}{Figure}{Figures}
\Crefname{equation}{Equation}{Equations}
\Crefname{figure}{Figure}{Figures}

% Change the way links are produced in PDF documents.
\crefformat{chapter}{#2Chapter~#1#3}
\crefformat{section}{#2Section~#1#3}
\crefformat{figure}{#2Figure~#1#3}
\crefformat{equation}{#2Equation~#1#3}
\crefformat{table}{#2Table~#1#3}
\Crefformat{chapter}{#2Chapter~#1#3}
\Crefformat{section}{#2Section~#1#3}
\Crefformat{figure}{#2Figure~#1#3}
\Crefformat{equation}{#2Equation~#1#3}
\Crefformat{table}{#2Table~#1#3}
\creflabelformat{equation}{#2#1#3}



% -----------------------------------------------------------------------
% T I T L E  P A G E
\ifthenelse{\equal{\SgIntTitleCase}{upper}}
{
	\newcommand{\SgIntMakeUpperCase}[1]{\MakeUppercase{#1}}
}
{
	\newcommand{\SgIntMakeUpperCase}[1]{#1}
}
\newcommand{\SgAddTitle}{%
	\thispagestyle{empty}
	\begin{center}
	         \bfseries
		\vspace*{0.5in}
		\Large\boldmath\textcolor{red}{\SgIntMakeUpperCase{\SgIntTitle}}
		\\
		\vspace{2.2in}

		\large{\SgIntMakeUpperCase{\SgIntAuthor}} \\
		\large{\emph{\SgIntAuthorDegrees}} \\
		\vspace{2.5in}

		\large{\SgIntMakeUpperCase{A Dissertation submitted in partial fulfillment of the requirements for the Degree of \SgIntDegree}}
		\vspace{0.2in}

		\large{\SgIntMakeUpperCase{\SgIntDepartment}} \\
		\large{\SgIntMakeUpperCase{\SgIntUniversity}} \\
		\vspace{0.2in} 

		\large{\SgIntYear}
	\end{center}
	\SgIntClearDoublePage
}



% -----------------------------------------------------------------------
% D E C L A R A T I O N  P A G E
\newcommand{\SgAddDeclaration}[1][nosignimage]{%
	\newpage
	\thispagestyle{plain}
	\begin{center}
	\vspace*{7.7cm}
	\large\bfseries
\faCopyright~2023 Jingyan Li\\
ALL RIGHTS RESERVED
	\end{center}
%	\vspace*{1.5cm}
%	{
%		\Large \bfseries Declaration
%	}
%	\end{center}
%
%	\vspace{0.5cm}
%
%	\begin{quote}
%	I hereby declare that this thesis is my original work and it has been written by me in its entirety. I have duly acknowledged all the sources of information which have been used in the thesis. \newline
%
%	This thesis has also not been submitted for any degree in any university previously.
%	\end{quote}
%
%	\ifthenelse{\equal{#1}{nosignimage}}
%	{
%	    \vspace{2.0cm}
%	}
%	{
%		\vspace{0.5cm}
%	}
%
%	\begin{center}
%		\ifthenelse{\equal{#1}{nosignimage}}
%		{}{\includegraphics{#1}\\[-0.5cm]}
%		\rule{5cm}{0.2mm} \\
%		\SgIntAuthor \\
%		\SgIntDeclarationDate
	\SgIntClearDoublePage
}



% -----------------------------------------------------------------------
% A C K N O W L E D G M E N T S
% 
% The acknowledgments environment puts a large, bold, centered 
% "Acknowledgments" label at the top of the page. The acknowledgments
% themselves appear in a quote environment, i.e. tabbed in at both 
% sides, and on its own page.
\RequirePackage{CJKutf8}
\newenvironment{acknowledgments}%
{%
	\thispagestyle{plain}
	\begin{center}
		\vspace*{1.5cm}
		{%
			\Large \bfseries \begin{CJK*}{UTF8}{gbsn}
                     致谢
                         \end{CJK*}
		}
	\end{center}
	\vspace{0.5cm}
	\begin{quote}
}
{%
    \end{quote}
	\SgIntClearDoublePage
}

\newenvironment{dedication}%
{%
	\thispagestyle{plain}
	\begin{center}
		\vspace*{1.5cm}
		{%
			\Large \bfseries Dedication
		}
	\end{center}
	\vspace{0.5cm}
	\begin{quote}
}
{%
    \end{quote}
	\SgIntClearDoublePage
}



% -----------------------------------------------------------------------
% A B S T R A C T
% 
% The abstract environment puts a large, bold, centered "Abstract" label at
% the top of the page. The abstract itself appears in a quote environment,
% i.e. tabbed in at both sides, and on its own page.
\renewenvironment{abstract}
{%
    \thispagestyle{plain}
	\begin{center}
		\vspace*{1.5cm}
		{\Large\bfseries Abstract}
	\end{center}
	\vspace{0.5cm}
	\begin{quote}
}
{%
    \end{quote}
	\SgIntClearDoublePage
}



% -----------------------------------------------------------------------
% F R O N T M A T T E R
% 
% The frontmatter environment set the page numbering to lowercase roman for 
% ack, abstract, toc, lof, lot, loa, etc. It also resets page numbering for the 
% remainder of thesis (arabic, starting at 1).
\newenvironment{frontmatter}
{%
 	\setcounter{page}{1}
	\renewcommand{\thepage}{\roman{page}}
}
{%
	\clearpage
	\renewcommand{\thepage}{\arabic{page}}
	\setcounter{page}{1}
	\SgIntClearDoublePage
}