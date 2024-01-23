# With Docker Compose

This example contains everything needed to get a Next.js development and production environment up and running with Docker Compose.

## Benefits of Docker Compose

- Develop locally without Node.js or TypeScript installed ✨
- Easy to run, consistent development environment across macOS, Windows, and Linux teams
- Run multiple Next.js apps, databases, and other microservices in a single deployment
- Multistage builds combined with [Output Standalone](https://nextjs.org/docs/advanced-features/output-file-tracing#automatically-copying-traced-files) outputs up to 85% smaller apps (Approximately 110 MB compared to 1 GB with create-next-app)
- Easy configuration with YAML files

## Prerequistes

- create network 
```sh
# Create a network, which allows containers to communicate
# with each other, by using their container name as a hostname
docker network create my_network
```

## How to use

```sh
git clone git@github.com:vatoer/docker-nextjs-mysql.git
cd docker-nextjs-mysql
```

## package manager
- this example use yarn as package manager
- you can modify if you use other package manager

## create new project or clone existing nextjs project

- in this example we will create project to folder `next-app` 
- you can modifiy as you like, just rename all script `next-app` to `whatever-folder`

### create new project

```sh
yarn create next-app@latest my-app --typescript --tailwind --eslint
```

OR 

### clone existing project

```sh
git clone git@github.com:vatoer/nextauth-login.git next-app
```

## How make sure that mysql-db required- run before our app

to make sure that my mysql ready we will use wait from <https://github.com/ufoscout/docker-compose-wait>

## CHECK ALL your .env variabel 

Open [http://localhost:3000](http://localhost:3000).

## Useful commands

```bash
# Stop all running containers
docker kill $(docker ps -aq) && docker rm $(docker ps -aq)

# Free space
docker system prune -af --volumes
```
