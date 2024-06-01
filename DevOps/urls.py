from django.contrib import admin
from django.urls import include,path
# from app.views import index # type: ignore

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',include('app.urls')),
    path('api-auth/',include('rest_framework.urls'))
]
