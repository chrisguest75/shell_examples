# README

My personal cheatsheet for simple examples

## Loops

```sh
# for looping 
for index in $(seq 0 10 ); 
do
  # break from a for loop
  if [[ $index == 5 ]] break

  # continue the loop
  if [[ $index == 1 ]] continue

  echo "Sleep $index"
  sleep 1

done
# index exists outside of loop
echo "Exited loop $index"
```

## Resources

