# PATH HANDLING

Demonstrates ways of manipulating paths  

## Demonstrates

Demonstrates techniques for discovering paths  

```sh
# if not passed anything it will use $0 as the path
./paths_testing.sh

# test a given path
./paths_testing.sh --test=./paths_testing.sh

# home
./paths_testing.sh --test=$(echo ~)

# longer path
./paths_testing.sh --test=$(pwd)/../../sources/audiobooks/christmas_short_works_2008_0812_64kb_mp3/french_lapaysanne_arene_di_64kb.mp3
```

Now copy the value of SCRIPT_FULL_PATH from output into paste buffer.
This will run the script from the root folder.  

```sh
cd /
$(pbpaste)
popd
```

## Resources

* Bash Parameter Expansion [here](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)  

