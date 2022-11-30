$file = "C:\Users\Administrator\Documents\win_skriptimine\adkasutajd_paroolita.csv"
$ErrorActionPreference = 'Stop'

(Get-Content $file -Encoding UTF8) | Set-Content $file -Encoding UTF8

Add-Type -AssemblyName System.Web

$users = Import-Csv $file -Encoding Default -Delimiter ";"

$outfile =  "C:\Users\Administrator\Documents\win_skriptimine\kasutajanimi.csv"
$newcsv = {} | Select "Name","Password" | Export-Csv $outfile -Delimiter ";"
$newcsv = Import-Csv $outfile -Delimiter ";"

foreach ($user in $users){

    

    echo $newcsv

    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    $upname =$username + "@sv-kool.local"
    $displayname = $user.Firstname + " " + $user.LastName
    $parool = [System.Web.Security.Membership]::GeneratePassword(8,2)
    New-ADUser -Name $username `
        -Displayname $displayname `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -Department $user.Department `
        -Title $user.Role `
        -UserPrincipalName $upname `
        –AccountPassword (ConvertTo-SecureString $parool -AsPlainText -force) -ChangePasswordAtLogon $true -Enabled $true

    echo $username
    echo $parool

    $newcsv.Name = $username
    $newcsv.Password = $parool
    $newcsv | Export-CSV $outfile –Append -Delimiter ";"
} 





function Translit {
    param(
        [string] $inputString
    )
    $Translit = @{
        [char]'õ' = 'o'
        [char]'ö' = 'o'
        [char]'ä' = 'ä'
        [char]'ü' = 'u'
    }
    $outputString = ""
    foreach ($character in $inputCharacter = $inputString.ToCharArray()){
        if ($Translit[$character] -cne $null) {
            $outputString += $Translit[$character]
        } else {
           $outputString += $character 
        }
    }
    Write-Output $outputString
} 
if($?) `
{   
echo "Kasutaja loomine õnnestus!"

}
else
{
$ErrorActionPreference = 'SilentlyContinue'
echo "Kasutaja loomisel tekkinud viga, antud nimega kasutaja juba eksisteerib"
}
$ErrorActionPreference = 'Stop'