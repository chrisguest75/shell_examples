# README

Example textual diffing tools.  

REF: Binary Diffing Examples [here](../68_difftools/README.md)  

## VSCode

```sh
code --diff file1.txt file1_changed.txt
```

## Beyond Compare

```sh
bcompare file1.txt file1_changed.txt
```

## diff

```sh
# changed (detects diff)
diff file1.txt file1_changed.txt

# extended test (detects diff)
diff file1.txt file1_extended.txt

# truncated test (detects diff)
diff file1.txt file1_truncated.txt
```

## Resources

* Beyond Compare Command Line Reference [here](https://www.scootersoftware.com/v4help/index.html?command_line_reference.html)
