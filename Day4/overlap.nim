import strutils
import std/sequtils

type Section = tuple[x1, x2, y1, y2, dx, dy: int]


proc parseSections(a: string, b: string): Section = 
    var section: Section
    
    section.x1 = parseInt(a.split('-',1)[0])
    section.x2 = parseInt(a.split('-',1)[1])
    section.y1 = parseInt(b.split('-',1)[0])
    section.y2 = parseInt(b.split('-',1)[1])
    section.dx = section.x2 - section.x1
    section.dy = section.y2 - section.y1
         
    result = section

proc checkIfOverlaping(section: Section): bool =
    var 
        x: seq[int] = toSeq(section.x1..section.x2)
        y: seq[int] = toSeq(section.y1..section.y2)
    if len(x) >= len(y):
        result = any(y, proc(i: int): bool = i in x)
    else:
        result = any(x, proc(i: int): bool = i in y)

proc checkIfContains(section: Section): bool = 
    var 
        x: seq[int] = toSeq(section.x1..section.x2)
        y: seq[int] = toSeq(section.y1..section.y2)
    if len(x) >= len(y):
        result = all(y, proc(i: int): bool = i in x)
    else:
        result = all(x, proc(i: int): bool = i in y)
    

let file = readFile("input.txt").splitLines

var 
    countOverlap: int
    countContains: int

for line in file:
    let 
        currentLine = line.split(',', 1)
        sections = parseSections(currentLine[0], currentLine[1])
    if checkIfOverlaping(sections):
        inc countOverlap
    if checkIfContains(sections):
        inc countContains

echo countContains
echo countOverlap