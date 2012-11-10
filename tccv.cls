% Copyright (C) 2012  Nicola Fontana <ntd at entidi.it>
%
% This program can be redistributed and/or modified under
% the terms of the LaTeX Project Public License, either
% version 1.3 of this license or (at your option) any later
% version. The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all LaTeX distributions
% version 2005/12/01 or later.
%
% Based on the original idea by Alessandro Plasmati found at
% http://www.latextemplates.com/template/two-column-one-page-cv
%
% The most relevant changes from his work are:
%
% * this is a class, not a template document;
% * tccv is based on scrartcl (from Koma-script), not on article;
% * the fonts are selected from the PSNFSS collection, so no
%   custom font installation should be required;
% * heavily based the implementation on custom environments and
%   macros, so the document is much easier to read (and customize);
% * it is plain LaTeX/Koma-script, so the CV can be compiled
%   with the usual tools, latex and pdflatex included.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tccv}
              [2012/11/09 v1.0
 Two Column Curriculum Vitae]

\LoadClass[10pt]{scrartcl}

\RequirePackage[hmargin=1.25cm, vmargin=1.5cm]{geometry}
\RequirePackage{bookman,etoolbox,hyperref,marvosym,tabularx,xcolor}
\RequirePackage[english]{babel}

\pagestyle{empty}
\color[HTML]{303030} % Default foreground color
\definecolor{link}{HTML}{506060} % Hyperlinks
\hypersetup{colorlinks,breaklinks,urlcolor=link,linkcolor=link}
\renewcommand*\othersectionlevelsformat[3]{}
\setkomafont{disposition}{\color[HTML]{801010}}
\setkomafont{section}{%
    \scshape\Large\mdseries
    \makebox[0mm][l]{\raisebox{-4pt}{\rule{\linewidth}{0.5pt}}}}
\renewcommand*\part[1]{%
    \center
	{\usekomafont{part} #1} \\
	{\fontfamily{pzc}\selectfont\Huge Curriculum vitae}
    \endcenter}

\newcommand\ucwords[2][3]{%
    % Fails gracefully if not in LuaLaTeX
    \providecommand\directlua[1]{#2}
    \directlua{%
	local minlen=tonumber("#1")
	local src="\luaescapestring{\unexpanded{#2}}"
	local dst={}
	for w in src:gmatch('[^\string\%s]+') do
	    if w:len() >= minlen then w = w:sub(1,1):upper()..w:sub(2) end
	    table.insert(dst, w)
	end
	tex.print(dst)}}

% Redefine the \section command to capitalize every
% word for cosmetic purposes.
\makeatletter
\let\old@section\section
\renewcommand\section[2][]{%
    \old@section[#1]{\ucwords{#2}}}
\makeatother

% Renders a personal data box:
%
% |[
% \personal[optional: web site without scheme (no http:// prefix)]
%          {address}{phone number}{email}
% ]|
\newcommand\personal[4][]{%
    \colorbox[HTML]{F5DD9D}{%
    \begin{tabularx}{\linewidth}{c|X}
    \Writinghand & {#2}\smallskip\\
    \Telefon     & {#3}\smallskip\\
    \Letter      & \href{mailto:#4}{#4}
    \ifstrempty{#1}{}{\smallskip\\ \Lightning & \href{http://#1}{#1}}
    \end{tabularx}}}

% Every \item can be followed by one or more paragraphs
% of description:
%
% |[
% \item{date range}{company}{role}
%
% Description of what achieved during this application.
% ]|
\newenvironment{eventlist}{%
    \newcommand*\inskip{}
    \renewcommand\item[3]{%
	\inskip%
	{\raggedleft\sc ##1\\[1pt]}
	{##2}\\[2pt]
	{\Large\it ##3}
	\medskip
	\renewcommand\inskip{\bigskip}}}
    {}

% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item[optional: what has been achieved]{years}{subject}{notes}
% ]|
\newenvironment{yearlist}{%
    \renewcommand\item[4][]{%
	{\sc ##2} & {\bfseries ##3} \\
	\ifstrempty{##1}{}{& {\sc ##1} \\}
	& {\it ##4}\medskip\\}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}


% Use only \item inside this environment: no other macros
% are allowed:
%
% |[
% \item{fact}{description}
% ]|
\newenvironment{factlist}{%
    \newdimen\unbaseline
    \unbaseline=\dimexpr-\baselinestretch\baselineskip\relax
    \renewcommand\item[2]{%
	\textsc{##1} & {\raggedright ##2\medskip\\}\\[\unbaseline]}
    \tabularx{\linewidth}{rX}}
    {\endtabularx}
%%
%% End of file `tccv.cls'.
