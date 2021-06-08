# Python 3.8 with Alpine image python:<version>-alpine<version>
# FROM python:3.8-alpine

# modify Dockerfile to use Ubuntu base image instead (comes with python pre-installed)
FROM ubuntu:20.04

# Copy everything from local repo into a container folder called /app
COPY . /app

# Set the working directory to be that folder
WORKDIR /app

# but pip was not found, need to update and install it, -y flag to automatically say Yes
RUN apt-get update -y && \
    apt-get install -y python3-pip python-dev build-essential

# Install Python libraries from requirements.txt, without caching, remove the "pkg-resources" line
RUN pip install --no-cache-dir -r requirements.txt | grep -v "pkg-resources"

# Expose port number 5000 as specified in Flask app
EXPOSE 5000

# Execute the commands "python ./index.py", just like writing in the terminal
CMD ["python", "./index.py"]