# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files
COPY ["src/Identity.API/Identity.API.csproj", "Identity.API/"]
COPY ["src/Identity.Application/Identity.Application.csproj", "Identity.Application/"]
COPY ["src/Identity.Domain/Identity.Domain.csproj", "Identity.Domain/"]
COPY ["src/Identity.Infrastructure/Identity.Infrastructure.csproj", "Identity.Infrastructure/"]

# Restore dependencies
RUN dotnet restore "Identity.API/Identity.API.csproj"

# Copy source code
COPY src/ .

# Build
WORKDIR "/src/Identity.API"
RUN dotnet build "Identity.API.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "Identity.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 3: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Identity.API.dll"]
