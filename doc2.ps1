$dir1 = “D:\Desktop\Example1” #replace this with the destination of the source file (\\wab-ftepw01\usr\FIS\PDFStmts\*.pdf)
$dir2 = “D:\Desktop\Example2” #where ever the TRG files are located...

$Username = "userNameofYourEmail";
$Password = "passWordofYourEmail";

$RESULTS = "D:\Desktop\Results.txt"

#replace this with the *.pdf file extension. 
$outputDirFile1 = get-ChildItem -Path $dir1 -Filter *.txt | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)} 
#replace this with the *.trg file extension
$outputDirFile2 = get-ChildItem -Path $dir2 -Filter *.rtf | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}

#outputs the missing pdf file name (without extension)
Compare-Object $outputDirFile2 $outputDirFile1 | Out-File $RESULTS  #will output the missing file


function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = $Username;
    $message.Subject = "Missing PDF for the following TRG file name";
    $message.Body = "FIS MISSING STATEMENT PDF FILES";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);

    $smtp = new-object Net.Mail.SmtpClient("smtp.gmail.com", "587");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }

if ($files -ne 0) #if there are missing files populated, $files != 0
{
Write-Host "Missing files found. Sending txt file to FIS."
Send-ToEmail  -email "personReceivingEmail@idk.com" -attachmentpath $RESULTS;

} 

else
{
Write-Host "No missing files found. Move on to next script."
}



 





                                                                                                    
                                                                                                    
