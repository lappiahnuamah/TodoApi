## TODO APPLICATION DOCUMENTATION

### Tasks 
1. [x] Create a virtual environment
2. [X] Create a Django project
3. [X] Create a Django app
4. [X] Add static files
5. [X] Create frontend
6. [X] Create the backend
7. [x] Create a admin to monitor the databases


<h4>View README.md for steps 1 - 3</h4>

### Add static files

* Create a directory called `static` in the app directory

* Inside the static directory can put your css and image files

* Inside any of your html files type {% load static % } to load files from the static directory  

### Add frontend 
* create `templates` directory in the app directory

* create `base.html` file. This file will contain things that will be across multiple pages

```html
{% load static %}
<!DOCTYPE html>
<html>
<head>
  <title>ToDo App</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="{% static 'css/styles.css' %}">
</head>
<body>
  <div class="container">
    {% block content %}
    {% endblock %}
  </div>
</body>
</html>

```
* Next, create `list.html` in that same directory and paste the following init

```html
{% extends 'view/base.html' %}

{% block content %}
  <div class="app-title">
    <h2>ToDo List</h2>
  </div>
  
  <a href="{% url 'todo_create' %}" class="floating-button">
    <p class="floating-button-icon">+</p>
  </a>
  {% for todo in todos %}
    <div class="todo">
      <h3 class="todo-title">{{ todo.title }}</h3>
      <div class="todo-body">
        <div class="todo-content">
          <p>{{ todo.description }}</p>
          <p>Completed: {{ todo.completed }}</p>
        </div>
        <div class="todo-option">
          <div>options</div>
          <div class="dropdown-content">
            <a href="{% url 'todo_update' todo.id %}">Edit</a>
            <a href="{% url 'todo_delete' todo.id %}">Delete</a>
          </div>
        </div>
      </div>
      </div>
    </div>
  {% endfor %}
{% endblock %}
```

This will show us the task we have in our todo list

* Next, create `create.html` and paste the following init
```html
{% extends 'view/base.html' %}
{% load static %}

{% block content %}

  <div class="app-title">
    <h2>New Task</h2>
  </div>
  <form method="POST">
    {% csrf_token %}
    <label>Title:</label>
    <input type="text" name="title" placeholder="Enter your Title ...">
    
    <label>Description:</label>
    <textarea name="description"></textarea>


    <input type="submit" value="submit"/>
  </form>
{% endblock %}
```

* Next, create `update.html` and paste the following init

```html
{% extends 'view/base.html' %}

{% block content %}
  <div class="app-title">
    <h2>Edit Task</h2>
  </div>
  
  <form method="POST">
    {% csrf_token %}
    <label>Title:</label>
    <input type="text" name="title" value="{{ todo.title }}">
    <label>Description:</label>
    <textarea name="description">{{ todo.description }}</textarea>
    <label>Completed:</label>
    <input type="checkbox" name="completed" {% if todo.completed %}checked{% endif %}>
    <input type="submit" value="submit"/>
  </form>
{% endblock %}

```
This helps us to update our todo list or tasks

* Lastly, create `delete_confirmed.html` file and paste the following lines of code init

```html
{% extends 'view/base.html' %}

{% block content %}
  <h2>Delete Task</h2>
  <p>Are you sure you want to delete "{{ todo.title }}"?</p>
  <form method="POST">
    {% csrf_token %}
    <input value="Yes" style="background-color: red;" type="submit"/>
  </form>
  <a class='btn btn-primary' href="{% url 'todo_list' %}">No, Go Back</a>
{% endblock %}
```

This performs deletion in the todo application


### Create the backend
* First create a model that will represent a table in the database

```python 
from django.db import models

class Todo(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    completed = models.BooleanField(default=False)

    def __str__(self):
        return self.title
```

In this model there are columns such as `title` which contains characters, `decription` which also Text ( combination of characters or sentences) and `complete` which contains false or true

* Secondly, create our views in the views.py
```python
from django.shortcuts import render, redirect
from .models import Todo

def todo_list(request):
    todos = Todo.objects.all()
    return render(request, 'view/list.html', {'todos': todos})

def todo_create(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        description = request.POST.get('description')
        todo = Todo.objects.create(title=title, description=description)
        return redirect('todo_list')
    return render(request, 'view/create.html')

def todo_update(request, pk):
    todo = Todo.objects.get(pk=pk)
    if request.method == 'POST':
        todo.title = request.POST.get('title')
        todo.description = request.POST.get('description')
        todo.completed = 'completed' in request.POST
        todo.save()
        return redirect('todo_list')
    return render(request, 'view/update.html', {'todo': todo})

def todo_delete(request, pk):
    todo = Todo.objects.get(pk=pk)
    if request.method == 'POST':
        todo.delete()
        return redirect('todo_list')
    return render(request, 'view/delete_confirm.html', {'todo': todo})

```

* Thirdly, create a urls.py in that same directory and paste the following lines of code init

```python
# from rest_framework.routers import DefaultRouter
# from app.views import ItemViewSet

# router = DefaultRouter()
# router.register(r'items', ItemViewSet)

# urlpatterns = router.urls
from django.urls import path
from . import views

urlpatterns = [
    path('', views.todo_list, name='todo_list'),
    path('create/', views.todo_create, name='todo_create'),
    path('update/<int:pk>/', views.todo_update, name='todo_update'),
    path('delete/<int:pk>/', views.todo_delete, name='todo_delete'),
]
```
These serve as routes or channels to get our views

* Lastly, navigate out of the app folder and into the DevOps folder `./Django_project/env/DevOps/DevOps/`
and update the urls.py file by pasting this init

```python
from django.contrib import admin
from django.urls import include,path

urlpatterns = [
    path('admin/', admin.site.urls),
    path((''),include('app.urls'))
]
```

* In your terminal type the following
```
python manage.py makemigration app
python manage.py migrate 
```
This will create the database and its table

## Create an admin to monitor the databases
* In the terminal type `python manage.py createsuperuser`
    * You will be prompted to enter a username, email address, and password for the superuser. The username and password are required, while the email address is optional.
    
    * Please note that the superuser has all permissions and can manage all aspects of the site. Be sure to keep the superuser’s credentials secure. Also, remember to replace python with python3 or the specific version of Python you’re using if necessary. If you’re using a virtual environment, make sure it’s activated before running the command