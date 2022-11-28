$file = "C:\Users\Administrator\Documents\win_skriptimine\adkasutajad.csv"

(Get-Content $file -Encoding UTF8) | Set-Content $file -Encoding UTF8

$users = Import-Csv $file -Encoding Default -Delimiter ";"

foreach ($user in $users){
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    echo $username
    $username = Translit($username)
    echo $username
    $upname =$username + "@sv-kool.local"
    $displayname = $user.Firstname + " " + $user.LastName
    New-ADUser -Name $username `
        -Displayname $displayname `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -Department $user.Department `
        -Title $user.Role `
        -UserPrincipalName $upname `
        -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -force) -enabled $true
} 

function Translit {
    param(
        [string] $inputString
    )
    $Translit = @{
        [char]'õ' = 'o'
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
