# 
# Basic config for no-password!
# 
c = get_config()
c.IPKernelApp.pylab = 'inline'  
c.NotebookApp.open_browser = False
c.NotebookApp.ip = '*'
c.NotebookApp.password = ''