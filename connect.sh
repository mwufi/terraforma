# Connects to the VM + Adds the app.py file

ssh-keygen -R `terraform output ip`
scp resources/app.py `terraform output ip`:~/app.py
ssh `terraform output ip`
