# Invoices

Serviço em API para gerir faturas.

## Objetivo

Este artefato destina-se ao usufruto da comunidade que deseja aplicar as tecnologias e conceitos aqui referenciados, além de servir apresentação de conhecimentos adquiridos e aplicados para fins de portfolio.

## Especificações 

{intro}

### Metodológicas

{intro}

#### Licenciamento

* [Apache 3.0]()

#### Organização de pastas do projeto

* `src`: 
* `rsc`: 
* `scr`: 
* `pub`: 

#### Tecnologias e metodologias aplicados

* API ReST
* Cache
* Autenticação
* Persistência
* Testes Unitários
* Testes de Integração

#### Plano de Teste

{intro, como os testes são aplicados, recursos consumidos, tecnologias palicadas, metodologias aplicadas, pontos de manutenção e expansão}

#### Plano de implantação

{intro, instruções de implantação, instruções caso docker não seja usado - rodar script build}

#### Descrição dos scripts de construção

---

### Funcionais

#### Requisitos funcionais e não funcionais

#### Casos de Uso / APIs

(citar swagger)

* 

### Técnicas

#### Linguagens de alto-nível aplicadas

* [go](): para construção da aplicação;
* [sql](): para criação de esquema de base de dados no **PostgreSQL**;
* [perl](): para configuração do **pgTAP**;
* [yaml](): para configuração e construções de imagens com **docker-compose** e descrição da documentação de API com **swagger**; e
* [shell](): para construção dos scripts de configuração de requisitos técnicos e ambiente **Linux**.

#### Pontos de integração

#### Infraestrutura

* Base de Dados

* Memória cache

### Implantação

São os serviços orquestrados como contêineres docker para compor a infraestrutura da aplicação:

* [Memcached]()
* [PostgreSQL]()
