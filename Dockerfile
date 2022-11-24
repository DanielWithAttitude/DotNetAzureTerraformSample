FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

#Copy .csproj file to the workdir
COPY *.csproj ./
RUN dotnet restore

#Copy other files and build
COPY . ./
RUN dotnet publish -c Release -o output

#generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
#copy files from build stage and publish output
COPY --from=build-env /app/output .     
EXPOSE 80
ENTRYPOINT ["dotnet","weatherapi.dll"]


