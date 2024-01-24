# Nextjs and Mysql With Docker Compose

This example contains everything needed to get a Next.js development and production environment up and running with Docker Compose.

## Benefits of Docker Compose

- Develop locally without Node.js or TypeScript installed ✨
- Easy to run, consistent development environment across macOS, Windows, and Linux teams
- Run multiple Next.js apps, databases, and other microservices in a single deployment
- Multistage builds combined with [Output Standalone](https://nextjs.org/docs/advanced-features/output-file-tracing#automatically-copying-traced-files) outputs up to 85% smaller apps (Approximately 110 MB compared to 1 GB with create-next-app)
- Easy configuration with YAML files

## challenge

we need to make sure that the dependency container - usually database - is running before our app

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

make sure that your database username and password match between your mysql container and your app container

```sh
cp .env.dist .env
```

if you are using `nextauth-login` make sure to also copy  `next-app/.env.dist` to `next-app/.env`

```sh
cp next-app/.env.dist next-app/.env
```

modify  `next-app/.env`

```.env
DATABASE_1_URL="mysql://root:password@mysql:3306/dbauth?schema=public"

# openssl rand -hex 32
NEXTAUTH_SECRET=6a8cee472226f28114d50988caa1ec40d54707c651dec1093354d732e9b0acf9
NEXTAUTH_URL=http://localhost:3000

# google secret
GOOGLE_CLIENT_ID="YOURCLIENTID.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="YOUR-CLIENTSECRET"
```

`@mysql` ini `DATABASE_1_URL="mysql://root:password@mysql:3306/dbauth?schema=public"` is a container name

## run CMD after mysql-db is up

```sh
cp executeMeWhenReady.dist executeMeWhenReady
```

here you can type all command that will be run after mysql-db is up
for example we can push execute command that will initiliazie the database from prisma

```sh
yarn prisma migrate dev --schema ./prisma/db-auth/schema.prisma
```

## build container

once again make sure you already set

- `next-app/.env`
- `.env`
- `executeMeWhenReady`

after you make sure that all the environmet variable and script you want to run after mysql is ready now is time to spin our docker container

```sh
docker compose -f docker-compose.dev.yml up --build
```

next-app will wait until mysql is ready

![wait for mysql](/images/wait.png)

`executeMeWhenReady` script will fired whel mysql is ready

![executeMeWhenReady is fired ](/images/available.png)

Open [http://localhost:3000](http://localhost:3000).

## try to remove container and spin again

```sh
docker compose -f docker-compose.dev.yml down -v
docker compose -f docker-compose.dev.yml up
```

## Useful commands

```bash
# Stop all running containers
docker kill $(docker ps -aq) && docker rm $(docker ps -aq)

# Free space
docker system prune -af --volumes
```
