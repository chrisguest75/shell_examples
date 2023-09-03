# Start a realtime
PUT {{ base_api }}/transcripts/realtime
Accept: application/json
Content-Type: application/json
api-key: {{ apikey }}
{
  "language": "en",
  "streamUrl": "https://nhkwlive-xjp.akamaized.net/hls/live/2003458/nhkwlive-xjp-en/index_1M.m3u8",
  "transcriptDelay":"5",
  "title": "hurl test"
}

HTTP 200
[Captures]
trintid: jsonpath "$._id"

[Asserts]
header "Content-Type" == "application/json"
jsonpath "$._id" exists



