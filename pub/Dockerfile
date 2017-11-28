FROM golang:alpine AS builder

# Copiar fontes para a imagem
COPY src /go/src/

# Gerenciamento de dependências
# RUN apk --no-cache add git 
# RUN go get github.com/golang/dep/cmd/dep
# RUN bin/dep save

# Aplicar procedimento de construção da aplicação Go
RUN go clean
RUN go build src/main.go

# ::: ###### :::

FROM alpine AS deployer

# 
RUN apk --no-cache add ca-certificates

# Copiar binários da imagem anterior para esta
COPY --from=builder ./bin root/

# Definir WORKDIR
WORKDIR root/

# Definir porta exposta
ENTRYPOINT 5000

# Definir ponto de entrada
CMD ["main"]

