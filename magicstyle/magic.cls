% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAGIC Lab (NUS) pre-print style
% https://magiclab-nus.github.io/
%
% Class options:
%   nologo     hide the MAGIC Lab logo on the title page
%   (any other option is passed to the standard article class)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{magicstyle/magic}[2026/10/03 MAGIC Lab pre-print style]

\newif\ifmagic@logo
\magic@logotrue
\DeclareOption{nologo}{\magic@logofalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[english]{babel}
\RequirePackage{etoolbox}

% Graphics and tables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{bm}

% Colors (taken from magiclab-nus.github.io) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\PassOptionsToPackage{dvipsnames,table}{xcolor}
\RequirePackage{xcolor}
\RequirePackage[most]{tcolorbox}
\definecolor{magicnavy}{HTML}{153455}  % titles and headings
\definecolor{magicblue}{HTML}{0088FF}  % accents
\definecolor{magiclink}{HTML}{1F5A93}  % links and citations
\definecolor{magictext}{HTML}{233143}  % body text
\definecolor{magicmuted}{HTML}{5A697A} % secondary text
\definecolor{magicmist}{HTML}{EEF3F8}  % abstract box and table highlights

\AtBeginDocument{\color{magictext}}

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[round,authoryear]{natbib}
\def\bibfont{\small}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true, allcolors=magiclink}
\RequirePackage[noabbrev,nameinlink]{cleveref}
% Reapply after cleveref so the colors stick.
\AtBeginDocument{\hypersetup{colorlinks=true, allcolors=magiclink}}

% Fonts: Manrope for headings, default serif for body %%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{iftex}
\ifPDFTeX
    \RequirePackage[T1]{fontenc}
    \RequirePackage{magicstyle/manrope}
    \renewcommand{\sfdefault}{manrope}
\else
    \RequirePackage{fontspec}
    \setsansfont{Manrope}[
        Path=magicstyle/manrope/,
        Extension=.ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold]
\fi

% Font size helpers
\newcommand{\slightlylarger}{%
  \fontsize{\dimexpr\f@size pt+1}{\dimexpr\f@size pt-0.2\baselineskip}\selectfont%
}
\newcommand{\slightlysmaller}{%
  \fontsize{\dimexpr\f@size pt-1}{\dimexpr\f@size pt+0.2\baselineskip}\selectfont%
}

% Section and caption format %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
\titleformat*{\section}{\Large\sffamily\bfseries\color{magicnavy}}
\titleformat*{\subsection}{\large\sffamily\bfseries\color{magicnavy}}
\titleformat*{\subsubsection}{\slightlylarger\sffamily\bfseries\color{magicnavy}}
\titleformat*{\paragraph}{\slightlysmaller\sffamily\bfseries}

% Bold text is set in Manrope, slightly smaller to match the serif body.
\DeclareTextFontCommand{\textbf}{\fontsize{9}{11}\selectfont\bfseries\sffamily}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=false,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Title page fields %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   \author[1,2]{Name}        affiliation numbers go in the optional argument
%   \affiliation[1]{NUS}
%   \contribution[*]{Equal contribution}
%   \metadata[Code:]{\url{...}}
%   \correspondence{\email{...}}
%   \date{...}

% \magic@addto[<sup>]{<content>}{<list>}{<formatter>}{<separator>}
\newcommand\magic@addto[5][]{%
  \ifdefempty{#3}{\gappto#3{#4[#1]{#2}}}{\gappto#3{#5#4[#1]{#2}}}%
}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\sffamily\bfseries #2\textsuperscript{#1}}}
\renewcommand\author[2][]{\magic@addto[#1]{#2}{\authorlist}{\authorformat}{\quad }}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\normalsize \textsuperscript{#1}#2}}
\newcommand\affiliation[2][]{\magic@addto[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\small \textsuperscript{#1}#2}}
\newcommand\contribution[2][]{\magic@addto[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand\metadatalist{}
\newcommand\metadataformat[2][]{{\small {\sffamily\bfseries #1} #2}}
\newcommand\metadata[2][]{\magic@addto[#1]{#2}{\metadatalist}{\metadataformat}{\par}}

\newcommand\abstractlist{}
\renewcommand{\abstract}[1]{\def\abstractlist{#1}}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}

\renewcommand\date[1]{\metadata[Date:]{#1}}
\newcommand\correspondence[1]{\metadata[Correspondence:]{#1}}

\newcommand\titlelist{}
\renewcommand{\title}[1]{\def\titlelist{{\Huge\sffamily\bfseries\color{magicnavy} #1}}}

\newcommand{\beginappendix}{\appendix{\huge\sffamily\bfseries\color{magicnavy} Appendix\par}}

% Title block %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\magic@maketitle}{%
  \setlength{\parskip}{0cm}%
  \setlength{\parindent}{0cm}%
  \nohyphens
  {\setstretch{1.618}\titlelist\par}%
  \vskip 0.5cm
  \authorlist\par
  \vspace{0.3cm}
  \affiliationlist\par
  \ifdefempty{\contributionlist}{}{\vspace{0.3cm}\contributionlist\par}%
  \ifdefempty{\metadatalist}{}{\vspace{0.5cm}\metadatalist\par}%
  \vskip 0.5cm
  \begin{tcolorbox}[enhanced, frame hidden, colback=magicmist, arc=3.5pt,
      left=0.5cm, right=0.5cm, top=0.5cm, bottom=0.5cm, before skip=0pt,
      grow to left by=1.5pt, grow to right by=1.5pt,
      overlay={%
        \ifmagic@logo
          \node[anchor=north east, at=(frame.north east),
            xshift=-0.5cm, yshift=-0.45cm]
            {\includegraphics[width=3cm]{magicstyle/assets/magic-logo.png}};
        \fi
      }]
    {\Large\sffamily\bfseries\color{magicnavy} Abstract\par}
    \vspace{0.5cm}
    \abstractlist\par
  \end{tcolorbox}
  \FloatBarrier
  \setlength{\parskip}{5.5\p@}%
}

\if@twocolumn
  \renewcommand{\maketitle}{\twocolumn[\magic@maketitle\vskip 0.38cm]}
\else
  \renewcommand{\maketitle}{\magic@maketitle}
\fi
