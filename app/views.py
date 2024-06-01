from rest_framework import viewsets, filters
from django_filters.rest_framework import DjangoFilterBackend

from .models import Todo
from .serializer import TodoSerializer

class TodoViewSets(viewsets.ModelViewSet):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    filter_backends = [
        DjangoFilterBackend, filters.OrderingFilter,filters.SearchFilter
    ]
    filterset_fields = ['title','description','completed']
    search_fields = ('title')
    ordering_fields = ('completed','created_at','updated_at')

