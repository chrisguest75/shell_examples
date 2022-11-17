# README

My personal cheatsheet for simple examples  

NOTE: Each script should be checked in `bash`, `zsh` and `sh`  

## Man pages

```sh
export MANPAGER=cat
man git
```

## Loops

### For Loops

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

### While Loops

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

## Loop over data structures

NOTE: When using readline loops you might need to pipe in `< /dev/null` to ensure the input characters from the list are not used as input. This happens with `ffmpeg`.  

```sh
# heredoc tempfile
TEMPFILE=$(mktemp)
cat <<- EOF > ${TEMPFILE}
4922049292,us-east-1,filename1.txt
3420302882,eu-west-1,filename2.txt
1334423422,ap-north-1,filename3.txt
EOF
while IFS=, read -r value1 value2 value3
do
    echo "$value1 $value2 $value3"
done < $TEMPFILE
```

```sh
# heredoc pipe
while IFS=, read -r value1 value2 value3
do
    echo "$value1 $value2 $value3"
done << EOF
4922049292,us-east-1,filename1.txt
3420302882,eu-west-1,filename2.txt
1334423422,ap-north-1,filename3.txt
EOF
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

## Compound Conditions

```sh
TEST1=true
TEST2=true

if [ $TEST1 == true ] && [ $TEST2 == true ]; then
  echo "Condition is true"
else
  echo "Condition is false"
fi
```

## Resources

