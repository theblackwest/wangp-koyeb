FROM pytorch/pytorch:2.7.1-cuda12.8-cudnn9-runtime

# System deps
RUN apt-get update && apt-get install -y \
    git ffmpeg libgl1 libglib2.0-0 wget curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone latest WanGP (v11+)
RUN git clone https://github.com/deepbeepmeep/Wan2GP.git .

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Expose Gradio port
EXPOSE 7860

# Launch — bind to all interfaces so Koyeb can route to it
CMD ["python", "wgp.py", \
     "--server-name", "0.0.0.0", \
     "--server-port", "7860", \
     "--listen"]
