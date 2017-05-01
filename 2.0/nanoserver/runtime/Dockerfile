# escape=`
FROM microsoft/dotnet-nightly:2.0.0-preview1-runtime-nanoserver-10.0.14393.1066

# set up network
ENV ASPNETCORE_URLS http://+:80
ENV ASPNETCORE_CACHE_VERSION 2.0.0-preview1-final

# set up package caches
RUN # $downloadUrl = \"https://distaspnet.blob.core.windows.net/packagecache/${env:ASPNETCORE_CACHE_VERSION}/win7-x64/aspnetcore.cache.zip\"; `
    $downloadUrl = \"https://distaspnet.blob.core.windows.net/packagecache/temporary/Build.RS.winx64-preview1-24783.zip"; `
    Write-Host \"Downloading and extracting $downloadUrl\"; `
    Invoke-WebRequest $downloadUrl -OutFile cache.zip; `
    $env:DOTNET_HOME = $(Split-Path -Parent (Get-Command dotnet.exe).Source); `
    Expand-Archive cache.zip -DestinationPath $env:DOTNET_HOME; `
    Remove-Item -Force cache.zip
