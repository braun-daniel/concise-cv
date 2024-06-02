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
\DeclareStringOption[0.5in]{margin}
\DeclareStringOption[0pt]{spacing}
\DeclareStringOption[00423b]{primarycolor}
\DeclareVoidOption{a4paper}{\LoadClass[\my@fontsize, a4paper]{article}}
\DeclareVoidOption{letterpaper}{\LoadClass[\my@fontsize, letterpaper]{article}}

%% Process options
\ProcessKeyvalOptions*

% Required packages
\RequirePackage[margin=\my@margin]{geometry} % Document margins
\RequirePackage[table]{xcolor} % Colors
\RequirePackage{fontspec} % Font selection
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

% Set the background and text color.
% Colors
\definecolor{PRIMARY}{HTML}{\my@primarycolor}
\definecolor{TEXT}{RGB}{0,0,0} % For the main text section.
\definecolor{BACKGROUND}{RGB}{255,255,255} % For the background color.
\AtBeginDocument{
  \pagecolor{BACKGROUND}
  \color{TEXT}
}

% Font
\setmainfont{TeX Gyre Heros}

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
\newcommand*{\myposition}[1]{\def\@position{#1}}
\newcommand*{\mymail}[1]{\def\@mail{#1}}
\newcommand*{\mylinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\mygithubaccount}[1]{\def\@githubaccount{#1}}
\newcommand*{\myprofile}[1]{\def\@profile{#1}}
\newcommand*{\myspacing}[1]{\setlength{\parskip}{#1}}

% Design (Header)
\newcommand{\profilepicture}[2]{
  \begin{tikzpicture}[baseline=(current bounding box.north)]
    \node[rounded corners=5pt, draw=none, inner sep=0pt, clip] at (0,0) {\includegraphics[width=#2]{#1}};
  \end{tikzpicture}
}
\newcommand{\header}{
  \begin{minipage}{.2\linewidth}
    \profilepicture{assets/images/profilepicture.png}{3cm}
  \end{minipage}
  \begin{minipage}[3cm]{.35\linewidth}
    \raggedright
    \color{PRIMARY}
    {\LARGE\scshape\bfseries\@firstname\space\@lastname}\vspace{.5em} \\
    {\@address} \\
    {\@mobile} \\
    {\href{mailto://\@mail}{\@mail}} \\
    {\faLinkedin\texttt{\href{https://linkedin.com\@linkedinaccount}{\@linkedinaccount}}} \\
    {\faGithub\texttt{\href{https://github.com\@githubaccount}{\@githubaccount}}}
  \end{minipage}
  \hfill
  \begin{minipage}{.4\linewidth}
    \vspace{0pt}
    \tcbset{
      myboxstyle/.style={
          colback=PRIMARY,        % Background color
          sharp corners,          % Remove if you want perfectly round corners
          rounded corners,        % Apply rounded corners
          boxrule=0pt,            % Border thickness
          arc=5pt,                % Radius of rounded corners
          width=\linewidth,       % Box width
          boxsep=5pt,             % Separation between box and content
          left=5pt,               % Internal left padding
          right=5pt,              % Internal right padding
          top=5pt,                % Internal top padding
          bottom=5pt              % Internal bottom padding
      }
    }
    \begin{tcolorbox}[myboxstyle]
      \color{white}
      {{\scshape\textbf{Profile }}\textbf{|}\space{\small\@profile}}
    \end{tcolorbox}
  \end{minipage}
  \\
}

% Design (Sections)
\newcommand{\largehrulefill}[1][0.4pt]{\leavevmode\leaders\hrule height #1\hfill\kern0pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{\my@spacing}
\titleformat{\section}
  {\LARGE\bfseries\scshape\color{PRIMARY}} % Large (\large), small capitals (\scshape), bold (\bfseries)
  {} % Section number
  {0em} % Space between the section number and title
  {} % Horizontal line before the title
  [\vspace{-1em}\rule{\textwidth}{1pt}]
\titleformat{\subsection}
  {\bfseries\scshape\color{PRIMARY}} % Large (\Large), small capitals (\scshape), left aligned (\raggedright)
  {}{0em} % Separator
  {} % Before code

\titlespacing*{\section}{0em}{1em}{.5em}
\titlespacing*{\subsection}{0em}{1em}{0em}

% Design (Enum - cvEnum)
\newlist{cvEnum}{itemize}{1}
\setlist[cvEnum, 1]
{
  nosep,
  label=\textcolor{PRIMARY}{\raisebox{0.25ex}{\tiny$\blacksquare$}},
  leftmargin=10pt,
  rightmargin=0pt,
  itemsep=2pt,
}
\setlistdepth{1}

% Command (What/Where/When)
\newcommand{\whatwherewhen}[3]{
  \subsection*{
    {\makebox[0pt][l]{#1}\makebox[\textwidth][c]{\begin{varwidth}{0.6\textwidth}\centering#2\end{varwidth}}\makebox[0pt][r]{#3}}
  }
  \vspace{-1em}
}

% Command (Accomplishment)
\newcommand{\accomplishment}[2]{ 
  % Power verb, method/skill, result
  % Accomplished [X], as measured by [Y], by doing [Z]
  \textbf{#1} #2
}


\newenvironment{skillEnum}
{%
    \begin{itemize}[
      nosep,
      label={},
      leftmargin=10pt,
      rightmargin=0pt,
      itemsep=2pt,
    ]%
}
{%
    \end{itemize}%
}
\NewDocumentCommand{\skills}{m O{} m}{%
  \item #1\ifx#2\empty\else\textbf{#2 }\fi#3
}
\newcommand{\beginner}{%
    \tikz{
      \filldraw[gray!30] (0,0) circle (.5ex);%
      \filldraw[gray!30] (1.5ex,0) circle (.5ex);%
      \filldraw[PRIMARY] (3ex,0) circle (.5ex);%
    }
}
\newcommand{\intermediate}{%
  \tikz{
    \filldraw[gray!30] (0,0) circle (.5ex);%
    \filldraw[PRIMARY] (1.5ex,0) circle (.5ex);%
    \filldraw[PRIMARY] (3ex,0) circle (.5ex);%
  }
}
\newcommand{\expert}{%
  \tikz{
    \filldraw[PRIMARY] (0,0) circle (.5ex);%
    \filldraw[PRIMARY] (1.5ex,0) circle (.5ex);%
    \filldraw[PRIMARY] (3ex,0) circle (.5ex);%
  }
}