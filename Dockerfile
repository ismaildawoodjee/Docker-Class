FROM python:alpine3.8
COPY . /app
WORKDIR /app
RUN python -m pip install --user -r requirements.txt
EXPOSE 5000
CMD python ./index.py