#!/bin/bash
# NOTE: script will fail if your database does not exist
# NOTE: use `docker rm $APP_NAME` before running the script if previous launch failed.

cleanup() {
    echo 'killing API'
    docker kill $APP_NAME &> /dev/null
    exit 0
}

trap cleanup INT TERM

if [ ! "$(docker ps -a -q -f name=$APP_NAME)" ]; then
  # !!! WARNING !!! uncomment the right command for your system
  #
  #
  # NOTE: if you are having trouble running the API, try running the command without `-d` (daemon)
  #   to get error logs. then run it as documented. 
  #
  # NOTE: if the command does not run correctly, see: https://hasura.io/docs/1.0/graphql/manual/deployment/docker/index.html#network-config

  # OS X
  docker run --name=$APP_NAME -d -p 8080:8080 \
    -e HASURA_GRAPHQL_UNAUTHORIZED_ROLE=$HASURA_GRAPHQL_UNAUTHORIZED_ROLE \
    -e HASURA_GRAPHQL_DATABASE_URL=postgres://$DOCKER_DATABASE_USERNAME:$DOCKER_DATABASE_PASSWORD@host.docker.internal:$DOCKER_DATABASE_PORT/$DOCKER_DATABASE_NAME \
    -e HASURA_GRAPHQL_ADMIN_SECRET=$HASURA_GRAPHQL_ADMIN_SECRET \
    -e HASURA_GRAPHQL_JWT_SECRET=$HASURA_GRAPHQL_JWT_SECRET \
    hasura/graphql-engine:latest

  # Linux
  # docker run --name=$APP_NAME -d --net=host \
  #   -e HASURA_GRAPHQL_UNAUTHORIZED_ROLE=$HASURA_GRAPHQL_UNAUTHORIZED_ROLE \
  #   -e HASURA_GRAPHQL_DATABASE_URL=postgres://$DOCKER_DATABASE_USERNAME:$DOCKER_DATABASE_PASSWORD@localhost:$DOCKER_DATABASE_PORT/$DOCKER_DATABASE_NAME \
  #   -e HASURA_GRAPHQL_ADMIN_SECRET=$HASURA_GRAPHQL_ADMIN_SECRET \
  #   -e HASURA_GRAPHQL_JWT_SECRET=$HASURA_GRAPHQL_JWT_SECRET \
  #   hasura/graphql-engine:latest

  # Windows
  # docker run --name=$APP_NAME -d -p 8080:8080 \
  #   -e HASURA_GRAPHQL_UNAUTHORIZED_ROLE=$HASURA_GRAPHQL_UNAUTHORIZED_ROLE \
  #   -e HASURA_GRAPHQL_DATABASE_URL=postgres://$DOCKER_DATABASE_USERNAME:$DOCKER_DATABASE_PASSWORD@docker.for.win.localhost:$DOCKER_DATABASE_PORT/$DOCKER_DATABASE_NAME \
  #   -e HASURA_GRAPHQL_ADMIN_SECRET=$HASURA_GRAPHQL_ADMIN_SECRET \
  #   -e HASURA_GRAPHQL_JWT_SECRET=$HASURA_GRAPHQL_JWT_SECRET \
  #   hasura/graphql-engine:latest

else
  docker start $APP_NAME
fi

# poor man's wait
sleep 3

hasura console --project=./hasura-state --admin-secret $HASURA_GRAPHQL_ADMIN_SECRET