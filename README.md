# Django_project
## Clone repo 
### Option 1
    git clone https://<github username>:<PAT>@github.com/DevOps1Developer/Django_project.git

### Option 2
    git clone https://github.com/DevOps1Developer/Django_project.git

## Change directory to the repo
    cd Django_project 

## Install packages in  Virtual environment
### First Activate the project
### (For powershell)
* Open your terminal and do the following
    * cd ".\env\Scripts\"
    * Activate.ps1
    * cd ..
    * cd ..
    * pip install -r requirements.txt

### (For powershell)
* Open your terminal and do the following
    * cd  "./env/Scripts/"
    * activate.bat
    * cd ..
    * cd ..
    * pip install -r requirements.txt

    This is to install all packages listed in the requirements.txt

## Start your django project
* cd DevOps
* python manage.py runserver
* copy the http://127.0.0.1:8000/ and paste it in your browser

This is simple instruction