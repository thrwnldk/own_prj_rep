FROM mcr.microsoft.com/dotnet/sdk:6.0

# Установка необходимых зависимостей
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

# Альтернативный способ установки .NET Interactive
RUN dotnet new tool-manifest && \
    dotnet tool install Microsoft.dotnet-interactive && \
    export PATH="$PATH:$HOME/.dotnet/tools"

# Установка Jupyter
RUN dotnet interactive jupyter install

# Настройка рабочей директории
WORKDIR /workspace
COPY . .

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
