FROM mcr.microsoft.com/dotnet/sdk:8.0

# 1. Обновляем систему и устанавливаем зависимости
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# 2. Устанавливаем .NET Interactive через прямое скачивание (обходной путь)
RUN wget https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json -O nuget.config && \
    dotnet tool install Microsoft.dotnet-interactive --global --add-source https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json

# 3. Настраиваем PATH
ENV PATH="${PATH}:/root/.dotnet/tools"

# 4. Устанавливаем поддержку Jupyter
RUN dotnet interactive jupyter install

# 5. Настройка рабочей среды
WORKDIR /workspace
COPY . .

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
