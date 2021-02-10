
## Invoke Docker API
function Invoke-DockerAPI {
    [CmdletBinding()]
    param(
        [string]$url = "http://localhost",
        [string]$path,
        [string]$method,
        [string]$body,
        [array]$filter = @()
    )
    if ($path) {
        $response
        Try {
            $endpoint = "$url/$path"
            Write-Host -foreground yellow "Making $method request at Docker API at $endpoint`n"

            switch ($method) {
                "POST" {
                    $response = (curl -s -X POST --unix-socket /var/run/docker.sock --header --data $body "Content-Type: application/json" $endpoint)
                }
                "DELETE" {
                    Write-Host -foreground yellow "Deleting.... This may take a bit........."
                    $response = (curl -s -X DELETE --unix-socket /var/run/docker.sock $endpoint)
                }
                default {
                    $response = (curl -s --unix-socket /var/run/docker.sock $endpoint)
                }
            }

            $json = ($response | ConvertFrom-JSON)                                ## Convert response to JSON
            if ($null -ne $json.message) {
                Write-Host -foreground red $json.message
            }

            ## return response
            return $json  
        }
        Catch {
            return $_
        }
    } else {
        Write-Error "Path does not seem to be provided."
    }
}

## Gets all docker containers including inactive containers
function Get-DockerContainers {
    [CmdletBinding()]
    param(
        [string]$url = "http://localhost",
        [array]$filter = @()
    )
    
    $endpoint = "$url/containers/json?all=true"
    
    Write-Host -foreground yellow "Querying host at $endpoint`n"
    $response = (curl -s --unix-socket /var/run/docker.sock $endpoint | ConvertFrom-JSON | Select-Object $filter)
    return $response
}

function Add-DockerImage {
    [CmdletBinding()]
    param(
        [string]$url = "http://localhost",
        [string]$name
    )
    
    $endpoint = "$url/images/create?fromImage=$name"
    
    Write-Host -foreground yellow "Adding Image: $endpoint, Please be patient. It has to download `n"
    $response = (curl -s -X POST --unix-socket /var/run/docker.sock $endpoint)
    return $response

}

function Invoke-DockerImagePrune {
    [CmdletBinding()]
    param(
        [string]$url = "http://localhost",
        [string]$name
    )
    
    $endpoint = "$url/images/prune"
    
    Write-Host -foreground yellow "Adding Image: $endpoint`n"
    $response = (curl -s -X POST --unix-socket /var/run/docker.sock $endpoint | ConvertFrom-JSON)
    return $response
}