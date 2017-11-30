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
# COPY --from=builder bin bin/

# Definir WORKDIR
# WORKDIR bin

# RUN ls .

# Definir porta exposta
EXPOSE 5000

# Instrução principal
CMD ["user-invoices"]

ENTRYPOINT ["user-invoices"]
