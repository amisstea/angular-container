FROM fedora:32

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image used to run Angular tests." \
      distribution-scope="public"

COPY ca.crt /opt/ca.crt

# Configure the chrome executable for Karma
ENV CHROME_BIN=chromium-browser NODE_EXTRA_CA_CERTS=/opt/ca.crt

RUN dnf install -y --setopt=tsflags=nodocs \
    chromium-85.0.4183.121-1.fc32 \
    chromium-headless-85.0.4183.121-1.fc32 \ 
    findutils \
    firefox-82.0-5.fc32 \
    ipa-gothic-fonts \
    libXt \
    npm \
    wget \
    unzip\
    && dnf clean all

# Install webdrivers
RUN GECKODRIVER_VERSION="v0.27.0" && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

RUN CHROMEDRIVER_VERSION="86.0.4240.22" && \
    wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip
