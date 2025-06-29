FROM tiangolo/uvicorn-gunicorn-fastapi:python3.9

COPY . /app
COPY ./orbix_config.json /app/orbix_config.json

WORKDIR /app
RUN pip install fastapi pydantic

EXPOSE 80
