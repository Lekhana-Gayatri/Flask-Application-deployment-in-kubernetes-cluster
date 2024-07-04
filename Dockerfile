FROM python:3.8-slim-buster

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY app.py /app
COPY templates /app
COPY static /app
WORKDIR /app
EXPOSE 5000
CMD [ "python3", "app.py"]
