# CHEATSHEET

## Examples

### POSTing JSON

```sh
# post a json file
curl -H 'Content-Type: application/json' -X POST http://localhost:3000/dev/hello -d @./src/functions/hello/mock.json
```

### Forcing Protocols

```sh
curl --proto '=https' --tlsv1.3 https://www.google.com
curl --proto '=http' --tlsv1.3 https://www.google.com
curl --proto '=http' --tlsv1.3 http://www.google.com
```

## Resources
