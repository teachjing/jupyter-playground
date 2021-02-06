## Allow password to be changed at login for the notebook server.
#
#  While loggin in with a token, the notebook server UI will give the opportunity
#  to the user to enter a new password at the same time that will replace the
#  token login mechanism.
#
#  This can be set to false to prevent changing password from the UI/API.
c.ServerApp.allow_password_change = True

## Token used for authenticating first-time connections to the server.
#
#  When no password is enabled, the default is to generate a new, random token.
#
#  Setting to an empty string disables authentication altogether, which is NOT
#  RECOMMENDED.
c.ServerApp.token = ''

## The directory to use for notebooks and kernels.
#  Default: ''
#c.ServerApp.root_dir = ''

## Disable launching browser by redirect file
#  
#  For versions of notebook > 5.7.2, a security feature measure was added that prevented the authentication token used to launch the browser from being visible. This feature makes it difficult for 
#  other users on a multi-user system from running code in your Jupyter session as you.
#  
#  However, some environments (like Windows Subsystem for Linux (WSL) and Chromebooks), launching a browser using a redirect file can lead the browser failing to load. This is because of the 
#  difference in file structures/paths between the runtime and the browser.
#  
#  Disabling this setting to False will disable this behavior, allowing the browser to launch by using a URL and visible token (as before). Default: True
## 
# Im using this to not have to type in /lab in the url and go directly to http://127.0.0.1:8888
c.ServerApp.use_redirect_file = False
