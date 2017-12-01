#!/bin/sh

APP=${1:-user-invoices}
DEP=github.com/golang/dep/cmd/dep

# Estratégia adorata com base ao conceito de ciclo de vida presente no Maven (Java)
echo;echo -e '\e[1;34m :: Processo construção da aplicação iniciado. ::\e[0m';echo

{ # É obrigatoriamente necessário ter sucesso no bloco anterior para que o corrente seja executado.

  echo -e '\e[1;33m :: Atribundo pasta atual como GOPATH. ::\e[0m'
  export GOPATH=$(pwd)

} && {

  echo;echo -e '\e[1;34m :: Clean. ::\e[0m'
  go clean -n -x $APP 

} && {

  echo; echo -e '\e[1;34m :: Dep. ::\e[0m'

  # Para que 'go get' seja usado de dentro da imagem docker
  if [ ! -f "src/$DEP" ]; then

    echo;echo -e '\e[1;33m :: Baixando e construindo golang/dep. ::\e[0m';echo
    go get -u $DEP
    go build $DEP

  fi
  
  # Considerar a existência de um projeto vazio ou que
  # precisa ter o gerenciamento de dependência implementado
  if [ ! -f "src/$APP/Gopkg.toml" ]; then

    echo;echo -e '\e[33m :: Gopkg.toml não encontrado. Inicializando gerenciamento de dependências. ::\e[0m';echo
    bin/dep init src/$APP
  
  else
  
    echo;echo -e '\e[32m :: Gopkg.toml encontrado. Instalando as dependências registradas. ::\e[0m';echo
  
  fi	
  
  # Instalar as dependências
  cd src/$APP
  ../../bin/dep ensure -v
  cd ../..
  
} && {

  # Teste
  echo;echo -e '\e[1;34m :: Test. ::\e[0m'
  go test -v $APP

} && {

  # Instalação
  echo;echo -e '\e[1;34m :: Install. ::\e[0m'
  go install -v $APP

} && {

  # Construção
  echo;echo -e '\e[1;34m :: Build. ::\e[0m'
  go build -v -o bin/$APP $APP

} || {  # Tratamento de exceção

  echo;echo -e '\e[91m :: Falha na construção. ::\e[0m';echo

  echo 1

}

echo;echo -e '\e[32m :: Processo de construção concluído. ::\e[0m';echo
