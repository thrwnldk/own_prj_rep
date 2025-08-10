FROM mcr.microsoft.com/dotnet/sdk:6.0

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

# Установка .NET Interactive (без --global)
RUN mkdir -p /tools && \
    dotnet tool install --tool-path /tools Microsoft.dotnet-interactive && \
    export PATH="$PATH:/tools"

# Установка Jupyter
RUN /tools/dotnet-interactive jupyter install

# Настройка рабочей директории
WORKDIR /workspace
COPY . .

# Порт для Jupyter
EXPOSE 8888

# Команда запуска
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
