# 上海工程技术大学数学建模竞赛模板

## 前言

在数学建模竞赛中，很多同学使用latex模板作为数学建模排版的方式，相对于Word模板来说，提高排版效率，专注于写作，是我们每个同学想要达到的目标。但是发现我们学校并没有数学建模论文模板，而且通过调研发现同学对latex使用情况甚微，几乎不了解。本人通过两次参加校数学建模竞赛和两次研究生数模竞赛经验，于是创作出了上海工程技术大学专属数学建模latex模板作为参考。

## 使用方法
本模板使用`xetex->bibtex->xetex->xetex`编译的命令即可进行编译处理。

在使用过程中可能需要一些字体，可以从overleaf上下载对应的字体文件。

# Windows 用户使用方法

可以使用以下的命令生成和删除对应的文件：
```bat
.\Compile.bat all    :: 编译生成commitment.pdf,format.pdf和paper.pdf三个文件
.\Compile.bat clean    :: 删除编译所产生的中间文件，不包括PDF
.\Compile.bat cleanall    :: 删除所有中间文件，包括PDF
.\Compile.bat wordcount    :: 论文字数统计
```

# Linux/FreeBSD/MacOS用户使用方法

可以使用以下的命令生成和删除对应的文件：
```makefile
make all                # 编译生成commitment.pdf,format.pdf和paper.pdf三个文件
make clean              # 删除编译所产生的中间文件，不包括PDF
make cleanall           # 删除所有中间文件，包括PDF
make wordcount          # 论文字数统计
```

Overleaf地址上已经部署好对应的论文，在上面直接使用即可，需要先将源码导入到自己的项目中去才可以使用它。

+ [OverLeaf地址](https://www.overleaf.com/read/mynpkfvwqjnm)
+ [latexstudio地址](https://www.latexstudio.net/index/details/index/ids/3065)

## 参考

+ [GBT7714-2005标准下的BibTeX样式](https://github.com/Haixing-Hu/GBT7714-2005-BibTeX-Style)
+ [数学建模资源](https://github.com/zhanwen/MathModel)

