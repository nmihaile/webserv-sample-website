FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	bash \
    valgrind \
    make \
    g++ \
    git \
    curl \
    vim \
	php-cgi \
	python3 \
    siege

RUN mkdir -p /var/www/html /app

CMD ["bash"]