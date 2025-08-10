FROM mcr.microsoft.com/dotnet/sdk:8.0

# Установка необходимых пакетов
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Установка .NET Interactive через прямое скачивание NuGet пакета
RUN wget https://www.nuget.org/api/v2/package/Microsoft.dotnet-interactive/3.0.0 -O interactive.zip && \
    mkdir -p /dotnet-tools && \
    unzip interactive.zip -d /dotnet-tools && \
    rm interactive.zip && \
    chmod +x /dotnet-tools/tools/* && \
    ln -s /dotnet-tools/tools/dotnet-interactive /usr/local/bin/dotnet-interactive

# Установка Jupyter
RUN dotnet-interactive jupyter install

# Настройка рабочей среды
WORKDIR /workspace
COPY . .

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
