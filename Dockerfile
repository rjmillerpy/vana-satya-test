FROM python:3.12-slim

# Install dependencies required for building Meson
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    build-essential \
    ninja-build \
    && apt-get clean

# Create required directories
RUN mkdir /sealed && chmod 777 /sealed

WORKDIR /app

COPY . /app

# Install any needed Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "my_proof"]
