#!/bin/bash

# Propriedades
DOCKER_COMPOSE_VERSION=1.17.1
COMPOSE_PATH="/usr/local/bin/docker-compose"

COMPOSE_FILE="pub/docker-compose.yml"

DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/run.sh"

# ::: Roteiro de construção :::

echo;echo -e "\e[34m::: Inicio da construção da imagem. :::\e[0m";echo

# :::::::::::::::::::::::::::::::

{ # Instala 'docker' e 'docker-compose' caso estes recursos não estejam instalados.

  if [[ ! -f $COMPOSE_PATH ]];then  

    echo;echo -e "\e[33m:: ferramenta 'docker-compose' não detectada. \
	Realizar download do 'docker' e 'docker-compose'. ::\e[0m";echo
  
    sudo apt-get install --upgrade docker

    sudo curl -L --fail $DOWNLOAD_URL -o $COMPOSE_PATH

    sudo chmod +x $COMPOSE_PATH

    echo;echo -e "\e[32m:: Instalação concluída. ::\e[0m";echo

  fi

} || {

  echo;echo -e "\e[91m:: Falha na instalação das ferramentas docker. ::\e[0m"

  exit 1

} 

# :::::::::::::::::::::::::::::::

{ # Ativa serviços que a aplicação é dependente.

  echo;echo -e "\e[34m:: Construir imagem docker da aplicação e contêineres de serviços. ::\e[0m";echo

  # Executa ativação
  sudo docker-compose -f $COMPOSE_FILE up -d --build

} || {

  # Remove os serviços parados que eventualmente são
  # criados para suportar a construção da aplicação.
  STOPPED=$(docker ps -a -q --filter="status=exited")

  if [ $STOPPED ]; then

    echo;echo -e "\e[33m:: Removendo contêineres anônimos parados. ::\e[0m";echo

    sudo docker rm $STOPPED

  fi

  echo;echo -e "\e[33m:: Removendo serviços criados em função destes contêineres. ::\e[0m";echo

  sudo docker-compose -f $COMPOSE_FILE down -v 

  echo;echo -e "\e[91m:: Falha na ativação dos serviços. ::\e[0m";echo

  exit 1

}

# :::::::::::::::::::::::::::::::

echo;echo -e "\e[32m::: Construção finalizada. :::\e[0m";echo

