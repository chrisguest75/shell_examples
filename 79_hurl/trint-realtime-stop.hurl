# Stop a realtime
DELETE {{ base_api }}/transcripts/realtime
Accept: application/json
Content-Type: application/json
api-key: {{ apikey }}
{
  "trintId": "{{ trintid }}"
}

HTTP 200
[Asserts]
header "Content-Type" == "application/json"
#jsonpath "$[1].mime_type" == "video/mp4"



