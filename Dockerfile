# Use a specific Python 3.10 version
FROM python:3.10.12-slim-bullseye

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN python -m venv venv \
    && . venv/bin/activate \
    && pip install --no-cache-dir -r requirements.txt

# Install additional system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    cmake \
    libcurl4-openssl-dev \
    screen

# Copy the rest of the application code
COPY . .

# Make sure app.py is executable
RUN chmod +x app.py

# Set the default command to run your application
CMD [ "python", "app.py" ]
