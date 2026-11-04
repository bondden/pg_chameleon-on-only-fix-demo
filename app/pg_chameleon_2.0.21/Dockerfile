FROM python:3.11-slim

RUN pip install --no-cache-dir pg_chameleon==2.0.21

RUN groupadd --gid 1000 wbh && \
    useradd --uid 1000 --gid wbh --shell /bin/bash --create-home wbh

USER wbh:wbh

RUN chameleon set_configuration_files

VOLUME /home/wbh/.pg_chameleon/configuration
VOLUME /home/wbh/.pg_chameleon/logs

ENTRYPOINT ["chameleon"]
CMD ["show_status", "--config", "default"]
