#!/bin/bash

# Propriedades
DOCKER_COMPOSE_VERSION=1.17.1
COMPOSE_PATH="/usr/local/bin/docker-compose"
DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/run.sh"

# Roteiro de construção
echo;echo "::: Inicio da construção da imagem :::";echo

# :::::::::::::::::::::::::::::::

# Instala 'docker-compose'
if [[ ! -f $COMPOSE_PATH ]]
then  
  echo;echo ":: Instalar 'docker-compose' ::";echo
  
  sudo curl -L --fail $DOWNLOAD_URL -o $COMPOSE_PATH
  
  sudo chmod +x $COMPOSE_PATH
fi

# :::::::::::::::::::::::::::::::

{ # ::: Construção do container 'golang:alpine' :::

  if [[ -z `docker images -q golang:alpine` ]]; then

    echo;echo ":: Instalar container 'golang' ::";echo
  
    docker run -ti -d --name golang golang:alpine

  fi

  # ::: Construção da aplicação :::
  
  echo;echo ":: Executar construção da aplicação ::";echo

  docker exec golang go clean test build ./src

} || {

  echo;echo ':: Falha na construção da aplicação. ::';echo

  exit 1

} && { # Constroi imagem da aplicação

  sudo docker-compose \
       -f pub/docker-compose-build.yml \
       build

} || {

  echo;echo ":: Falha na construção do container. ::"

  exit 1

} && { # Ativa serviços dependentes e container da aplicação

  sudo docker-compose \
       -f pub/docker-compose-up.yml \
       up -d # Detached

} || {

  echo;echo ":: Falha na ativação. ::"

  exit 1

}

# :::::::::::::::::::::::::::::::

echo;echo "::: Construção finalizada :::";echo

