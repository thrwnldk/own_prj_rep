FROM mcr.microsoft.com/dotnet/sdk:6.0

# Установка .NET Interactive через прямое скачивание
RUN wget https://www.nuget.org/api/v2/package/Microsoft.dotnet-interactive/ -O interactive.zip && \
    unzip interactive.zip -d /dotnet-tools && \
    rm interactive.zip && \
    export PATH="$PATH:/dotnet-tools/tools"

# Установка Jupyter
RUN /dotnet-tools/tools/dotnet-interactive jupyter install

WORKDIR /workspace
COPY . .

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
