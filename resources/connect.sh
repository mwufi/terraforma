# Connects to the VM + Adds the app.py file

cat resources/welcome.txt

ssh-keygen -R `terraform output ip`
scp resources/app.py `terraform output ip`:~/app.py
ssh `terraform output ip` -L 8888:localhost:8888