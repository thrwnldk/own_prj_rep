FROM mcr.microsoft.com/dotnet/sdk:8.0

# Установка .NET Interactive (без -g)
RUN mkdir -p /tools && \
    dotnet tool install --tool-path /tools Microsoft.dotnet-interactive && \
    export PATH="$PATH:/tools"

# Установка Jupyter
RUN dotnet interactive jupyter install --quiet

# Копируем ноутбуки
WORKDIR /workspace
COPY . .

# Порт Jupyter
EXPOSE 8888

# Запуск
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]

# Добавьте восстановление NuGet перед установкой
RUN dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org
