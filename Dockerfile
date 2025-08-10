FROM ghcr.io/jupyter/docker-stacks/base-notebook:latest

RUN conda install -c conda-forge dotnet-interactive && \
    dotnet interactive jupyter install
