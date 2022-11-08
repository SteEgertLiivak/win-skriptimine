param(
$kasutajaNimi,
$taisNimi,
$kontoKirjeldus
)
$KasutajaParool = ConvertTo-SecureString 'Parool1!' -AsPlainText -Force
New-LocalUser $kasutajaNimi -Password $kasutajaParool -FullName $taisNimi -Description $kontoKirjeldus