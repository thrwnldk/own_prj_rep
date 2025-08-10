# Используем образ с Docker Hub
FROM jupyter/base-notebook:latest

# Устанавливаем .NET 6+ и Interactive
USER root
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

# Устанавливаем .NET Interactive
RUN dotnet tool install --global Microsoft.dotnet-interactive && \
    export PATH="$PATH:/root/.dotnet/tools" && \
    dotnet interactive jupyter install

# Возвращаем пользователя jovyan
USER jovyan

# Копируем ноутбуки
COPY --chown=jovyan:users . /home/jovyan/work
