# README

Example textual diffing tools.  

REF: Binary Diffing Examples [here](../68_difftools/README.md)  

## VSCode

```sh
code --diff file1.txt file1_changed.txt
```

## Beyond Compare

Beyond Compare also allows directory comparisons.  

```sh
bcompare file1.txt file1_changed.txt
```

## Meld

Meld is a tool for comparing files and directories, and for resolving differences between them.  

```sh
meld ./12_threejs ./13_sales_dashboard/
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
* MeldMerge [here](https://meldmerge.org/)
