ARG UBUNTU_IMAGE_TAG=jammy-20240212

FROM ubuntu:${UBUNTU_IMAGE_TAG}

ARG UID_USER=1000
ARG GID_USER=1000
ARG USERNAME=user
ARG HOME_DIR=/home/"${USERNAME}"

# set timezone and install TeX Live dependencies
# reference: https://stackoverflow.com/a/40235306
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    apt -qqy update && \
    apt -qqy install --no-install-recommends wget perl tzdata libfontconfig fonts-noto-cjk && \
    apt clean

# create a normal user
RUN groupadd -g $GID_USER "${USERNAME}" && \
    useradd -m -g "${USERNAME}" -u $UID_USER -s /bin/bash "${USERNAME}"

# change to a normal user
USER ${USERNAME}
ENV HOME="$HOME_DIR"
ENV PATH="$HOME/.texlive/bin/x86_64-linux/:$PATH"

# install TeX Live and dependencies with a normal user
RUN cd /tmp && \
    wget -qO- https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz --no-check-certificate | tar -xz && \
    cd install-tl-* && \
    echo "Installing TeX Live with basic scheme:" && \
    perl ./install-tl -scheme=scheme-basic --no-interaction -texdir="~/.texlive" && \
    rm -rf ./* && \
    $HOME/.texlive/bin/x86_64-linux/tlmgr backup --all --clean

ARG PACKAGES="beamer datetime2 extsizes noto ragged2e tools xecjk"
RUN echo "Installing TeX Live packages silently: ${PACKAGES}" && \
    ~/.texlive/bin/x86_64-linux/tlmgr install -q ${PACKAGES} && \
    ~/.texlive/bin/x86_64-linux/tlmgr backup -q --all --clean=0

USER root
WORKDIR /app
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh && \
    apt autoremove -qqy wget perl

USER ${USERNAME}
WORKDIR /app
ENTRYPOINT [ "./entrypoint.sh" ]