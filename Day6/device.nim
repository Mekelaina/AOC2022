import sequtils



proc checkForStart(s: string): bool = 
    result = true
    for c in s:
        var count = s.count(c)
        #echo s
        if count > 1:
            result = false
            break
        
        
   #[ let 
    test1 = readFile("test1.txt")
    test2 = readFile("test2.txt")
    test3 = readFile("test3.txt")
    test4 = readFile("test4.txt")
    test5 = readFile("test5.txt")
    test1Answer = 7
    test2Answer = 5
    test3Answer = 6
    test4Answer = 10
    test5Answer = 11 ]#

let input = readFile("input.txt")


for i in input.low..input.high-3:
    if checkForStart(input[i..i+3]):
        echo i+4
        break

