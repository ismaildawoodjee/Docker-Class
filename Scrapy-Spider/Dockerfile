FROM python:3.7
WORKDIR /app

# good practice to COPY requirements.txt in a separate step
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# need to expose port 80 for scrapy to work
EXPOSE 80
CMD ["scrapy", "crawl", "Books"]
