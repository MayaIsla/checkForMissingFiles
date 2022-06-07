$dir1 = “D:\Desktop\Example1” #replace this with the destination of the source file (\\wab-ftepw01\usr\FIS\PDFStmts\*.pdf)
$dir2 = “D:\Desktop\Example2” #where ever the TRG files are located...
$RESULTS = "D:\Desktop\Results.txt"

#replace this with the *.pdf file extension. 
$outputDirFile1 = get-ChildItem -Path $dir1 -Filter *.txt | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)} 
#replace this with the *.trg file extension
$outputDirFile2 = get-ChildItem -Path $dir2 -Filter *.rtf | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}

#outputs the missing pdf file name (without extension)
Compare-Object $outputDirFile2 $outputDirFile1 | Out-File $RESULTS  #will output the missing file


If ((Get-Content $RESULTS) -ne $Null) #checks if there are missing files populated
{
Write-Host "Missing files found. Sending txt file to FIS."

#send email to client.

$outlook = New-Object -ComObject Outlook.Application
    $Mail = $outlook.CreateItem(0)
    $Mail.to = "EmailofPersontosendto@blah.com"
    $Mail.Subject = "Missing PDF for the following TRG file name"
    $Mail.Body = "FIS MISSING STATEMENT PDF FILES."
    $file = $RESULTS
    $Mail.Attachments.Add($file)
    $Mail.Send()
} 

else
{
Write-Host "No missing files found. Move on to next script."
#kick off .exe here..
}


 





                                                                                                    
                                                                                                    
