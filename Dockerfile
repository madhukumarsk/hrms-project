FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . /app/

# Expose the port Django runs on
EXPOSE 8000

# Run migrations and collect static files
RUN python manage.py migrate && python manage.py collectstatic --noinput

# Start the Django application
CMD ["gunicorn", "project.wsgi:application", "--bind", "0.0.0.0:8000"]
