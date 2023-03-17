import strutils, sequtils

const inputFile: string = "input.txt"

# --------------------------------------------- #
#               Part 1 Code                     #
# --------------------------------------------- #

#read the inputfile in
let fileIn = readFile(inputFile)

#split the file contents by newline
let contents = splitLines(fileIn)

var elves: seq[int]
var sum: int 

#[look through each string in the 
list, if its not empty add it to the
running sum, if it is, store the sum in
the list of totals and reset the sum]# 
for fruit in contents:
    if fruit != "":
        sum += parseInt(fruit)
    else:
        elves.add(sum)
        sum = 0

#get the largest sum from the list
var giantElf = max(elves)

echo "Largest Single Elf: " & $giantElf


# --------------------------------------------- #
#               Part 2 Code                     #
# --------------------------------------------- #


#[loop through the list thrice
get the index of the largest value,
add the value at that index to the running sum
then delete that value from the list]#

giantElf = 0

for i in 0..2:
    var e = elves.maxIndex()
    giantElf += elves[e]
    elves.del(e)

echo "Total calories for top 3 elves: " & $giantElf 