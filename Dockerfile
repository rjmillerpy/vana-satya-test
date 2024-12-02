FROM python:3.12-slim

# Install dependencies required for building Meson
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    build-essential \
    ninja-build \
    && apt-get clean

# Install Meson from the specific commit
RUN git clone https://github.com/mesonbuild/meson.git && \
    cd meson && \
    git checkout 187ef425f96b9ba091edce56e9491373c51b2a34 && \
    python3 -m pip install --upgrade .

# Create required directories
RUN mkdir /sealed && chmod 777 /sealed

WORKDIR /app

COPY . /app

# Install any needed Python packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "-m", "my_proof"]

RUN meson --version
