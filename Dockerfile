FROM python:3.10.12-slim-bullseye

WORKDIR /main

COPY requirements.txt requirements.txt

RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential libffi-dev cmake libcurl4-openssl-dev nodejs screen && \
    python -m pip install --no-cache-dir -U pip==<desired_pip_version> && \  # Replace <desired_pip_version> with the version you want
    pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x ./main.py

RUN chmod -R 777 /app
CMD screen -d -m python3 check.py
CMD uvicorn main:main --host 0.0.0.0 --port 7860
