# FROM python:3.11-slim

# WORKDIR /app

# # Set environment variables
# # ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# COPY requirements.txt .
# RUN pip install -r requirements.txt

# COPY . . 


# EXPOSE 8000
# CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]




#Base image
FROM python:3.9-slim

WORKDIR /app

# set environment variables
# PYTHONDONTWRITEBYTECODE is an environment variable used by Python. When set to a non-empty value (in this case, 1), it prevents Python from writing ".pyc files" (bytecode) to disk. Bytecode files are compiled Python files, and setting this variable to 1 avoids creating them. This can be useful in certain scenarios, such as containerized or production environments, where writing bytecode files might not be desired.
# PYTHONUNBUFFERED is another environment variable related to Python. When set to a non-empty value (in this case, 1), it forces Python to run in unbuffered mode. In unbuffered mode, Python doesn't buffer the output, which means that each line is printed as soon as it is generated. This can be beneficial in containerized environments or when running Python in a script, ensuring that the output is immediately visible.
# ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONNUNBUFFERED 1
# ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# Create and activate virtual environment
# RUN: The RUN instruction is used to execute commands during the Docker image build process. In this case, it runs the command python -m venv /opt/venv, which creates a virtual environment named venv in the /opt directory. The virtual environment is a self-contained directory that contains its own Python interpreter and library.
# ENV PATH: The ENV instruction sets the PATH environment variable inside the Docker image. It adds the /opt/venv/bin directory to the beginning of the PATH variable. This ensures that when you run commands in the Docker image, the executables from the virtual environment take precedence over system-wide installations.
# Below two lines just "creates (venv) into (opt) dir and sets the (bin) as a (PATH)". It does not activate the (venv) and we don't need to activate because "docker" itself is a self-contained envrionment.
# also any command like "python or pip" will always first check into "bin" since it's set in PATH. so dependencies will automatically be installed into "venv"
# RUN python3 -m venv /app/venv
# ENV PATH="/app/venv/bin:$PATH"

# RUN pip install --upgrade pip
COPY requirements.txt .

RUN pip install -r requirements.txt
COPY . .
COPY ./nginx/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./scripts/certbot-auto /usr/local/bin/certbot-auto
RUN chmod +x /usr/local/bin/certbot-auto

# RUN python manage.py makemigrations

# RUN python manage.py migrate

# RUN python manage.py createsuperuser

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
