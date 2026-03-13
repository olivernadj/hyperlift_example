#FROM python:3-slim
#COPY index.html ./
#CMD ["python3", "-m", "http.server", "8080"]


FROM python:3-slim

# L2 — system package index (large, cache-friendly base)
RUN apt-get update

# L3 — install system tools (separate so apt-get update can be reused)
RUN apt-get install -y --no-install-recommends curl jq \
    && rm -rf /var/lib/apt/lists/*

# L4 — create non-root user and working directory
RUN useradd --create-home --shell /bin/bash appuser
WORKDIR /app

# L5 — install Python dependencies (changes rarely → good cache candidate)
RUN pip install --no-cache-dir flask requests

# L6 — copy app code + set version env var (changes often → intentionally late)
COPY server.py .
ENV APP_VERSION=1.0.1

# L7 — document the port
EXPOSE 8080

# L8 — runtime entrypoint
CMD ["python", "server.py"]

