﻿FROM jetbrains/teamcity-agent:2023.05.2

USER root
ENV DOCKER_IN_DOCKER=start

RUN curl -o packages-microsoft-prod.deb -L https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y dotnet-sdk-7.0

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

USER buildagent

RUN dotnet tool install -g Amazon.Lambda.Tools
ENV PATH="${PATH}:/home/buildagent/.dotnet/tools"

WORKDIR /opt/buildagent
CMD ["/run-services.sh"]
