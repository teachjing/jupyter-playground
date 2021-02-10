# Import required modules

# Get list of modules
$modules = ( Get-ChildItem "~/Notebooks/PowerShell/custom-modules" | Where-Object {$_.name -like "*.psm1"} )
$credentialPath = "~/Notebooks/PowerShell/credentials" ## Where to store credentials

################## Import all modules in $module variable #############################

Try {
    ForEach ($module in $modules) {
        Import-Module "~/Notebooks/PowerShell/custom-modules/$($module.name)" -Force  ## import module 
        #Get-Command -Module "$module"## list commands in this module 
    }
    Write-Host -foreground yellow "The following modules were imported successfully."
    Write-Host -foreground green ($modules.name -join ", ") 
}
Catch {
    Write-Error "Problem importing module"
}

################## Import all required modules #############################
ForEach ($module in $requiredModules) {
    Install-module $module -Force;
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