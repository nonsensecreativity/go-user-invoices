APP=user-invoices

echo;echo -e '\e[34m :: Processo construção da aplicação iniciado. ::\e[0m';echo

{

  echo;echo -e '\e[1;34m :: Clean. ::\e[0m'
  go clean -n -x $APP 

  echo;echo -e '\e[1;34m :: Test. ::\e[0m'
  go test -v $APP

  # echo;echo -e '\e[1;34m :: Install. ::\e[0m'
  # go install $APP

  echo;echo -e '\e[1;34m :: Build. ::\e[0m'
  go build -v -o bin/$APP $APP

} || {

  echo;echo -e '\e[91m :: Falha na construção. ::\e[0m';echo
  
  exit 1

}

echo;echo -e '\e[32m :: Processo de construção concluído. ::\e[0m';echo
