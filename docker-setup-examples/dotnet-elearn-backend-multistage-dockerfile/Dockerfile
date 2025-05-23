FROM mcr.microsoft.com/dotnet/nightly/sdk:8.0 AS build
WORKDIR /elearn
COPY . .
RUN dotnet restore
RUN dotnet build --configuration Release
RUN dotnet publish -c Release -o ./publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /learn
COPY --from=build /elearn/publish .
ENTRYPOINT dotnet ElearnBackend.dll
