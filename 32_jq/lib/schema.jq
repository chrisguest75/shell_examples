def schema($path): $path | paths | map(tostring) | join("/");

