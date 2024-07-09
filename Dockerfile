FROM python:3-slim

WORKDIR /src

RUN set -eux; \
    apt-get update; \
    apt-get install -y git build-essential libffi-dev; \
    rm -rf /var/lib/apt/lists/*

# https://github.com/actions/runner-images/issues/6775
RUN git config --system --add safe.directory *

COPY src/requirements.txt ./
RUN pip install -r requirements.txt

COPY src/entrypoint /usr/local/bin/
COPY src/add-to-wiki /usr/local/bin/
COPY src/default.md.j2 /var/
RUN ln -s /github/workspace /home/runner/work/net-back/net-back 

WORKDIR /home/runner/work/net-back/net-back
# WORKDIR /github/workspace

CMD [ "entrypoint" ]
