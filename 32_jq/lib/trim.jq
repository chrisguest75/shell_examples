def trim($value): $value | match("([ ]*)(.*)").captures[1].string | match("([^ ]*)([ ]*)").captures[0].string;
