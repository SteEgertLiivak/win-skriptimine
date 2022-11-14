#küsime kasutaja ees- ja perenime ja teeme need lowercase (olenemata, mis sisestatakse)
$eesnimi = read-host "Sisestage oma eesnimi (ainult ladinatähtedega)"
$eesnimi = $eesnimi.ToLower()
$perenimi = read-host "Sisestage oma perenimi (ainult ladinatähtedega)"
$perenimi = $perenimi.ToLower()
#annan kasutajale parooliks Parool1! securestringina
$password = ConvertTo-SecureString "Parool1!" -AsPlainText -force
new-localuser "$eesnimi.$perenimi" -Password $password -fullname "$eesnimi.$perenimi" -Description "Lokaalne kasutaja"
#eemaldan errori teatised, kui samanimeline user on juba olemas
if($?)
{   
echo "Kasutaja loomine õnnestus!"

}
else
{
$ErrorActionPreference = 'SilentlyContinue'
echo "Kasutaja loomisel tekkinud viga"
}