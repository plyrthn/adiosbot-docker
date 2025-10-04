FROM python:3.11-slim

WORKDIR /app

# Install dependencies
RUN pip install --no-cache-dir discord.py pytz requests

# Copy bot files
COPY main.py /app/main.py
COPY goodbye_songs.json /app/goodbye_songs.json

# Create data directory
RUN mkdir -p /data

# Set environment variable for working directory
ENV WORKING_DIR=/data

# Make main.py executable
RUN chmod +x /app/main.py

# Run as non-root user for security
RUN useradd -m -u 1000 botuser && chown -R botuser:botuser /app /data
USER botuser

CMD ["python", "/app/main.py"]