FROM fedora:35

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image used to run Angular tests." \
      distribution-scope="public"

COPY ca.crt /opt/ca.crt

# Configure the chrome executable for Karma
ENV CHROME_BIN=chromium-browser NODE_EXTRA_CA_CERTS=/opt/ca.crt

RUN dnf install -y --setopt=tsflags=nodocs \
    chromium-105.0.5195.125-2.fc35 \
    chromium-headless-105.0.5195.125-2.fc35 \ 
    findutils \
    firefox-105.0.1-1.fc35 \
    ipa-gothic-fonts \
    libXt \
    npm \
    wget \
    unzip \
    python3-pip \
    && dnf clean all

# Install webdrivers
RUN GECKODRIVER_VERSION="v0.31.0" && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

RUN CHROMEDRIVER_VERSION="105.0.5195.52" && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip
