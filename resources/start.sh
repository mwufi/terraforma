# ====== Provisioning: This script runs when the VM is starting up ===

sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
pip install flask