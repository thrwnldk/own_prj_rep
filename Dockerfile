FROM mcr.microsoft.com/dotnet/sdk:6.0
RUN dotnet tool install --global Microsoft.dotnet-interactive
ENV PATH="$PATH:/root/.dotnet/tools"
RUN dotnet interactive jupyter install
COPY . /workspace
WORKDIR /workspace
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
