# GIT LFS

If you have large, undiffable files in your repo such as binaries, you will keep a full copy of that file in your repo every time you commit a change to the file. If many versions of these files exist in your repo, they will dramatically increase the time to checkout, branch, fetch, and clone your code.

## Background

Git LFS is a system for managing and versioning large files in
association with a Git repository. Instead of storing the large files within the Git repository as blobs, Git LFS stores special "pointer files" in the repository, while storing the actual file contents on a Git LFS server. The contents of the large file are downloaded automatically when needed, for example when a Git branch containing the large file is checked out.  

Git LFS works by using a "smudge" filter to look up the large file
contents based on the pointer file, and a "clean" filter to create a new version of the pointer file when the large file's contents change. It also uses a pre-push hook to upload the large file contents to the Git LFS server whenever a commit containing a new large file version is about to be pushed to the corresponding Git server.  

NOTES:

* It was enabled by default on gitlab.  
* It seems quite seamless and transparent.  
* Gitlab shows a little icon LFS next to the filename.  

TODO:

* Tests; 
  * where are the files stored?
  * switching branches with changes.
* Do they get backed up?
* How do I get versions?
* Where are the cached files stored?

## Prereqs

```sh
brew info git-lfs

brew install git-lfs
```

## Start

```sh
# clone or create a repo.
git clone <repo>

# this has to be done to initiate the hooks.
git lfs install

# track adds .gitattributes. 
git lfs track assets/*.mp4        

# lists files being tracked 
git lfs ls-files 

git add .
git commit -m "testing lfs"

git push 
git lfs env   

git lfs logs last
git lfs status

# get info about a particular file. 
git lfs pointer --file ./assets2/scrolling_24fps_audiomux.mp4
```

## Resources

* Git LFS Tutorial [here](https://github.com/git-lfs/git-lfs/wiki/Tutorial)
* Configure your GitLab server for Git LFS [here](https://docs.gitlab.com/ee/topics/git/lfs/)
* git-lfs/git-lfs [here](https://github.com/git-lfs/git-lfs)
* An open source Git extension for versioning large files [here](https://git-lfs.github.com/)
* GitHub limits the size of files allowed in repositories. To track files beyond this limit, you can use Git Large File Storage.[here](https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-git-large-file-storage)
* Where are git-lfs files stored? [here](https://stackoverflow.com/questions/34181356/where-are-git-lfs-files-stored)
