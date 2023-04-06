Part 1

1. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes

   - Kill the processes from PowerShell

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
    start-process $arr[$i]
    get-process | select-object $arr[$i]
    stop-process -name $arr[$i]
}

Part 2

2. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes

   - Save the ProcessIDs to a text file called procs.txt

   - Iterate through the ProcessIDs in the text file and kill them
   

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
    start-process $arr[$i]
    get-process | Where-Object -FilterScript {$_.ProcessName -eq $array[$i]} | Select-Object Id | Out-File -FilePath C:\Users\student\Desktop\test.txt -Append
    stop-process -name $arr[$i]
}

Part 3

3. Use an array to iterate and open the following

   - Notepad

   - MS Edge

   - MSpaint

   - Query the processes and display only the following information in order by process ID

   - Process ID

   - Process Name

   - The time the process started

   - The amount of time the process has spent on the processor

   - The amount of memory assigned to the process

$arr = ("notepad", "MSEdge", "MSpaint")
for ($i=0; $i -lt $arr.length; $i++) {
      start-process $arr[$i]
      get-process | Where-Object -FilterScript {$_.ProcessName -eq $array[$i]} | Select-Object Id,ProcessName,StartTime,TotalProcessorTime,PageMemorySize
}

