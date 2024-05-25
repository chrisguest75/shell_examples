# Get google
GET http://www.google.com
Accept: application/json
Content-Type: application/json

[Options]
delay: 3000
output: ./out/google.html

HTTP 200
[Asserts]
header "Content-Type" == "text/html; charset=ISO-8859-1"



