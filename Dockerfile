FROM python:3.8.1-slim-buster

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./api /code/api

CMD ["uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "8000"]