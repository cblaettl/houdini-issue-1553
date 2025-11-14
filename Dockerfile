ARG NODE_VERSION=20
ARG ALPINE_VERSION=3.21

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS base

ARG PORT=3000
WORKDIR /code

# Build
FROM base AS build

ARG VERSION=0.0.0

COPY --link package.json package-lock.json ./
RUN npm ci

COPY --link . .

# RUN echo "{ \
# \"buildTime\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\", \
# \"version\": \"${VERSION}\" \
#     }" > ./services/portal/static/build.json

RUN npm run build

# Run
FROM base
RUN apk add --no-cache tini ca-certificates

ENV PORT=$PORT
ENV NODE_ENV=production

COPY --from=build /code/build /code/build
COPY --from=build /code/node_modules /code/node_modules

ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "node", "/code/build" ]