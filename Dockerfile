FROM fedora:30

LABEL maintainer="PnT DevOps Automation - Red Hat, Inc." \
      vendor="PnT DevOps Automation - Red Hat, Inc." \
      summary="Image used to run Angular tests." \
      distribution-scope="public"

COPY ca.crt /opt/ca.crt

# Configure the chrome executable for Karma
ENV CHROME_BIN=chromium-browser NODE_EXTRA_CA_CERTS=/opt/ca.crt

RUN dnf install -y --setopt=tsflags=nodocs \
      chromium-73.0.3683.86-2.fc30 \
      chromium-headless-73.0.3683.86-2.fc30 \ 
      findutils \
      firefox-66.0.2-1.fc30 \
      ipa-gothic-fonts \
      libXt \
      npm \
      wget \
      unzip\
      && dnf clean all

# Install webdrivers
RUN GECKODRIVER_VERSION=`curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+'` && \
      wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
      tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
      chmod +x /usr/local/bin/geckodriver && \
      rm geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz

RUN CHROMEDRIVER_VERSION="73.0.3683.68" && \
      wget https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
      unzip chromedriver_linux64.zip -d /usr/local/bin && \
      chmod +x /usr/local/bin/chromedriver && \
      rm chromedriver_linux64.zip
