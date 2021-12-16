## Overview

**tccv** (two columns curriculum vitae) is a LaTeX class inspired by the
template found at
[latextemplates](http://www.latextemplates.com/template/two-column-one-page-cv)
by Alessandro Plasmati.

From a TeXnical point of view this is a complete rewrite. From the user
perspective, the most relevant differences from the original template are:

* this is a class, not a template document;
* more than one page are handled properly;
* the fonts are selected from the
  [psnfss](http://www.ctan.org/pkg/psnfss) collection, so no
  custom font installation should be required;
* it is plain LaTeX/Koma-script, so the CV can be compiled
  with the usual tools, latex pdflatex and lualatex included;
* the implementation is heavily based on custom environments
  and macros, so the document should be much easier to read
  (and customize);
* tccv is based on scrartcl (from Koma-script), not on article.

## How to use

You can download the [zipped
tarball](https://github.com/ntd/tccv/archive/refs/heads/master.zip) that
includes a couple of examples or pick up only the relevant [LaTeX
class](https://github.com/ntd/tccv/raw/master/tccv.cls).

The code is maintained in a git repository [browsable
online](https://github.com/ntd/tccv): fill free to fork it and extends in any
way you like.

A sample PDF generated with the command `lualatext nicola.en.tex` can be
[downloaded](https://github.com/ntd/tccv/raw/master/nicola.en.pdf).

## Howto

### Personal box on top

The `\personal` box by default follows the text flow. If you want to
affix it on the top (or on the bottom) you can make it a float, e.g.:

    \begin{figure}[b] % Push the figure at the bottom; use t for top
    \personal[url]
             {address}
             {phone}
             {email}
    \end{figure}

Alternatively you can use the myfloat package:

    % In the preamble
    \usepackage{float}
    \newfloat{myfloat}{t}{} % 'myfloat' is arbitrary, 't' stands for 'top'

    % Then wrap your personal data using the newly created custom float
    \begin{myfloat}
    \personal[url]
             {address}
             {phone}
             {email}
    \end{myfloat}

### Personal box broken in LyX

For some reason LyX (at least up to 2.1.3) escapes the brackets of the
`\personal` optional argument, scattering the URL letters all around.
If this is the case if you look at the source window you should see
something like `{[}www.myweb.site{]}` instead of `[www.myweb.site]`.

To solve this problem just readd the argument as *TeX code* by
eventually using the `CTRL-l` shortcut.

### Bullet points in ``eventlist``

``Tccv`` does not support bullet points due to its ``\eventlist`` environment that overrides the default ``\item`` command. That's why code like the following would not work (see [#5](https://github.com/ntd/tccv/issues/5))

```tex
\begin{eventlist}

\item{July 2007 -- Present}
     {Furman University, Greenville, SC}
     {Software Developer}

\begin{itemize}
     \item Development and testing of automatic and semiautomatic machines
     \item  Designing of electrical schematics
\end{itemize}
```

Fixing this issue would either be an ugly hack or a breaking change to the existing APIs. Since backward-compatibility is desired, this repo won't fix this issue. However, you may view a variant of ``tccv`` that addresses bullet points (see demo here: [resume.pdf](https://costahuang.me/resume.pdf), and its corresponding repo here:  [vwxyzjn/tccv-bullet-points](https://github.com/vwxyzjn/tccv-bullet-points))


