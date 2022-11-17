# REVERTING

Quick walkthrough of `reverting` different types of commits.  

## Create repo

```sh
mkdir -p ./git_testing && cd ./git_testing
git init
```

### Creating history

```sh
while IFS=, read -r operation value1 value2 value3
do
    case $operation in
        CREATE)
            filename=$value3
            echo "Creating $filename" 
            # add example files to master
            echo "$value1" > "$filename"
        ;;           
        APPEND)
            filename=$value3
            echo "Appending $filename" 
            # add example files to master
            echo "$value1" >> "$filename"        
            echo "$value2" >> "$filename"        
        ;;           
        COMMIT)
            commit=$value1
            echo "Committing $commit" 
            git add .
            git status
            git commit -m "$commit"
            git log --oneline
        ;;           
        *)
            echo "Unrecognised ${i}"
        ;;
    esac

done << EOF
CREATE,first line,"",./filename1.txt
CREATE,first line,"",./filename2.txt
CREATE,new line,"",./filename1.txt
CREATE,third file,"",./filename3.txt
APPEND,third file,"",./filename3.txt
APPEND,third file,"",./filename3.txt
COMMIT,first commit,"",""
CREATE,first line,"",./filename4.txt
COMMIT,second commit,"",""
APPEND,appending lines,"",./filename4.txt
COMMIT,third commit,"",""
APPEND,appending more lines,"",./filename4.txt
COMMIT,fourth commit,"",""
EOF
```

## Reverting changes

```sh
# show the individual commits
git show head~3 --name-only 

# revert second commit
git revert head~3 
```

## Rollback the last commit

Rollback in the current local branch  

```sh
# pop the last commit off and move the changed files into staging
git reset head~1    
```

Rollback on default branch using a MR/PR.  

```sh
# create a new branch
git checkout -b reverting

# revert commit 
git revert head|commitid

# push and create an MR
git push 

# or switch to main and merge the commit in
git switch main
git merge reverting
```

