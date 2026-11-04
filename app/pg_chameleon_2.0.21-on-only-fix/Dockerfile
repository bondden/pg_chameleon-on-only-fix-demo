FROM python:3.11-slim

# Source comes from the "src" build context, see bench.cps.yml
RUN --mount=type=bind,from=src,target=/src,rw pip install --no-cache-dir /src

RUN groupadd --gid 1000 wbh && \
    useradd --uid 1000 --gid wbh --shell /bin/bash --create-home wbh

USER wbh:wbh

RUN chameleon set_configuration_files

VOLUME /home/wbh/.pg_chameleon/configuration
VOLUME /home/wbh/.pg_chameleon/logs

ENTRYPOINT ["chameleon"]
CMD ["show_status", "--config", "default"]
