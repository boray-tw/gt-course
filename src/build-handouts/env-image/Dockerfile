ARG UBUNTU_IMAGE_TAG=noble-20250127

FROM ubuntu:${UBUNTU_IMAGE_TAG}

# set timezone and install TeX Live dependencies
# reference: https://stackoverflow.com/a/40235306
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    apt -qqy update && \
    apt -qqy install wget perl tzdata && \
    rm -rf /var/lib/apt/lists/*

# install TeX Live and dependencies
ENV TL_ROOT="/opt/texlive"
ENV PATH="$TL_ROOT/bin/x86_64-linux/:$PATH"
ARG INSTALL_TL_URL="https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
ARG TL_DOC_PATH="$TL_ROOT/texmf-dist/doc/"
RUN cd /tmp && \
    echo "Downloading TeX Live installer..." && \
    wget -qO- "$INSTALL_TL_URL" --no-check-certificate | tar -xz && \
    cd install-tl-* && \
    echo "Installing TeX Live with basic scheme..." && \
    perl ./install-tl -scheme=scheme-basic --no-interaction -texdir="$TL_ROOT" -no-doc-install -no-src-install && \
    tlmgr backup -q --all --clean=0 && \
    rm -rf "$TL_DOC_PATH" && \
    find "$TL_ROOT" -name *src* -exec rm {} \; && \
    cd /tmp && \
    rm -rf *

# install required packages to build the handouts
ARG PACKAGES=mathtools
RUN echo "Installing TeX Live packages: ${PACKAGES}" && \
    tlmgr install ${PACKAGES} && \
    tlmgr backup -q --all --clean=0 && \
    rm -rf "$TL_DOC_PATH" && \
    find "$TL_ROOT" -name *src* -exec rm {} \;

# patch missing fonts
ARG SCRIPT_PATCH_FONTS=/tmp/patch-missing-fonts.sh
COPY ./patch-missing-fonts.sh /tmp/patch.sh
RUN /tmp/patch.sh && \
    rm -rf /tmp/*

# prepare container startup
WORKDIR /app
COPY entrypoint.sh ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]