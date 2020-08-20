from django.urls import path
from . import views

urlpatterns = [
    path("rr/", views.rr, name="rrname"),
    path("cc/", views.cc, name="ccname"),
    path("uu/", views.uu, name="uuname"),
    path("dd/", views.dd, name="ddname"),
    path("replyrr/", views.rrr, name="rrrname"),
    path("replycc/", views.rcc, name="rccname"),
    path("search1/<name>", views.search1, name="search1"),
    path("search2/<content>", views.search2, name="search2"),
]