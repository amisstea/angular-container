FROM fedora:latest

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image used to run Angular tests." \
      distribution-scope="public"

# Configure the chrome executable for Karma
ENV CHROME_BIN=chromium-browser

RUN dnf install -y --setopt=tsflags=nodocs \
    chromium \
    chromium-headless \
    firefox \
    ipa-gothic-fonts \
    libffi-devel \
    libXt \
    npm \
    && dnf clean all
