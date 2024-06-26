FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

# Salin requirements.txt terlebih dahulu untuk caching layer Docker yang lebih baik
COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# Salin sisa file aplikasi
COPY . ./

EXPOSE 8080

HEALTHCHECK CMD curl --fail http://localhost:8080/_stcore/health || exit 1

ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8080", "--server.address=0.0.0.0"]
