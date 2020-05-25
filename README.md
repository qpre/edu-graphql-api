# edu-graphql-api

This repository is meant for students attending the Graph-QL 101 lesson, part of the Javascript course at EPITA.

# Pre-requisites

- If you attended the previous lesson (react-app-101), you should already have a Postgres database instance running locally named `edu_epita`.

- The docker _engine_ must be installed and running on your machine [[Install Docker Engine]](https://docs.docker.com/engine/install/)

- The [Hasura CLI](https://hasura.io/docs/1.0/graphql/manual/hasura-cli/install-hasura-cli.html#install-hasura-cli) must be installed on your system.

- open `run-api.sh` and uncomment the right part for your system

- copy `.env.default` to `.env` and change the values in it if required. (DO NOT FORGET TO SOURCE IT)

# Running the Hasura Console

`./run-api.sh` will start a docker engine for Hasura GraphQL on your machine and start the Hasura Console on http://localhost:9695/. (you'll be asked for the HASURA_GRAPHQL_ADMIN_SECRET in your `.env` to access it)

Once the console has started for the first time, in another terminal, run the migrations: `hasura migrate apply`.

You are good to go !

(Feel free to open a pull request to this repository if you encounter and fix any issues)
