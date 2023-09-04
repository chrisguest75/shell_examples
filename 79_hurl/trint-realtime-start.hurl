# Start a realtime
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
jsonpath "$._id" exists



