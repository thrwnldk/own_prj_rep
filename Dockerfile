FROM mcr.microsoft.com/dotnet/sdk:8.0

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Установка .NET Interactive через официальный метод
RUN dotnet tool install --global Microsoft.dotnet-interactive && \
    export PATH="$PATH:/root/.dotnet/tools"

# Установка Jupyter
RUN dotnet interactive jupyter install

# Настройка рабочей директории
WORKDIR /workspace
COPY . .

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
