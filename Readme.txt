*** Make sure that you're running PowerShell with Administrative rights ***

Run:
Get-ExecutionPolicy

If it returns "Restricted" run:
Set-ExecutionPolicy AllSigned

Alternatively, you can run:
Set-ExecutionPolicy Bypass -Scope Process