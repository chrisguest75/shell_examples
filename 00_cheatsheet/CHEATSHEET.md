# README

My personal cheatsheet for simple examples  

NOTE: Each script should be checked in `bash`, `zsh` and `sh`  

## Loops

A `for` loop with count  

```sh
for index in $(seq 0 10 ); 
do
  # break from a for loop
  if [[ $index == 5 ]]; then break; fi

  # continue the loop
  if [[ $index == 1 ]]; then continue; fi

  echo "Sleep $index"
  sleep 1

done
# index exists outside of loop
echo "Exited loop $index"
```

Iterate over a list in a `for` loop  

```sh
for index in hello world tomorrow is thursday; 
do
  echo "Sleep $index"
  sleep 1
done
# index exists outside of loop
echo "Exited loop $index"
```

A `while` loop

```sh
_continue=true
_count=0
while $_continue; 
do
  _count=$(( _count + 1 ))

  # continue the loop
  if [[ $_count == 2 ]]; then continue; fi

  # break from a while loop (uncomment one or other)
  #if [[ $_count == 5 ]] break
  if [[ $_count == 5 ]]; then break; fi

  echo "$_count"
done
# index exists outside of loop
echo "Exited loop $_count"
```

## Calculations

Calculations can be performed using $(( expression ))  

```sh
for index in $(seq 0 10 ); 
do
  # use modulus
  echo $(( index % 2 * (10 + 1) ))

  # calculations in if blocks
  if [[ $(( index - 5 )) -ge 0 ]]; then
    echo "condition met $(( index - 5 ))"
  else
    echo "condition not met $(( index - 5 ))"
  fi
done
```

## Resources

