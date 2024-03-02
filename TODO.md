# 📝 TODO

* code=${PIPESTATUS[0]} -- getting pipestatus codes.
* -- end of options https://www.cyberciti.biz/faq/what-does-double-dash-mean-in-ssh-command  
* fold command - wrap line lengths.
* Process Substition versus command substitution < <() < $()
sdiff <(ffprobe -show_frames test.mp4  | grep pkt_pts_time) <(ffprobe -show_frames original.mp4 | grep pkt_pts_time)
* zsh versus bash
* defensive programming
* debugfs
* ShayMoi https://www.chezmoi.io/
* Add a keywords index for links through to examples.  
* listing state; functions, env, paths, etc  
* running commands from gists.

```sh
## Run with curl from gist
export MAP_FILE=$(pwd)/test.map
ROLE=$(curl -s https://gist.githubusercontent.com/chrisguest75/b6bf4770237e1307b3fef4ffa3d4a187/raw/0f05f1ae43ce0102fe9394b6dead9d502876be0d/get_mapped_value.sh | bash -s account1)
echo $ROLE
```


* stdbuf, stty, tty