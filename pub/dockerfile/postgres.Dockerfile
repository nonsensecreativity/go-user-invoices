FROM postgres:10-alpine

ENV PGTAP_VERSION v0.98.0

RUN apk -U add \
    alpine-sdk \
    perl \
    postgresql-dev \
 && git clone https://github.com/theory/pgtap \
 && cd pgtap \
 && git checkout ${PGTAP_VERSION} \
 && make \
 && make install

# ###

FROM postgres:10-alpine

COPY --from=0 \
     /usr/local/share/postgresql/extension/pgtap* \
     /usr/local/share/postgresql/extension/

RUN apk -U add \
    perl-module-build \
    perl-pod-coverage \
    perl-utils

# Instala o pgTAP (Perl/Cpan) e executa testes unitários, a partir
# do roteiro em t/pgtap.sql
RUN echo "yes" | cpan TAP::Parser::SourceHandler::pgTAP; exit 0

RUN pg_prove

