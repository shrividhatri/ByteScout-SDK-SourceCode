# The authentication key (API Key).
# Get your own by registering at https://app.pdf.co/documentation/api
$API_KEY = "********************************"

# Source PDF file
$SourceFile = ".\sample-rotated.pdf"
# Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
$Pages = ""
# PDF document password. Leave empty for unprotected documents.
$Password = ""
# Destination TXT file name
$DestinationFile = ".\result.txt"

# Sample profile that sets advanced conversion options
# Advanced options are properties of CSVExtractor class from ByteScout PDF Extractor SDK used in the back-end:
# https://cdn.bytescout.com/help/BytescoutPDFExtractorSDK/html/87ce5fa6-3143-167d-abbd-bc7b5e160fe5.htm

# Valid RotationAngle values:
# 0 - no rotation
# 1 - 90 degrees
# 2 - 180 degrees
# 3 - 270 degrees
$Profiles = '{ "profiles": [{ "profile1": { "RotationAngle": 1 } } ] }'


# 1. RETRIEVE THE PRESIGNED URL TO UPLOAD THE FILE.
# * If you already have a direct file URL, skip to the step 3.

# Prepare URL for `Get Presigned URL` API call
$query = "https://api.pdf.co/v1/file/upload/get-presigned-url?contenttype=application/octet-stream&name=" + `
    [System.IO.Path]::GetFileName($SourceFile)
$query = [System.Uri]::EscapeUriString($query)

try {
    # Execute request
    $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query
    
    if ($jsonResponse.error -eq $false) {
        # Get URL to use for the file upload
        $uploadUrl = $jsonResponse.presignedUrl
        # Get URL of uploaded file to use with later API calls
        $uploadedFileUrl = $jsonResponse.url

        # 2. UPLOAD THE FILE TO CLOUD.

        $r = Invoke-WebRequest -Method Put -Headers @{ "x-api-key" = $API_KEY; "content-type" = "application/octet-stream" } -InFile $SourceFile -Uri $uploadUrl
        
        if ($r.StatusCode -eq 200) {
            
            # 3. CONVERT UPLOADED PDF FILE TO TXT

            # Prepare URL for `PDF To TXT` API call
            $query = "https://api.pdf.co/v1/pdf/convert/to/text?name={0}&password={1}&pages={2}&url={3}&profiles={4}" -f `
                $(Split-Path $DestinationFile -Leaf), $Password, $Pages, $uploadedFileUrl, $Profiles
            $query = [System.Uri]::EscapeUriString($query)

            # Execute request
            $jsonResponse = Invoke-RestMethod -Method Get -Headers @{ "x-api-key" = $API_KEY } -Uri $query

            if ($jsonResponse.error -eq $false) {
                # Get URL of generated TXT file
                $resultFileUrl = $jsonResponse.url;
                
                # Download TXT file
                Invoke-WebRequest -Headers @{ "x-api-key" = $API_KEY } -OutFile $DestinationFile -Uri $resultFileUrl

                Write-Host "Generated TXT file saved as `"$($DestinationFile)`" file."
            }
            else {
                # Display service reported error
                Write-Host $jsonResponse.message
            }
        }
        else {
            # Display request error status
            Write-Host $r.StatusCode + " " + $r.StatusDescription
        }
    }
    else {
        # Display service reported error
        Write-Host $jsonResponse.message
    }
}
catch {
    # Display request error
    Write-Host $_.Exception
}