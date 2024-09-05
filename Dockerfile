# Backend Dockerfile
# Use a Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy backend files
COPY ./backend /app/backend

# Install required Python dependencies
RUN pip install -r /app/backend/requirements.txt

# Install dlib for face recognition
RUN pip install dlib==19.24.2

# Expose port
EXPOSE 5000

# Run the backend
CMD ["python", "/app/backend/app.py"]

# Frontend Dockerfile
FROM node:14-alpine

WORKDIR /app

# Copy frontend files
COPY ./src /app/src
COPY ./package*.json /app/

# Install dependencies and build
RUN npm install && npm run build

# Expose frontend port
EXPOSE 3000

# Serve the frontend
CMD ["npm", "start"]
