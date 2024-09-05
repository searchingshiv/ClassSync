# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install Node.js and npm
RUN apt-get update && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install additional dependencies for image processing
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0

# Install supervisor to manage multiple services
RUN apt-get install -y supervisor

# Set up directories
WORKDIR /app

# Copy all the server files to /app
COPY ./backend/flask /app/flask
COPY ./backend/node /app/node
COPY ./app /app/frontend

# Install Python dependencies
RUN pip install --no-cache-dir -r /app/flask/requirements.txt

# Install Node.js dependencies
RUN cd /app/node && npm install
RUN cd /app && npm install

# Expose necessary ports
EXPOSE 3000 5000 5001

# Copy supervisor configuration file
COPY supervisord.conf /etc/supervisord.conf

# Command to start all services
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
