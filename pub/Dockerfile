FROM golang:alpine AS builder

# Copiar fontes para a imagem
COPY src /go/src/

# Gerir de dependências
# RUN apk --no-cache add git 
# RUN go get github.com/golang/dep/cmd/dep
# RUN bin/dep save

# Aplicar procedimento de construção da aplicação Go
RUN go clean

# Testes unitários (aplicação e banco de dados) e integração
RUN go test -run ''

# Construir a aplicação validada.
RUN go install user-invoices

# ::: ###### :::

FROM alpine AS deployer

# Inserir certificado ao container
RUN apk --no-cache add ca-certificates

# Copiar binários da imagem anterior para esta
COPY --from=builder ./bin root/

# Definir WORKDIR
WORKDIR root/

# Definir porta exposta
ENTRYPOINT 5000

# Definir ponto de entrada
CMD ["main"]

