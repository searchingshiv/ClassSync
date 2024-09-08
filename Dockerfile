
WORKDIR /app

# Copy backend files
COPY ./app /app
# Expose port
EXPOSE 5000

# Install dependencies and build
RUN npm install && npm run build

# Expose frontend port
EXPOSE 3000

# Serve the frontend
CMD ["npm", "start"]
