# Import required modules
$modules = @('pp-core','graph') ## These are the modules to import 
$credentialPath = "~/Notebooks/PowerShell/credentials" ## Where to store credentials

################## Import all modules in $module variable #############################
ForEach ($module in $modules) {
    Import-Module "~/Notebooks/PowerShell/custom-modules/$module" -Force  ## import module 
    Get-Command -Module "$module"                                                        ## list commands in this module 
}

################## Import all required modules #############################
ForEach ($module in $requiredModules) {
    Install-module $module -Force
    Import-Module $module -Force  ## import module
}

## Import Credentials
$credentials = (Get-Content "~/Notebooks/PowerShell/credentials" | ConvertFrom-Json)

## Get a token if authenticates properly.
$authParams = @{
    tenantId = $credentials.tenantId
    client_id = $credentials.client_id
    client_secret = $credentials.client_secret
    resource = "https://api.securitycenter.windows.com"    ## resource Dont change since we want to query MDATP REST API Resource
    grant_type = "client_credentials"  ## This is using a appliation ID and secret to authenticate
};

## Corrects the output
$host.UI.RawUI.BufferSize = [System.Management.Automation.Host.Size]::new(200, 50) ## Corrects the output