% Identification
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{keyval}
\RequirePackage{kvoptions}

% Package options
\SetupKeyvalOptions{
  family=my,
  prefix=my@,
}

%% Declare options
\makeatletter
\DeclareStringOption[10pt]{fontsize}
\DeclareStringOption[0.5in]{pagemargin}
\DeclareStringOption[0pt]{spacing}
\DeclareStringOption[1DB954]{primarycolor}
\DeclareStringOption[FFFFFF]{backgroundcolor}
\DeclareStringOption[000000]{textprimarycolor}
\DeclareStringOption[909090]{textsecondarycolor}
\DeclareStringOption[1cm]{timelineindent}
\DeclareStringOption[.25cm]{smallskip}
\DeclareStringOption[.5cm]{bigskip}
\DeclareVoidOption{a4paper}{\LoadClass[\my@fontsize, a4paper]{article}}
\DeclareVoidOption{letterpaper}{\LoadClass[\my@fontsize, letterpaper]{article}}

%% Process options
\ProcessKeyvalOptions*

% Required packages
\RequirePackage[margin=\my@pagemargin]{geometry} % Document margins
\RequirePackage[table]{xcolor} % Colors
\RequirePackage[sfdefault,lf]{carlito}
\RequirePackage{fontspec}
\RequirePackage{tcolorbox} % Colored boxes
\RequirePackage{graphicx} % Images
\RequirePackage{fontawesome5} % Icons
\RequirePackage{titlesec} % Simplify the customization of section titles
\RequirePackage{enumitem} % Control layout of itemize, enumerate, description
\RequirePackage{tikz} % Create graphics programmatically
\RequirePackage{hyperref} % Links
\RequirePackage{calc} % Perform arithmetic on the arguments
\RequirePackage{array} % Extended implementation of the array and tabular environments
\RequirePackage{etoolbox} % Horizontal lists
\RequirePackage{tcolorbox} % Colored boxes
\RequirePackage{xparse} % Document commands
\RequirePackage{varwidth} % A variable-width minipage
\RequirePackage{multirow} % Create tabular cells spanning multiple rows
\RequirePackage{pagecolor} % Color the background
\RequirePackage{amssymb} % Mathematical symbols
\RequirePackage{changepage} % For adjusting width (indenting)
\RequirePackage{lipsum} % Generate "Lorem Ipsum" placeholder text

\usetikzlibrary{positioning,chains,matrix,calc}

% Set the background and text color.
% Colors
\definecolor{PRIMARY}{HTML}{\my@primarycolor}
\definecolor{TEXTPRIMARY}{HTML}{\my@textprimarycolor}
\definecolor{TEXTSECONDARY}{HTML}{\my@textsecondarycolor}
\definecolor{BACKGROUND}{HTML}{\my@backgroundcolor}

\AtBeginDocument{
  \pagecolor{BACKGROUND}
  \color{TEXTPRIMARY}
}


% Page style. Empty removes page numbers.
\pagestyle{empty}

% Links. No special markup for links to prevent distracting boxes.
\hypersetup{
  colorlinks=false, % this introduces a box around links and allows us to custom color the links and ...
  pdfborder={0 0 0}, % this line will remove the border around links.
}

% Commands (Info) - User input.
\newcommand*{\myname}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\myaddress}[1]{\def\@address{#1}}
\newcommand*{\mymobile}[1]{\def\@mobile{#1}}
\newcommand*{\mymail}[1]{\def\@mail{#1}}
\newcommand*{\mylinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\mygithubaccount}[1]{\def\@githubaccount{#1}}
\newcommand*{\myprofilepicture}[1]{\def\@profilepicture{#1}}

% % Design (Enum - cvEnum)
\newlist{cvEnum}{itemize}{1}
\setlist[cvEnum, 1]
{
  nosep,
  label=\textcolor{PRIMARY}{\tikz[baseline=-.5ex]{\fill[PRIMARY] circle (2pt);}},
  leftmargin=10pt,
  rightmargin=0pt,
  itemsep=0pt,
}
\setlistdepth{1}

% tikz styles
\tikzset{
  start chain=going below, % Start a chain going below
  node distance=.25em,
  % Header
  HEADERPRIMARY/.style={font=\Huge\bfseries\color{PRIMARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain},
  HEADERLINESECONDARY/.style={font=\small\color{TEXTSECONDARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain},
  PROFILEPICTURE/.style={rounded corners=5pt, draw=none, inner sep=0pt, outer sep=0pt, clip},
  % Text
  SECTION/.style={font=\bfseries\Large\color{PRIMARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain, yshift=-\my@bigskip},
  SUBSECTION/.style={font=\bfseries\large\color{PRIMARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain, yshift=-\my@smallskip},
  WHEN/.style={font=\normalfont\bfseries\color{TEXTSECONDARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain},
  PROFILE/.style={font=\normalfont\color{TEXTPRIMARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain, yshift=-\my@smallskip},
  ACCOMPLISHMENT/.style={font=\normalfont\color{TEXTPRIMARY}, text width=\dimexpr\textwidth-\my@timelineindent\relax, align=justify, inner sep=0pt, outer sep=0pt, on chain},
  % Visuals
  CIRCLE/.style={
      circle,
      draw=TEXTSECONDARY,
      fill=BACKGROUND,
      line width=2pt,
      inner sep=0pt,
      minimum size=0.15cm,
      anchor=nord,
    },
  LINE/.style={
      draw=TEXTSECONDARY,
      line width=2pt,
      line cap=round,
    },
  ICON/.style={
      font=\large\color{PRIMARY},
      inner sep=0pt,
      outer sep=0pt,
      anchor=west,
      xshift=-\my@timelineindent,
    },
}

% Environment (cv)
\newenvironment{cv}
{\noindent\begin{tikzpicture}}
    {\end{tikzpicture}}

% Command (jobentry)
\newcommand{\jobentry}[4]{%
  \node[SUBSECTION] (jobentrysubsec#1) {#2};
  \node[CIRCLE] (jobentrycircle#1) [at={(secicon.center |- jobentrysubsec#1.west)}, anchor=center] {};
  \node[WHEN] {#3};
  \node[ACCOMPLISHMENT] (jobentryaccomplishment#1) {#4};
  \draw[LINE] (jobentrycircle#1.south) -- (jobentrycircle#1.south |- jobentryaccomplishment#1.south);
}

% Command (educationentry)
\newcommand{\educationentry}[4]{%
  \node[SUBSECTION] (educationentry#1) {#2}; % Position and company/location
  \node[CIRCLE] (educationentrycircle#1) [at={(secicon.center |- educationentry#1.west)}, anchor=center] {}; % Circle to the left of the whatwhere node
  \node[WHEN] {#3}; % Time period
  \node[ACCOMPLISHMENT] (educationaccomplishment#1) {#4}; % Job description
  \draw[LINE] (educationentrycircle#1.south) -- (educationentrycircle#1.south |- educationaccomplishment#1.south);
}

% Command (mysection)
\newcommand{\mysection}[3]{%
  \node[SECTION] (sec) {\MakeUppercase{#3}};
  \node[ICON] (secicon) at (sec.west) {\faIcon{#2}};
}

% Command (skillsentry)
\newcommand{\skillsentry}[2]{%
  \node[SUBSECTION] (subsec#1) {#1};
  \node[ACCOMPLISHMENT] (subsecaccomplishment#1) {#2}; % Job description
  \node[CIRCLE] (subseccircle#1) [at={(secicon.center |- subsec#1.west)}, anchor=center] {}; % Circle centered below secicon
  \draw[LINE] (subseccircle#1.south) -- (subseccircle#1.south |- subsecaccomplishment#1.south);
}

% Command (profile)
\newcommand{\profile}[1]{%
  \node[PROFILE](profile) {#1};
  \node[CIRCLE] (profilecircle) [at={(secicon.center |- profile.north)}, anchor=north] {};
  \draw[LINE] (profilecircle.south) -- (profilecircle.south |- profile.south);
}

% Command (my header)
\newcommand{\myheader}{
  \node[HEADERPRIMARY] (headername) {\MakeUppercase{\@firstname\space\@lastname}};
  \node[HEADERLINESECONDARY, yshift=-\my@smallskip] (headerlinecontact) {
    \ifdef{\@address}{\@address}{}
    \ifdef{\@mobile}{\\\@mobile}{}
    \ifdef{\@mail}{\\\href{mailto://\@mail}{\@mail}}{}
    \ifdef{\@linkedinaccount}{\\\faLinkedin\ \texttt{\href{https://linkedin.com\@linkedinaccount}{\@linkedinaccount}}}{}
    \ifdef{\@githubaccount}{\\\faGithub\ \texttt{\href{https://github.com\@githubaccount}{\@githubaccount}}}{}
  };
  \ifdef{\@profilepicture}{
    \path let \p1 = (headername.north), \p2 = (headerlinecontact.south) in
    \pgfextra{\xdef\verticaldistance{\y1-\y2}};
    \node[PROFILEPICTURE, anchor=north east] (profilepicture) at (current bounding box.north east) {\includegraphics[height=\verticaldistance]{\@profilepicture}};
    % \draw[thick, rounded corners=5pt, line width=2pt, draw=PRIMARY] (profilepicture.north west) rectangle (profilepicture.south east);
  }{}
}
