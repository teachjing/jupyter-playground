function Invoke-GraphAuthenticateDeviceCode {

    ## Code sourced from The Lazy Administrator
    ## Blog Link here - https://www.thelazyadministrator.com/2019/07/22/connect-and-navigate-the-microsoft-graph-api-with-powershell/#Playing_With_Graph_Data_Get_Put_Post_Delete_and_Patch

    param (
        $clientAppId, 
        $tenantDomain
    )

    $redirectUrl = [System.Uri]"urn:ietf:wg:oauth:2.0:oob" # This is the standard Redirect URI for Windows Azure PowerShell
    $resource = "https://graph.microsoft.com/";
    $serviceRootURL = "https://graph.microsoft.com//$tenantDomain"
    $authUrl = "https://login.microsoftonline.com/$tenantDomain";

    Write-Host "Authentication Parameters"
    Write-Host "Service Root URL: $($serviceRootURL)"
    Write-Host "Authentication URL: $($authUrl)"
    Write-Host "Resource URL: $($resource)"
    Write-Host "Powershell Redirect URL: $($redirectUrl)"
    Write-Host "Client APP ID: $($clientAppId)"
    Write-Host "Tenant Domain: $($tenantDomain)"
    $tokenResponse = $null
    
    if ($clientAppId -and $tenantDomain) {
        $postParams = @{ resource = "$resource"; client_id = "$clientAppId" }
        $postParams
        $response = Invoke-RestMethod -Method POST -Uri "$authurl/oauth2/devicecode" -Body $postParams
        Write-Host "`n $($response.message) "
        #I got tired of manually copying the code, so I did string manipulation and stored the code in a variable and added to the clipboard automatically
        $code = ($response.message -split "code " | Select-Object -Last 1) -split " to authenticate."
        Write-Host "Double click this code and CTRL-V to copy: " -NoNewLine; Write-Host -ForeGroundColor Red "$($code)"
        Set-Clipboard -Value $code
        #Start-Process "https://microsoft.com/devicelogin"

        $tokenParams = @{ grant_type = "device_code"; resource = "$resource"; client_id = "$clientAppId"; code = "$($response.device_code)" }    
    } else {
        Throw "No ClientAppID or TenantDomain provided.."
    }

    Write-Host -ForeGroundColor Yellow "`nWaiting for code"
    While ( (!$tokenResponse) -and ($clientAppId) -and ($tenantDomain) ) {
        Try {
            $tokenResponse = Invoke-RestMethod -Method POST -Uri "$authurl/oauth2/token" -Body $tokenParams -ErrorAction Ignore
            Write-Host -ForeGroundColor Green "`nReceived Token!"
            Write-Host -ForegroundColor Green "Connected and Access Token received and will expire $($tokenResponse.expires_on)"
            return $tokenResponse
        } Catch {
        }
    }
}