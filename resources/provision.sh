# ====== Provisioning: This script runs when the VM is starting up ===

# Install Flask! (as a test)
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
pip install flask

# Configure Jupyter notebook
wget -O configure_jupyter.py https://raw.githubusercontent.com/mwufi/terraforma/master/resources/configure_jupyter.py

echo "Ready for action!"