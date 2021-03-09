FROM jupyter/base-notebook:latest

RUN python -m pip install --upgrade pip
COPY requirements.txt ./requirements.txt
RUN python -m pip  install -r requirements.txt
RUN python -m pip install --upgrade --no-deps --force-reinstall notebook

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

## Color variables
ENV YELLOW='\033[1;33m'
ENV NC='\033[0m'

WORKDIR ${HOME}

## Uninstall and cleanup Jupyter Lab Prior so that extensions/addons can be installed
## Trust me I tried so many things and its either build an image from scratch or uninstall/reinstall. Maybe revisit later
RUN set -e
RUN echo "Uninstalling old packages"
RUN pip uninstall -y jupyterlab-git || true;
RUN pip uninstall -y jupyterlab-server || true;
RUN pip uninstall -y jupyterlab || true;
RUN pip uninstall -y nbdime || true;

# use root to install package with package installer
USER root

## Cleanup Folders
RUN echo "Cleaning jupyter and jupyterlab workspace"
RUN rm -rf ~/.jupyter
RUN rm -rf $ANACONDA_HOME/etc/jupyter
RUN rm -rf $ANACONDA_HOME/share/jupyter
RUN rm -rf $ANACONDA_HOME/envs/$CONDA_DEFAULT_ENV/etc/jupyter
RUN rm -rf $ANACONDA_HOME/envs/$CONDA_DEFAULT_ENV/share/jupyter

## Install necessary packages
RUN apt-get update
RUN apt-get install -y build-essential curl apt-utils  

ENV \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    # Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip \
    # Opt out of telemetry until after we install jupyter when building the image, this prevents caching of machine id
    DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=true

# Install .NET CLI dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu66 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
        nano \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
# When updating the SDK version, the sha512 value a few lines down must also be updated.
ENV DOTNET_SDK_VERSION 5.0.102
RUN dotnet_sdk_version=5.0.102 \
    && curl -SL --output dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/$dotnet_sdk_version/dotnet-sdk-$dotnet_sdk_version-linux-x64.tar.gz \
    && dotnet_sha512='0ce2d5365ca39808fb71baec4584d4ec786491c3735543dc93244604ea97e242377d0987cd8b1e529258dee68f203b5780559201e7ea6d84487d6d8d433329b3' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -ozxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    # Trigger first run experience by running arbitrary cmd
    && dotnet help

# Copy configs
COPY ./config ${HOME}/.jupyter/

# Copy Notebooks
COPY ./Notebooks ${HOME}/Notebooks
ENV PATH="${PATH}:${HOME}/Notebooks"

# Copy package sources
COPY ./NuGet.config ${HOME}/nuget.config

# change to jovyan to install packages via pip
RUN chown -R ${NB_UID} ${HOME}
USER ${USER}

# Install Jupyterlab with extensions
RUN echo "${YELLOW}Installing/Updating Jupyter Lab and all required packages"
RUN pip install --upgrade pip tornado jupyterlab jupyterlab-git nbdime nteract_on_jupyter  

# Rebuild Jupyter Lab and relaunch after install. Reason for this is jupyterlab-git doesn't seem to work without building jupyyterlab prior to launching app
RUN echo "Rebuilding Jupyter lab... THIS WILL TAKE A WHILE! GET SOME COFFEE${NC}"
RUN jupyter lab build

#Setup Tools Path
RUN echo "Configuring $PATH path"
ENV PATH="${PATH}:${HOME}/.dotnet/tools"
RUN echo "$PATH"

# Install lastest build from main branch of Microsoft.DotNet.Interactive
RUN dotnet tool install -g Microsoft.dotnet-interactive --add-source "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json"

# Install kernel specs
RUN dotnet interactive jupyter install

# Enable telemetry once we install jupyter for the image
ENV DOTNET_INTERACTIVE_CLI_TELEMETRY_OPTOUT=false

# Set root to Notebooks
WORKDIR ${HOME}/Notebooks/

#################################################
#####         Installs Rust Kernel         ######
# (https://forge.rust-lang.org/infra/other-installation-methods.html#more-rustup)
#
# install Rust using rustup, but you can check out the other installation methods if you need them.
#USER root
#RUN apt update
#RUN apt install build-essential cmake graphviz -y
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s - -y
# Add Cargo's bin directory to your PATH environment variable and shell profile
#RUN source $HOME/.cargo/env
#ENV PATH="/$HOME/.cargo/bin:${PATH}"
# Installs the latest EvCxR "Evic-ser" Jupyter Kernel for Rust. Used to execute Rust code in Jupyter Notebook
# requires build-essential module to compile cc.
#RUN cargo install evcxr_jupyter
#RUN evcxr_jupyter --install
#################################################

## Runs Jupyter Lab on port 8888 and enables sudo to install packages
#CMD jupyter lab --ip=* --port=8888 --no-browser --allow-root
# --allow-root -e GRANT_SUDO=yes --user jovyan

# to run 
# docker run --user jovyan -e GRANT_SUDO=yes
