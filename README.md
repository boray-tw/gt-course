# Graph Theory Course

This repository provides the lecture materials of the course Graph Theory ([GT](https://class-qry.acad.ncku.edu.tw/crm/course_map/course.php?dept=N2&cono=N258400&lang=en), [圖形理論](https://class-qry.acad.ncku.edu.tw/crm/course_map/course.php?dept=N2&cono=N258400)) in the department of Electrical Engineering ([EE](https://www.ee.ncku.edu.tw/en/), [電機所](https://www.ee.ncku.edu.tw/)), National Cheng Kung University ([NCKU](https://www.ncku.edu.tw/), [國立成功大學](https://www.ncku.edu.tw/?Lang=zh-tw)), Tainan, Taiwan.

## Getting Handouts

If you just need the handouts, please check the [latest release](https://github.com/coding-ray/gt-course/releases/latest).

The handouts should be present by 4 ~ 10 days after the class, based on Ray's workloads.

## Getting Started to Edit and Compile Handouts

### Install Docker

1. If you want to set up a working and fast LaTeX environment, you may want to skip this section. Otherwise, for building the handouts once or to isolate LaTeX environments, follow the instructions here.

1. Install Docker Engine by following the [official instructions](https://docs.docker.com/engine/install/).

1. Skip the next section.

### Install Dependencies Locally

1.  If you've set up Docker, you could skip this sections, for the Docker image [rays2/gt-handout-env](https://hub.docker.com/r/rays2/gt-handout-env) handles all the LaTeX-related dependencies.

1.  Install a TeX distribution which provides the [pdfTeX](https://tug.org/applications/pdftex/) engine. If you need to compile the syllabus, the TeX distro needs to provide XeLaTeX.
> [!TIP]
> You could install either [TeX Live](https://www.tug.org/texlive/) or [MikTeX](https://miktex.org/download).
>
> Some Linux distributions also provide TeX Live packages from the default package manager (like `apt install texlive` or `pacman -S texlive-bin`).

3.  Install the following packages with your TeX distribution.

    <!--
    When building a Docker image as the environment, the script accesses this package list, so make sure this list covers all required packages to build handouts in a Docker container.

    Also, make sure the div tag is at three lines before the single-line package list.
    -->

    <div id="package-list"></div>

    ```
    babel caption cleveref datetime2 environ geometry ifmtarg listings listingsutf8 mathabx mathtools multirow pdfcol pgf pgfplots preprint ragged2e subfiles tcolorbox tikzfill tools wrapfig xifthen
    ```

> [!TIP]
> With TeX Live, you could use `tlmgr install <packages>`, where `<packages>` is the package list above.
>
> Replace the package `tools` with `latex-tools` in MikTeX.

4.  (Optional) Install an editor you prefer.
    <details>
    <summary>Some editors with LaTeX syntax highlighting (click to expand/hide):</summary>

    Terminal:

    1. [Emacs with AUCTeX](https://tex.stackexchange.com/a/356)
    1. [Vim/gVim](https://www.vim.org/), [Neovim](https://neovim.io/), [MacVim](https://macvim.org/) (macOS) with [vim-latex](https://vim-latex.sourceforge.net/)
    1. [Nano](https://www.nano-editor.org/)
    1. [Sublime Text](https://www.sublimetext.com/)

    Simple GUI:

    1. [Notepadqq](https://notepadqq.com/s/)
    1. [Notepad++](https://notepad-plus-plus.org/)

    Comprehensive GUI, IDE:

    1. [Visual Studio Code](https://code.visualstudio.com/) (VS Code), [VSCodium](https://vscodium.com/)
    1. [TexMaker](https://www.xm1math.net/texmaker/)
    1. [TeXstudio](https://www.texstudio.org/)
    1. [TeXworks](https://tug.org/texworks/)
    </details>

### Compilation of TeX Files

<div id="docker-handout"></div>

1.  With Docker, you could compile the main handout `src/handouts/main.tex` in a Docker container.

    ```bash
    # Linux
    cd src/build-handouts
    ./build-handouts.sh
    ```

    ```bat
    rem Windows, in Command Prompt (CMD)
    cd src\build-handouts
    .\build-handouts-windows.bat
    ```

1.  Without using Docker, you can also compile the main handout in `src/handouts`. Note that you may need to run `pdflatex` command three or more times to have correct referencing.

    ```bash
    # with files clustering in the working directory
    pdflatex main.tex

    # put all compiled files in build/
    # ..\..\build in Windows
    mkdir ../../build
    pdflatex -output-directory="../../build" -file-line-error main.tex

    # see only error messages in Linux
    # exit code 1 means no error
    pdflatex -output-directory="../../build" \
        -file-line-error \
        main.tex 2>&1 | \
        grep '^!.*' -A200 --color=always
    ```

1.  To build the syllabus in Linux, you could use the script to build the syllabus in Docker. For Windows, you could modify the script, or compile the syllabus with VS Code and LaTeX Workshop with a [TeX distribution](#install-dependencies-locally).
    ```bash
    # Linux
    cd src/build-syllabus
    ./build-syllabus.sh
    ```
    ```bat
    rem Windows, in Command Prompt (CMD)
    cd src\build-syllabus
    .\build-handouts-windows.bat
    ```

## Reporting Bugs or Supplementary Contents

Ray <[coding-ray](https://github.com/coding-ray)> (黃柏叡) is the primary maintainer of this repo, but the instructor [Yean-Ru Chen](https://www.ee.ncku.edu.tw/en/teacher/index2.php?teacher_id=162) ([陳盈如](https://www.ee.ncku.edu.tw/teacher/index2.php?teacher_id=162)) is the primary provider of the handouts.

As a result, for typos in content or technical problems (Docker, LaTeX, etc.), please contact Ray by [opening an issue](https://github.com/coding-ray/gt-course/issues).

For content correctness related problems (like misleading definitions) or supplementary content (like missing but important theorems or proofs), please [email the instructor](https://www.ee.ncku.edu.tw/teacher/index2.php?teacher_id=162) to get a correct and wanted version before [opening an issue](https://github.com/coding-ray/gt-course/issues).

## Contribution and Development

Contribution like [pull requests](https://github.com/coding-ray/gt-course/pulls) are welcomed.

Please check the [rules and notes](doc/dev-notes.md) in advance.
