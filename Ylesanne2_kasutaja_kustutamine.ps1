#küsime kasutaja ees- ja perenime
$eesnimi = read-host "Sisestage kasutaja eesnimi: "
$eesnimi = $eesnimi
$perenimi = read-host "Sisestage kasutaja perenimi: "
$perenimi = $perenimi
#annan kasutajale parooliks Parool1! securestringina
Remove-LocalUser -Name "$eesnimi $perenimi"
#eemaldan errori teatised, kui kasutajat ei eksisteeri
if($?)
{   
echo "Kasutaja on edukalt kustutatud."

}
else
{
$ErrorActionPreference = 'SilentlyContinue'
echo "Kasutaja ei eksisteeri või kustutamisel tekkis muu viga, proovige uuesti."
}