#!/usr/bin/env bash

# Connects to the VM + Adds the app.py file
cat resources/welcome.txt

if [[ -z "$CONNECTED_ALREADY" ]]; then
    ssh-keygen -R `terraform output ip`
    scp resources/app.py `terraform output ip`:~/app.py
    ssh `terraform output ip` -L 8888:localhost:8888
    export CONNECTED_ALREADY=True
else
    echo "Connecting..."
    ssh `terraform output ip`
end