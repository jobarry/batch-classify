FROM python:3.7

# Set correct timezone
ENV TZ=Europe/Dublin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Create working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy the python package requirements
COPY requirements.txt .

# Pip install python packages
RUN pip install --no-cache-dir -r requirements.txt

# Set as root user
USER nobody

# Copy execution scripts
COPY batch_classify ./batch_classify

# Execute image
# ENTRYPOINT ["python3", "batch_classify"]
# CMD ["--help"]
