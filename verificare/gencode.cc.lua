{{/* Asta vine in Notification & Feeds -> General -> Join message in direct message */}}
{{/* SETARI */}}
{{ $c := 700798456947802112 }}{{/* ID-ul canalului unde oamenii pot pune codul sa se verifice */}}
{{/* SETARI FINALIZATE */}}

{{ $cod := randInt 1000 9999 }}
{{ $setcod := dbSet .User.ID "COD" $cod }
{{ sendMessage nil (cembed
"title" "VERIFICARE"
"description" (joinStr "" "Pentru a te verifica tasteaza `" $cod "` pe <#" $c "> !")
"thumbnail" (sdict "url" "https://cdn.discordapp.com/attachments/695780710752976998/700800233373958306/web-programming.png")
"color" (randInt 111111 999999)) }}
