# Dockerfile for N8N with Ollama Integration on Render

# Use the official N8N base image
FROM n8nio/n8n:latest

# Install dependencies for Ollama integration
RUN apk add --no-cache <additional-dependencies>

# Configure for Render environment
ENV NODE_ENV=production
ENV N8N_PORT=5678

# Set proper environment variables for N8N
ENV DB_TYPE=postgres
ENV DB_POSTGRESDB_HOST=your-database-host
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=your-database-name
ENV DB_POSTGRESDB_USER=your-database-user
ENV DB_POSTGRESDB_PASSWORD=your-database-password

# Expose port 5678 for N8N
EXPOSE 5678

# Health check to ensure the service is running
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:5678/ || exit 1

# Start N8N
CMD ["n8n"]