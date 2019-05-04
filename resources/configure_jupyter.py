
# Basically does the following:

# jupyter notebook password
# jupyter notebook --generate-config
# wget -O ~/.jupyter/jupyter_notebook_config.py https://raw.githubusercontent.com/mwufi/terraforma/master/resources/jupyter_config.py 
# 

import os, errno
from textwrap import dedent


def genConfigString(password):
    return dedent("""
    # 
    # Basic config for password
    # 
    c = get_config()
    c.IPKernelApp.pylab = 'inline'  
    c.NotebookApp.open_browser = False
    c.NotebookApp.ip = '*'

    # Note: 
    # Setting ip to '*' hits a small bug in Jupyter
    # See https://github.com/jupyter/notebook/pull/4139/files
    c.NotebookApp.allow_remote_access = True

    c.NotebookApp.password = '{}'
    """.format(password))


def message(m):
    print('-' * 20)
    print(m)
    print('-' * 20)


def getPassword():
    message("Hello, friend! Let's set up your Jupyter notebook...")

    # this already implements the interactive dialog + hashing
    from IPython.lib import passwd
    password = passwd()

    return password


def writeConfigFile():
    password = getPassword()
    s = genConfigString(password)
    if not os.path.exists('~/.jupyter'):
        os.mkdir('~/.jupyter')
    
    with open('~/.jupyter/jupyter_notebook_config.py', 'w') as f:
        f.write(s)

    print('ok')

writeConfigFile()