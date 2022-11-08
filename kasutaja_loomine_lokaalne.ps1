#määrame kasutajale parool, konverteerides turvatud tekstis
ConvertTo-SecureString "Parool1!" -AsPlainText -force
#loome kasutaja
new-localuser "kasutaja" -Password $kasutajaparool -fullname "esimene tavakasutaja" -Description "Local Account - kasutaja"
