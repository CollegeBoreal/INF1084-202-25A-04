
$CsvPath = Join-Path -Path $PSScriptRoot -ChildPath "UsersSimules.csv"

$ImportedUsers = Import-Csv -Path $CsvPath

$Groups = @{}
$Groups["ImportGroupe"] = @()

foreach ($user in $ImportedUsers) {
    $Groups["ImportGroupe"] += $user
}

$Groups["ImportGroupe"]
