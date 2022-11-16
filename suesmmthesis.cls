\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{suesmmthesis}[2022/11/16 v2.0 update  https://github.com/mobtgzhang/sues-mm]

%% Inital Code 
\newif\if@suesmmthesis@bwprint\@suesmmthesis@bwprintfalse
\newif\if@suesmmthesis@preface\@suesmmthesis@prefacetrue
% tokens definition

%% Declaration of Options 
\DeclareOption{colorprint}{\@suesmmthesis@bwprintfalse}
\DeclareOption{bwprint}{\@suesmmthesis@bwprinttrue}
\DeclareOption{withoutpreface}{\@suesmmthesis@prefacefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
%% Executing of Options
\ExecuteOptions{colorprint}
\ProcessOptions\relax
%% Loading Class
\LoadClass[a4paper,cs4size,zihao=-4,space=auto]{ctexart}
% 论文中其他汉字一律采用小四号宋体字，行距用单倍行距。
% 采用80克A4规格纸输出，从中文摘要页开始双面打印。
\RequirePackage{ifxetex}
\RequireXeTeX
\ifxetex\else
\ClassError{mcmthesis}{You must use the `xelatex' driver\MessageBreak Please choose `xelatex'}{%
Just choose `xelatex', no `pdflatex' or `latex' and so on.}
\fi
% 页面布局设置
% ----------------------------------------------------------
% 页面布局
\RequirePackage{geometry}
\geometry{
    top=30.0mm,
    bottom=25.0mm,
    left=31.7mm,
    right=31.7mm,
    headsep=8mm
}
% ----------------------------------------------------------
% 字体设置

% 设置字体
\setmainfont{Times New Roman}
\setmonofont{Courier New}
\setsansfont{Arial}
\setCJKmainfont[AutoFakeBold = {2.15},ItalicFont={KaiTi}]{SimSun}
% 增加汉字
\setCJKfamilyfont{xw}{STXinwei}
\setCJKfamilyfont{zhyou}{YouYuan}
\ifx\lishu\undefined%
    \setCJKfamilyfont{zhli}{LiSu}
    \newcommand*{\lishu}{\CJKfamily{zhli}}
\else
    %% Do this if it is defined
\fi
\newcommand*{\xinwei}{\CJKfamily{xw}} 

% ----------------------------------------------------------
% 数学宏包
\RequirePackage{amsmath,amsfonts,amssymb,bm}
% 设置颜色的包
\RequirePackage{color,xcolor}
% 实现文字的shadow样式
\makeatletter
\newlength\st@shadowoffsetx
\newlength\st@shadowoffsety

\st@shadowoffsetx=1pt
\st@shadowoffsety=1pt

\newcommand\shadowoffset[1]{\setlength\st@shadowoffsetx{#1}\setlength\st@shadowoffsety{#1}}
\newcommand\shadowoffsetx[1]{\setlength\st@shadowoffsetx{#1}}
\newcommand\shadowoffsety[1]{\setlength\st@shadowoffsety{#1}}
\newcommand\shadowcolor[1]{\def\st@shadowcolor{#1}}
\newcommand\shadowrgb[1]{\definecolor{st@shadowcolorrgb}{rgb}{#1}\shadowcolor{st@shadowcolorrgb}}

\shadowrgb{0.66,0.66,0.66}

\newlength\st@temp@width
\newlength\st@temp@height 
\newlength\st@pic@width
\newlength\st@pic@height
\newcommand\shadowtext[1]%
{%
   \begingroup%
   \settowidth{\st@temp@width}{#1}%
   \settoheight{\st@temp@height}{#1}%
   \setlength{\st@pic@width}{\st@temp@width}%
   \setlength{\st@pic@height}{\st@temp@height}%
   \addtolength{\st@pic@width}{\st@shadowoffsetx}%
   \addtolength{\st@pic@height}{\st@shadowoffsety}%
   %
   \edef\num@tw{\strip@pt\st@temp@width}%
   \edef\num@th{\strip@pt\st@temp@height}%
   \edef\num@pw{\strip@pt\st@pic@width}%
   \edef\num@ph{\strip@pt\st@pic@height}%
   \edef\num@offsetx{\strip@pt\st@shadowoffsetx}%
   \edef\num@offsety{\strip@pt\st@shadowoffsety}%
   \raisebox{-\st@shadowoffsety}{
   \begin{picture}(\num@pw,\num@ph)(0,0)
	    \put(\num@offsetx,0){\makebox(\num@tw,\num@th)[tl]{\color{\st@shadowcolor}\def\color##1{}\ignorespaces #1}}
		\put(0,\num@offsety){\makebox(\num@tw,\num@th)[tl]{\ignorespaces #1}}
	\end{picture}}%
	\endgroup%
	\ignorespaces%
}
\makeatother
% ---------------------------------------------------
% 插入图片
\RequirePackage{graphicx} 
% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}
 % 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}{pictures/}%
  {picture/}{pic/}{pics/}{image/}{images/}}
% 表格
\RequirePackage{tabularx,array}
%% 长表格
\RequirePackage{longtable}
%% multirow 支持在表格中跨行
\RequirePackage{multirow}
%% multirow 支持在表格中跨列
\RequirePackage{multicol}

\renewcommand*{\baselinestretch}{1}
% 修改tabular 环境, 设置表格中的行间距为正文行间距.
\let\oldtabular\tabular
\let\endoldtabular\endtabular
\renewenvironment{tabular}%
  {\bgroup%
  \renewcommand{\arraystretch}{1.38}%
  \oldtabular}%
{\endoldtabular\egroup}
% 设置浮动体的标题
\RequirePackage{caption}
% 图表标题
\DeclareCaptionFont{song}{\songti}
\DeclareCaptionFont{minusfour}{\zihao{-4}}
\captionsetup[figure]{%
  format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
  labelsep=quad, % 分隔符是一个空格
  font={song,minusfour,bf}, % 图的字体, 宋体小四
  position=bottom % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
\captionsetup[table]{%
  format=hang,   % 标题从第二行开始都有缩进, 应该和 justification=raggedright 的效果一样.
  labelsep=quad, % 分隔符是一个空格
  font={song,minusfour,bf}, % 表的字体, 宋体小四
  position=top % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
% ----------------------------------------------------------
%% booktabs 提供了\toprule 等命令.
\RequirePackage{booktabs}

%% 调整间隔, 让表格更好看些
\RequirePackage{bigstrut}
%% 在跨行表格中输入定界符
\RequirePackage{bigdelim}
% 保护脆落命令
\RequirePackage{cprotect}
% 首行缩进
\RequirePackage{indentfirst}
% 每行缩进两个汉字
\setlength\parindent{2em}

% 定制列表环境
\RequirePackage{enumitem}
% 下划线 
\RequirePackage{ulem}
% 尺寸计算
\RequirePackage{calc}
% 超链接 hyperref 的设置
\RequirePackage{hyperref,url}
\hypersetup{
    hidelinks,
    citecolor=black
}
\hypersetup{%
    % % unicode=false, % hyperref 和 xetex 同时使用时不能开启 Unicode 选项.
     hyperfootnotes=true,
     hyperindex=true,
     colorlinks=true,
     bookmarksnumbered=true,
     bookmarksopen=true,
     bookmarksopenlevel=0,
     allcolors=black,
     breaklinks=true}
% 脚注链接换行处理
\def\UrlAlphabet{%
      \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
      \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
      \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
      \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
      \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
      \do\Y\do\Z}
\def\UrlDigits{\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}

\def\UrlBreaks{%
  \do\/%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l%
     \do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L%
     \do\M\do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9\do=\do/\do.\do:%
  \do\*\do\-\do\~\do\'\do\"\do\-}
\Urlmuskip=0mu plus 0.1mu



% ---------------------------------------------------
% 载入自动引用宏包
\RequirePackage{cleveref}
% 数学环境, 定理等设置
\newtheorem{definition}{定义}
\crefname{definition}{定义}{定义}

\newtheorem{theorem}{定理}
\crefname{theorem}{定理}{定理}

\newtheorem{lemma}{引理}
\crefname{lemma}{引理}{引理}

\let\proof\relax
\let\endproof\relax
\newtheorem{proof}{证明}
\crefname{proof}{证明}{证明}

\newtheorem{corollary}{推论}
\crefname{corollary}{推论}{推论}

\newtheorem{assumption}{假设}
\crefname{assumption}{假设}{假设}

\newtheorem{conjecture}{猜想}
\crefname{conjecture}{猜想}{猜想}

\newtheorem{axiom}{公理}
\crefname{axiom}{公理}{公理}

\newtheorem{principle}{定律}
\crefname{principle}{定律}{定律}

\newtheorem{problem}{问题}
\crefname{problem}{问题}{问题}

\newtheorem{example}{例}
\crefname{example}{例}{例}

\newtheorem{solution}{解}
\crefname{solution}{解}{解}
% ---------------------------------------------------
% 参考文献设置
\RequirePackage{titletoc}
\renewenvironment{thebibliography}[1]
     {%\section*{\refname}%
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
{\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
} 
%----------------------------------------------------
% 浮动环境设置
% 默认情况下, \LaTeX{} 要求每页的文字至少占据 20%,否则该页就只单独放置一个浮动环境,
% 而这通常不是我们想要的, 我们将这个要求降低到 5%.
\renewcommand*{\textfraction}{0.05}
% 有时如果多个浮动环境连续放在一起, \LaTeX{}
% 会将它们分在几个不同页，即使它们可在同一页放
% 得下. 我们可以通过修改 |\topfraction| 和 |\bottomfraction| 分别设置顶端和底端的浮
% 动环境的最大比例.
 \renewcommand*{\topfraction}{0.9}
 \renewcommand*{\bottomfraction}{0.8}
% 有时\LaTeX{}会把一个浮动环境单独放在一页,
% 我们要求这个环境至少要占据 85% 才能单独放在一页.
% 注意:  |\floatpagefraction| 的数值必须小于 |\topfraction|.
 \renewcommand*{\floatpagefraction}{0.85}
% ---------------------------------------------------
% 中文标题格式设置
% 目录深度
\setcounter{secnumdepth}{3}
\def\@seccntformat#1{\csname the#1\endcsname\ \ }
% 节标题格式, 居中, 使用\chinese命令修改计数器, \kern 使得数字和内容不至于太远
\renewcommand\thesection{\arabic{section}.}
\renewcommand\thesubsection{\arabic{section}\thinspace.\thinspace\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection\thinspace.\thinspace\arabic{subsubsection}}
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {2.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\bfseries\centering\zihao{4}\heiti}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {1.25ex\@plus -1ex \@minus -.2ex}%
  {1.25ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {1.25ex\@plus -1ex \@minus -.2ex}%
  {1.2ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
   {3.25ex \@plus1ex \@minus .2ex}%
   {-1em}%
   {\normalfont\normalsize\bfseries}}

% ---------------------------------------------------

% 设置代码环境
\RequirePackage{listings}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\lstset{
  frame=tb,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  framerule=1pt,
  rulecolor=\color{gray!35},
  backgroundcolor=\color{gray!5},
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=3,
}
% ---------------------------------------------------
%设置目录格式
% 节的目录格式
\titlecontents{section}[0pt]{\vspace{2mm}\bfseries\heiti}
{\thecontentslabel\hskip.5em}{}{\titlerule*[0.5pc]{.}\contentspage}
% 小节的目录格式
\titlecontents{subsection}[30pt]{\songti}
{\thecontentslabel\hskip.5em}{}{\titlerule*[0.5pc]{.}\contentspage}

\titlecontents{subsubsection}[55pt]{\songti}
{\thecontentslabel\hskip.5em}{}{\titlerule*[0.5pc]{.}\contentspage}

\pagestyle{plain}
\endinput

