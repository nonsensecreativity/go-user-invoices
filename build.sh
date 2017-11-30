#!/bin/sh

APP=user-invoices
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

  echo; # echo -e '\e[1;34m :: Dep. ::\e[0m'

  # Para go get não ser usado de dentro da imagem docker
  # if [ ! -f ./src/$DEP ]; then
    # go get -u $DEP
  # fi
  # bin/dep $APP

} && {

  echo;echo -e '\e[1;34m :: Test. ::\e[0m'
  go test -v $APP

} && {

  echo;echo -e '\e[1;34m :: Install. ::\e[0m'
  go install -v $APP

} && {

  echo;echo -e '\e[1;34m :: Build. ::\e[0m'
  go build -v -o bin/$APP $APP

} || {

  echo;echo -e '\e[91m :: Falha na construção. ::\e[0m';echo
  
  exit 1

}

echo;echo -e '\e[32m :: Processo de construção concluído. ::\e[0m';echo
