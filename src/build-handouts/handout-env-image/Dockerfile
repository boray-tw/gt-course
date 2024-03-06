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
    apt -qqy install wget perl tzdata && \
    apt clean

# create a normal user
RUN groupadd -g $GID_USER "${USERNAME}" && \
    useradd -m -g "${USERNAME}" -u $UID_USER -s /bin/bash "${USERNAME}"

# install TeX Live and dependencies with a normal user
USER ${USERNAME}
RUN cd /tmp && \
    wget -qO- https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - && \
    cd install-tl-* && \
    echo "Installing TeX Live with basic scheme silently..." && \
    perl ./install-tl -q -scheme=scheme-basic --no-interaction -texdir="~/.texlive" && \
    cd /tmp && \
    rm -rf ./*

ARG PACKAGES=mathtools
ENV HOME="$HOME_DIR"
ENV PATH="$HOME/.texlive/bin/x86_64-linux/:$PATH"
RUN echo "Installing TeX Live packages silently: ${PACKAGES}" && \
    ~/.texlive/bin/x86_64-linux/tlmgr install -q ${PACKAGES}

USER root
WORKDIR /app
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

USER ${USERNAME}
ENTRYPOINT [ "./entrypoint.sh" ]