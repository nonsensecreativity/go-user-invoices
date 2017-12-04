FROM postgres:alpine

ARG PGTAP_VER

# Esta construção é demorada. portanto, é melhor deixar em um contêiner transitório
RUN apk -U add \
    alpine-sdk \
    perl-dev \
    build-base

RUN cpan Log::Log4perl \
         Log::Dispatch \
         inc::latest \
         Devel::Symdump \
         Pod::Coverage \
         Test::Pod \
         Test::Pod::Coverage \
         TAP::Parser::SourceHandler::pgTAP \
 && git clone https://github.com/theory/pgtap \
 && cd pgtap \
 && git checkout -q $PGTAP_VER \
 && make \
 && make install \
 && make installcheck

