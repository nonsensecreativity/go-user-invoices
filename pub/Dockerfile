FROM golang:alpine AS builder

# Copiar fontes para a imagem
COPY . .

# Executar script de construção da aplicação
RUN ./build.sh

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

