FROM mcr.microsoft.com/dotnet/sdk:3.1 as builder
COPY BlazorApp /sources/BlazorApp
WORKDIR /sources/BlazorApp
RUN dotnet restore
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:3.1
COPY --from=builder /app /app
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
# will expose 8080 port
EXPOSE 8080
ENTRYPOINT ["dotnet","BlazorApp.dll"]
