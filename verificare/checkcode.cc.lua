{{/* Aceasta comanda vine intr-o comanda custom : Core -> Custom Commands 

Trigger type: RegEx cu trigger: .*

*/}}
{{/* SETARI */}}
{{ $c := 700798456947802112 }}{{/* Canalul unde oamenii se pot verifica */}}
{{ $cc := 695780710752976998 }}{{/* Canalul unde va arata ca acel utilizator s-a verificat */}}
{{ $r := 12345 }}{{/* ID-ul rolului de membru */}}
{{/* SETARI FINALIZATE */}}

{{ if eq .Channel.ID $c }}	
	{{ $s := 0 }}{{ $cod := (toInt (dbGet .User.ID "COD").Value) }}
	{{ if $cod }}
		{{ $k := reFindAllSubmatches `\d+` .Message.Content }}
		{{ if $k }}
			{{ with $k }}	
				{{ $s = index (index . 0) 0 }}
			{{ end }}
			{{ if eq (toInt $s) $cod }}
                {{ addRoleID $r }}
                {{ sleep 1 }}
                {{ sendMessageNoEscape $cc (complexMessage "content" .User.Mention "embed" (cembed "author" (sdict "name" .User.String "icon_url" (.User.AvatarURL "256")) "description" (print .User.Mention " s-a verificat si acum este un membru al serverului ! :hugging:") "color" (randInt 111111 999999) "timestamp" currentTime)) }}	
                {{ dbDel .User.ID "COD" }}
            {{ else }}
		        {{ sendDM (print "Cod gresit! Codul tau este: **" $cod "**")}}
			{{ end }}
		{{ end }}
	{{ end }}
{{ deleteTrigger 2 }}
{{ end }}
