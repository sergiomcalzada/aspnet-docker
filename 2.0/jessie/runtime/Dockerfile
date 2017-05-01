FROM microsoft/dotnet-nightly:2.0.0-preview1-runtime

# set up network
ENV ASPNETCORE_URLS http://+:80

# set env var for packages cache
ENV ASPNETCORE_CACHE_VERSION 2.0.0-preview1-final

# set up package cache and other tools
RUN curl -o /tmp/packagescache.tar.gz \
    https://distaspnet.blob.core.windows.net/packagecache/temporary/Build.RS.linux-preview1-24783.tar.gz \
    # https://dist.asp.net/packagecache/${ASPNETCORE_CACHE_VERSION}/debian.8-x64/aspnetcore.cache.tar.gz \
    && export DOTNET_HOME=$(dirname $(readlink $(which dotnet))) \
    && mkdir -p $DOTNET_HOME \
    && tar -x -C $DOTNET_HOME -f /tmp/packagescache.tar.gz \
    && rm /tmp/packagescache.tar.gz
