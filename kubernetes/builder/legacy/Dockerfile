# Clone
FROM php:7.1-cli
RUN apt-get update
RUN apt-get install -y git
ARG BRANCH
RUN echo "On build la branche $BRANCH..."
RUN git clone https://github.com/jean-pasqualini/bridge-legacy-refonte -b $BRANCH /build

# Init environment of execution
FROM php:7.1-fpm
RUN apt-get update
RUN apt-get install -y nginx supervisor

# Copy supervisor config
COPY --from=0 /build/kubernetes/builder/refonte/supervisord.conf /etc/supervisord.conf
# Copy application
COPY --from=0 /build/legacy /app
# COPY nginx config
RUN cp /app/docker/default.conf /etc/nginx/sites-enabled/default
# Configure host-fpm
RUN sed -i -- 's/legacy-fpm/127.0.0.1/g' /etc/nginx/sites-enabled/default

# Start
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]