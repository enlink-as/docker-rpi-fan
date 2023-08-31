# Builder
FROM python:3.11-slim@sha256:996c5fa16c8a1ffdfe757c90ab1b61d28b861c2c0edd71aaf8f7c95ffc08dacd as builder

COPY ./requirements.txt ./

RUN apt update \
    && apt install -y --no-install-recommends build-essential \
    && pip3 install --user -r requirements.txt

# Executor
FROM python:3.11-slim@sha256:996c5fa16c8a1ffdfe757c90ab1b61d28b861c2c0edd71aaf8f7c95ffc08dacd

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY ./fan.py ./

CMD ["python", "-u", "./fan.py"]