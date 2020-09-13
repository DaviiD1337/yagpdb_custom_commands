{{/* Setari */}}
{{ $c := 707675928414650430 }} {{/* Aici iti pui canalul unde se joaca */}}
{{/* Setari terminate */}}
{{ $u := 0 }}{{ $u2 := 0 }}{{ $check2 := 0 }}
{{$prefix := index (reFindAllSubmatches `Prefix of \x60\d+\x60: \x60(.+)\x60` (exec "prefix" )) 0 1}}
{{ if eq .Channel.ID $c }}
    {{ with .Message.Mentions }}
        {{ $u = index . 0 | userArg }}
    {{ end }}
    {{ if $u }}
        {{ $db := (dbGet (add $u.ID .User.ID) "barbut").Value }}
        {{ if $db }}
            {{ $db = sdict $db }}
            {{ $u2 = $db.user | toInt }}
            {{ if ne $u2 .User.ID }}
                Ai respins cererea de barbut al lui {{ $u.Mention }}
                {{ dbDel (add $u.ID .User.ID) "barbut" }}
            {{ else }}
                Nu ai o cerere de barbut de la acest utilizator!
            {{ end }}
        {{ else }}
            Nu ai o cerere de barbut de la acest utilizator!
        {{ end }}
    {{ else }}
        Sintaxa: {{ $prefix }}rbarbut <User:Mention>
    {{ end }}
{{ else }}
    Poți folosi comanda doar în <#{{$c}}>
{{ end }}
