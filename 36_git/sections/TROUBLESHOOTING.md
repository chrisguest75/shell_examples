# TROUBLESHOOOTING

## Ambiguous argument 'origin/HEAD..HEAD'

Git push gives the following error.  

```sh
fatal: ambiguous argument 'origin/HEAD..HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
```

To fix run:

```sh
git remote set-head origin -a

git push
```

## Resources

* https://stackoverflow.com/questions/8839958/how-does-origin-head-get-set/8841024#8841024