{{/* setari (modifica) */}}
{{ $c := 707675928414650430 }} {{/* Canalul unde se joaca */}}
{{ $minbet := 100 }} {{/* Suma pe care se poate juca (minim) Seteaza pe 0 daca nu exista.*/}}
{{/* Setari terminate */}}
{{$prefix := index (reFindAllSubmatches `Prefix of \x60\d+\x60: \x60(.+)\x60` (exec "prefix")) 0 1}}
{{ $suma := 0 }}{{ $u := 0 }}{{ $check1 := 0 }}{{ $check2 := 0 }}
{{ if eq .Channel.ID $c }}
    {{ $args := parseArgs 2 (print "Sintaxa: **" $prefix "barbut <User:Mention> <suma>**" (carg "user" "user") (carg "int" "suma") }}
    {{ $suma := $args.Get 1 }}
    {{ $u := $args.Get 0 | userArg }}
    {{ if ge $suma $minbet }}
        {{ $check1 = (dbGet .User.ID "CREDITS").Value | toInt }}
        {{ $check2 = (dbGet $u.ID "CREDITS").Value | toInt }}
        {{ if gt $suma $check1 }}
            Nu ai **{{ $suma }}** credite.
            {{ deleteResponse }}
            {{ deleteTrigger }}
        {{ else if gt $suma $check2 }}
            **{{ $u.Username }}** nu are **{{ $suma }}** credite.
            {{ deleteResponse }}
            {{ deleteTrigger }}
        {{ else }}
            {{ sendMessage nil (print $u.Mention " ai fost provocat la barbut de către " .User.Mention " pe suma de **" $suma "** credite.\nPentru a accepta tastează **" $prefix "abarbut " .User.Mention "** sau pentru a respinge **" $prefix "rbarbut " .User.Mention "**.") }}
            {{ dbSet (add $u.ID .User.ID) "barbut" (sdict "value" $suma "user" .User.ID) }}
            {{ deleteTrigger }}
        {{ end }}
    {{ else }}
        Poți juca barbut pe minim **{{ $minbet }}** credite.
    {{ end }}
{{ else }}
    Poți folosi comanda doar în <#{{$c}}>
    {{ deleteResponse }}
    {{ deleteTrigger }}
{{ end }}
