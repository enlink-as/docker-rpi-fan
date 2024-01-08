# Builder
FROM python:3.9-slim@sha256:ec4dbd81e414a6a55d6393835daeeb280159043fa4dc684bd58c8be7ef114ec3 as builder

COPY ./requirements.txt ./

RUN apt update \
    && apt install -y --no-install-recommends build-essential \
    && pip3 install --user -r requirements.txt

# Executor
FROM python:3.9-slim@sha256:ec4dbd81e414a6a55d6393835daeeb280159043fa4dc684bd58c8be7ef114ec3

WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY ./fan.py ./

CMD ["python", "-u", "./fan.py"]