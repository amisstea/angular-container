FROM fedora:30

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image used to run Angular tests." \
      distribution-scope="public"

COPY ca.crt /opt/ca.crt

# Configure the chrome executable for Karma
ENV CHROME_BIN=chromium-browser NODE_EXTRA_CA_CERTS=/opt/ca.crt

RUN dnf install -y --setopt=tsflags=nodocs \
    chromium \
    chromium-headless \
    firefox-66.0.2-1.fc30 \
    ipa-gothic-fonts \
    libXt \
    npm \
    && dnf clean all
