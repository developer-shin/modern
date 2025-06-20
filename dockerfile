# Use an official lightweight Python 3.11 image as the base
# This replaces `config.vm.box = "ubuntu/bionic64"`
FROM python:3.11-slim

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system-level dependencies that Django might need
# This replaces `apt-get install -y ...` from your Vagrantfile
# We add postgresql-client for database connectivity and zip as you had it before
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
    zip

# Set the working directory inside the container
WORKDIR /app

# Copy and install Python dependencies
# This replaces the need for `python -m venv ~/env` because the container IS the environment
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of your Django project code into the container
COPY . .