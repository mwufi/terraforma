# ====== Provisioning: This script runs when the VM is starting up ===

# Install Flask! (as a test)
sudo apt-get update
sudo apt-get install -yq build-essential python-pip rsync
pip install flask

# Configure Jupyter notebook
jupyter notebook --generate-config
wget -O ~/.jupyter/jupyter_notebook_config.py https://raw.githubusercontent.com/mwufi/terraforma/master/resources/jupyter_config.py 

echo "Ready for action!"