FROM mcr.microsoft.com/dotnet/sdk:6.0

# Установка .NET Interactive и Jupyter
RUN dotnet tool install -g Microsoft.dotnet-interactive
ENV PATH="${PATH}:/root/.dotnet/tools"
RUN dotnet interactive jupyter install

# Копируем ноутбуки
WORKDIR /workspace
COPY . /workspace
