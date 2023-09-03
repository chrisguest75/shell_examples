# Status for a realtime
GET {{ base_api }}/transcripts/realtime/{{trintid}}
Accept: application/json
Content-Type: application/json
api-key: {{ apikey }}

HTTP 200
[Asserts]
header "Content-Type" == "application/json"
jsonpath "$.status" exists
jsonpath "$.started" exists
jsonpath "$.expires" exists
jsonpath "$.status" == "TRANSCRIBING"



