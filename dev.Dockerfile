FROM node:18-alpine as base

FROM base as builder

COPY next-app /next-app

FROM base as wait
# https://github.com/ufoscout/docker-compose-wait

WORKDIR /
ADD executeMeWhenReady /executeMeWhenReady
# <https://stackoverflow.com/questions/37419042/container-command-start-sh-not-found-or-does-not-exist-entrypoint-to-contain>
# here we make sure that the script has unix line endings
RUN sed -i 's/\r$//' executeMeWhenReady  && \  
        chmod +x executeMeWhenReady

# Add docker-compose-wait tool -------------------
ENV WAIT_VERSION 2.12.1
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/$WAIT_VERSION/wait /wait
RUN chmod +x /wait

CMD /wait && /executeMeWhenReady

