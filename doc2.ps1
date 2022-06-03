$dir1 = “D:\Desktop\Example1” #replace this with the destination of the source file (\\wab-ftepw01\usr\FIS\PDFStmts\*.pdf)
$dir2 = “D:\Desktop\Example2” #where ever the TRG files are located...

#replace this with the *.pdf file extension. 
$outputDirFile1 = get-ChildItem -Path $dir1 -Filter *.txt | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)} 
#replace this with the *.trg file extension
$outputDirFile2 = get-ChildItem -Path $dir2 -Filter *.rtf | ForEach-Object -Process {[System.IO.Path]::GetFileNameWithoutExtension($_)}

#outputs the missing pdf file name (without extension)
Compare-Object $outputDirFile2 $outputDirFile1 #will output the missing file

#if ($files -ne 0)
#{
#write-host "No files woops"
#} 



 





                                                                                                    