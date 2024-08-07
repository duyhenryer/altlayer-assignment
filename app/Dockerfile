FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

COPY requirements.txt /app/requirements.txt

# Install the dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

# Expose the port
EXPOSE 8080
CMD ["fastapi", "run", "app.py", "--port", "8080"]