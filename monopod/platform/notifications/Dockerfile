FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["src/Notifications.API/Notifications.API.csproj", "Notifications.API/"]
COPY ["src/Notifications.Application/Notifications.Application.csproj", "Notifications.Application/"]
COPY ["src/Notifications.Domain/Notifications.Domain.csproj", "Notifications.Domain/"]
COPY ["src/Notifications.Infrastructure/Notifications.Infrastructure.csproj", "Notifications.Infrastructure/"]

RUN dotnet restore "Notifications.API/Notifications.API.csproj"

COPY src/ .

WORKDIR "/src/Notifications.API"
RUN dotnet build "Notifications.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Notifications.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Notifications.API.dll"]
