#!/bin/bash
docker pull lappiahnuamah/devops-1:latest
docker stop my-website || true
docker rm my-website || true