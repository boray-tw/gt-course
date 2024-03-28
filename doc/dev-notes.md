# Contribution and Developing Rules and Notes

## Rules

1.  To contribute to this repository, please install [latexindent.pl](https://github.com/cmhughes/latexindent.pl) or TeX package `latexindent` for formatting TeX files.

1.  (Optional) Install the VS Code extension [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).

1. In Ubuntu, please also set up the dependencies of `latexindent` as follows.install the `apt` package `libyaml-tiny-perl` to provide `YAML::Tiny`. (ref. )

    ```bash
    # install the perl package management tool "cpanm" system-wide
    sudo cpan -i App::cpanminus

    # install the perl package dependencies system-wide
    sudo cpanm YAML::Tiny
    sudo cpanm File::HomeDir
    ```

1.  In Arch Linux, please install the following packages for `latexindent` to work.

    ```bash
    sudo pacman -S texlive-binextra perl-yaml-tiny
    ```

    <details>
    <summary>Reasons (click to expand/hide):</summary>

    `texlive-binextra` provides `latexindent` and allows VS Code to access `latexmk` command that LaTeX Workshop requires. (References: [ref.1](https://stackoverflow.com/a/76565246), [ref.2](https://archlinux.org/news/tex-live-package-reorganization/))

    `perl-yaml-tiny` provides the `YAML::Tiny` module that `latexindent` required. ([Reference](https://stackoverflow.com/a/59784628))
    </details>

## Notes for Maintainers

### Make a New Release

1.  To release handouts and syllabus on GitHub, for now, please [build them in Docker](#docker-handout) for a consistent environment, and add the files to a release manually.

### Publish the Environment Image to Docker Hub

1.  Generate an access token from the [settings page](https://hub.docker.com/settings/security) with permissions to read, write, delete images.

1.  In a Linux machine, log in Docker Hub with the token.

    ```bash
    docker login -u rays2
    ```

1.  Build the handout-environment image.

    ```bash
    cd src/build-handouts/env-image
    ./build-handout-env.sh
    ```

1.  (Optional) Check the compiling result.

    ```bash
    cd ..
    ./build-handouts.sh
    ```

1.  Push the images to Docker Hub.

    ```bash
    docker push rays2/gt-handout-env --all-tags
    ```
