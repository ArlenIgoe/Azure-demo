# Importing System.Net namespace.
using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $CosmosIn, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Check if CosmosIn input binding is not present.
if (-not $CosmosIn) { 
    # Store the error message.
    $body = 'VisitorCounter item not found'
    Write-Host $body

    # Output the error message as a response with a 404 status code.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::NotFound 
        Body = $body
    })
}
else {
    # Store the visitor count value from the CosmosIn input binding.
    $visitorCount = $CosmosIn.visitorCount
    Write-Host "Found VisitorCounter item,  current visitorCount: $visitorCount"

    # Increment the visitor count by 1.
    $visitorCount++
    Write-Host "New visitorCount: $visitorCount"

    # Create an object to store the updated visitor count.
    $responseObject = @{
        VisitorCount = $visitorCount
    }

    # Convert the object to a JSON string.
    $responseJson = ConvertTo-Json -InputObject $responseObject
 
    # Output the updated visitor count to the CosmosOut output binding.
    Push-OutputBinding -Name CosmosOut -Value @{
        id = $CosmosIn.id
        visitorCount = $visitorCount
    }

    # Output the JSON string as a response with a 200 status code.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::OK 
        Body = $responseJson 
    })
}
