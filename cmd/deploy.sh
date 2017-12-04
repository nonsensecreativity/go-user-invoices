#!/bin/sh

# Propriedades
PROJ_NAME="user-invoices"
DOCKER_COMPOSE_VERSION=1.17.1

## Caminhos - não modificar
COMPOSE_PATH="/usr/local/bin/docker-compose"
COMPOSE_FILE="pub/compose/user-invoices-compose.yml"
DOWNLOAD_URL="https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/run.sh"

# Remove imagens docker que foram criados para todo serviço construido no 
# docker compose que seja construído de um Dockerfile. Em caso de eventual 
# falha na construção, este tipo de serviço deixa residualmente uma imagem 
# sem tag. 
remover_sem_tag() {

  # TODO Imagens intermadiárias são geradas e eventualmente não são
  # removidas, dependendo do fluxo de execução 
  echo;echo "\e[33m:: Removendo imagens não etiquetadas. ::\e[0m";echo

  sudo docker rmi $(docker images | grep "^<none>" | awk '{print $3}') 

}

# ::: Roteiro de construção :::

echo;echo "\e[1;34m::: Inicio da construção da imagem. :::\e[0m";echo

# :::::::::::::::::::::::::::::::

{ # Instala 'docker' e 'docker-compose' caso estes recursos não estejam instalados.

  if [ ! -f $COMPOSE_PATH ];then  

    echo;echo "\e[33m:: ferramenta 'docker-compose' não detectada. \
	Realizar download do 'docker' e 'docker-compose'. ::\e[0m";echo
  
    sudo apt-get install --upgrade docker

    sudo curl -L -f $DOWNLOAD_URL -o $COMPOSE_PATH

    sudo chmod +x $COMPOSE_PATH

    echo;echo -"\e[32m:: Instalação concluída. ::\e[0m";echo

  fi

} || {

  echo;echo "\e[91m:: Falha na instalação das ferramentas docker. ::\e[0m" >&2

} 

# :::::::::::::::::::::::::::::::

{ # Ativa serviços que a aplicação é dependente.

  echo;echo "\e[34m:: Construir imagem docker da aplicação e contêineres de serviços. ::\e[0m";echo

  # Executa ativação
  sudo docker-compose \
      -p $PROJ_NAME \
      -f $COMPOSE_FILE \
      up -d --build --remove-orphans

} || {

  # Remove os serviços parados e imagens sem etiquetas
  # que eventualmente são criados para suportar a 
  # construção da aplicação.
  STOPPED=$(docker ps -a -q --filter="status=exited")

  if [ $STOPPED ]; then

    echo;echo "\e[33m:: Removendo contêineres anônimos parados. ::\e[0m";echo

    sudo docker rm $STOPPED

  fi

  echo;echo "\e[33m:: Removendo serviços criados em função destes contêineres. ::\e[0m";echo

  sudo docker-compose -f $COMPOSE_FILE down -v

  remover_sem_tag

  echo;echo "\e[91m:: Falha na ativação dos serviços. ::\e[0m";echo

  exit 1

}

# :::::::::::::::::::::::::::::::

remover_sem_tag

echo;echo "\e[32m::: Construção finalizada. :::\e[0m";echo

