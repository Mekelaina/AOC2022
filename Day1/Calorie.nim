import strutils

const inputFile: string = "input.txt"

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
let giantElf = max(elves)

echo giantElf #69206


