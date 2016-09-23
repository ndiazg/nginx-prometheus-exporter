FROM alpine:latest

EXPOSE 3093

ENV GO_VERSION 1.6.3-r0
ENV GOPATH     /go
ENV PATH       /go/bin:$PATH
ENV SRC_PATH   /go/src/github.com/google/mtail

RUN apk add --update musl go=$GO_VERSION git bash make && \
	mkdir -p $SRC_PATH && cd $SRC_PATH/../ && \
	git clone https://github.com/google/mtail.git && \
	cd $SRC_PATH && git reset --hard 65d3620c858829c218370b0616ca0438add23186 && \
	make install_coverage_deps && make install_gen_deps && make install && \
	mv `which mtail` /usr/local/bin/mtail && \
	apk del --purge musl go git && rm -rf $GOPATH

COPY files/ /mtail/

ENTRYPOINT ["/usr/local/bin/mtail", "-v=2", "-logtostderr", "-port", "3093", "-progs", "/mtail/progs", "-logs"] 
