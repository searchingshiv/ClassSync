# Use an official image as a base
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install npm dependencies
WORKDIR /app/backend
RUN npm install

# Install Python dependencies
WORKDIR /app/backend
COPY requirements.txt .
RUN pip install dlib==19.24.2 && pip install -r requirements.txt

# Copy the rest of the application
COPY . .

# Command to run your app
CMD ["npm", "start"]
