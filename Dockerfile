FROM python:3.9-alpine

ENV PYTHONFAULTHANDLER=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONHASHSEED=random
ENV PYTHONDONTWRITEBYTECODE 1
ENV PIP_NO_CACHE_DIR=on
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

ADD . /code
WORKDIR /code

RUN apk add --no-cache ffmpeg \
    && apk add --no-cache --virtual .build-deps python3-dev build-base py3-virtualenv \
    && pip3 install -r requirements.txt \
    && apk del .build-deps

ENTRYPOINT ["python3", "bot/bot.py"]

CMD ["bash"]
