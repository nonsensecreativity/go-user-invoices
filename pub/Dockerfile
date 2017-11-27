FROM golang:alpine AS builder


# Copiar fontes para a imagem
COPY src /go/src/

# Gerenciamento de dependências
# RUN apk --no-cache add git 
# RUN go get github.com/tools/godep
# RUN godep save

# Aplicar procedimento de construção da aplicação Go
RUN go install github.com/dhsrocha/user-invoices
RUN go build github.com/dhsrocha/user-invoices

# ::: ###### :::

FROM alpine AS deployer

# Metadata
LABEL maintainer="Diego Rocha" \
      vendor="Diego Rocha" \
      description="Gestor de chamadas de usuários" \
      version="0.1.0"

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /bin .

# Expor a porta e comando
# ENTRYPOINT ["./bin"]

EXPOSE 5000

