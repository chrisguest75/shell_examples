##############################################################
## Upload a batch asset
##############################################################
POST {{ base_upload_api }}
Content-Type: video/mp4
api-key: {{ apikey }}
[QueryStringParams]
filename: {{ title }}
language: {{ language }}
[MultipartFormData]
file,english_windinthewillows_grahame_rll_16khz_64kb_30sec_trim.m4a;
#file, {{ sourceFile }};

HTTP 200
[Captures]
trintid: jsonpath "$.trintId"
[Asserts]
header "Content-Type" == "application/json; charset=utf-8"

