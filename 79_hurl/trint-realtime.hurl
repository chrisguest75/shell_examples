##############################################################
## Start a realtime
##############################################################
PUT {{ base_api }}/transcripts/realtime
Accept: application/json
Content-Type: application/json
api-key: {{ apikey }}
{
  "language": "{{ language }}",
  "streamUrl": "{{ streamUrl }}",
  "transcriptDelay":"5",
  "title": "{{ title }}"
}

HTTP 200
[Captures]
trintid: jsonpath "$._id"
[Asserts]
header "Content-Type" == "application/json"

##############################################################
## Status realtime
##############################################################

# Status for a realtime
GET {{ base_api }}/transcripts/realtime/{{ trintid }}
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

