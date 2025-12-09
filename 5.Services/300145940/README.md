# README – PowerShell AD Services Scripts
Author: Tasnim Marzougui  
Course: INF1084 – Services & Logs

## services1.ps1
Lists Active Directory–related services (NTDS, ADWS, DFSR, Netlogon, KDC, IsmServ).  
Used to verify which AD services are running and their startup mode.
<img width="959" height="539" alt="1" src="https://github.com/user-attachments/assets/69d0d540-6bb9-40ac-881b-e3270062eca1" />

## services2.ps1
Shows recent Directory Service events and filters System logs for Netlogon.  
Also uses Get-WinEvent to display modern event log entries.
<img width="959" height="539" alt="2" src="https://github.com/user-attachments/assets/216e2eac-bde7-47cd-9a26-f2ef50b9b784" />

## services3.ps1
Checks if C:\Logs exists, creates it if needed, then exports the last 50 Application events into C:\Logs\ADLogs.csv.
<img width="959" height="539" alt="3" src="https://github.com/user-attachments/assets/315d2b63-d440-42a6-bdf5-0d36b3aeeea3" />

## services4.ps1
Stops the DFSR service, displays its status, then starts it again.  
Useful for testing and restarting replication services.

<img width="946" height="539" alt="4" src="https://github.com/user-attachments/assets/2f37b3a2-d071-4703-a513-fb5ca842d347" />


