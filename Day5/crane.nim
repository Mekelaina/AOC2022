import strutils
import sequtils

type Op = tuple[source, dest, count: int]

proc slurpStack(f: openArray[string]): seq[string] =
    var 
        stack: seq[string]
        i = f.low
    while f[i] != "":
        stack.add(f[i])
        inc i
    result = stack

proc slurpInstructions(f: openArray[string]): seq[string] =
    var
        instr: seq[string]
        i = f.low
    while i <= f.high:
        if f[i] == "":
            break
        inc i

    inc i    
    while i <= f.high:
        instr.add(f[i])
        inc i

    result = instr
                
proc parseInstructions(instr: openArray[string]): seq[Op] = 
    var ops: seq[Op]
    for i in instr:
        var op: Op
        let tokens = i.splitWhitespace
        for ix, v in tokens:
            if v == "move":
                op.count = parseInt(tokens[ix+1])                
            elif v == "from":
                op.source = parseInt(tokens[ix+1])
            elif v == "to":
                op.dest = parseInt(tokens[ix+1])
            else:
                continue
        ops.add(op)
    result = ops

proc executeOp(source: var seq[string], dest: var seq[string], count: int) =
    for i in 0..count-1:
        dest.add(source.pop)

proc executeOperations(crane: var seq[seq[string]], ops: openArray[Op]) = 
    for op in ops:
        #echo "huh"
        executeOp(crane[op.source-1], crane[op.dest-1], op.count)    



let file = readFile("input.txt").splitLines

var data = slurpStack(file)
var size = parseInt(data[^1].splitWhitespace[^1])
var crane = newSeqWith(size, newseq[string](0))

var i = data.high-1
while i >= data.low:
    var x = data[i].splitWhitespace
    for j in x.low..x.high:
        if x[j] != "[#]":
            crane[j].add(x[j])
    dec i

var ops = parseInstructions(slurpInstructions(file))

executeOperations(crane, ops)

var res: string

for x in crane:
    var val = x[^1]
    val.removePrefix('[')
    val.removeSuffix(']')
    res.add(val)

echo res

