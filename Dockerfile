FROM python:3.10-slim-bullseye AS builder

WORKDIR /app

COPY requirements.txt /app

RUN apt-get update 
RUN apt-get install -y  gcc curl python3-dev openssl

RUN curl -LsSO https://r.mariadb.com/downloads/mariadb_repo_setup && chmod +x mariadb_repo_setup
RUN ./mariadb_repo_setup \
   --mariadb-server-version="mariadb-10.6"

RUN apt-get install -y libmariadb3 libmariadb-dev

RUN pip install --upgrade pip

#RUN --mount=type=cache,target=/root/.cache/pip \
RUN pip3 install -r requirements.txt

COPY . /app

ENTRYPOINT ["python3"]
CMD ["app.py"]