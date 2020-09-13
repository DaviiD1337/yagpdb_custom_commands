{{/* Setari */}}
{{ $c := 707675928414650430 }} {{/* Aici iti pui canalul unde se joaca */}}
{{/* Setari terminate */}}
{{ $u := 0 }}{{ $sdict := sdict }}{{ $u2 := 0 }}{{ $suma := 0 }}{{ $db := 0 }}{{ $roll1 := randInt 1 7 }}{{ $roll2 := randInt 1 7 }}{{ $msg := "" }}{{ $win := 0 }}
{{ if eq .Channel.ID $c }}
    {{ with .Message.Mentions }}
        {{ $u = index . 0 | userArg }}
    {{ end }}
    {{ if $u }}
        {{ $db = (dbGet (add $u.ID .User.ID) "barbut").Value }}
        {{ if $db }}
            {{ $db = sdict $db }}
            {{ $u2 := $db.user | toInt }}
            {{ $suma := $db.value | toInt }}
            {{ if ne $u2 .User.ID }}
                {{ $msg = (print " " .User.Mention " a rulat " $roll1 "\n " $u.Mention " a rulat " $roll2 "") }}
                {{ if gt $roll1 $roll2 }}
                    {{ $win = mult $suma 2 }}
                    {{ $s := dbIncr $u.ID "CREDITS" (mult $suma -1) }}
                    {{ $s := dbIncr .User.ID "CREDITS" $suma }}
                    {{ $msg = print $msg "\n\n " .User.Mention " a câștigat " $win  " credite împotriva lui " $u.Mention "."}}
                {{ else if eq $roll1 $roll2 }}
                    {{ $msg = print $msg "\n Egal!" }}
                {{ else }}
                    {{ $win = mult $suma 2 }}
                    {{ $s := dbIncr .User.ID "CREDITS" (mult $suma -1) }}
                    {{ $s := dbIncr $u.ID "CREDITS" $suma }}
                    {{ $msg = print $msg "\n\n " $u.Mention " a câștigat " $win " credite împotriva lui " .User.Mention "."}}
                {{ end }}
               {{ sendMessage nil $msg }}
              {{ dbDel (add $u.ID .User.ID) "barbut" }}
            {{ else }}
                Nu ai o cerere de barbut de la acest utilizator!
                {{ deleteResponse }}
                {{ deleteTrigger }}
            {{ end }}
        {{ else }}
        Nu ai o cerere de barbut de la acest utilizator!
            {{ deleteResponse }}
            {{ deleteTrigger }}
        {{ end }}
    {{ else }}
        Sintaxa: {{ $prefix}}abarbut <User:Mention>
        {{ deleteResponse }}
        {{ deleteTrigger }}
    {{ end }}
{{ else }}
    Poți folosi comanda doar în <#{{$c}}>
        {{ deleteResponse }}
        {{ deleteTrigger }}
{{ end }}
```
