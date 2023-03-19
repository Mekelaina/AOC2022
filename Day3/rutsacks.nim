import strutils, std/tables
import results

type
    Item = enum
        a = 1, b, c, d, e, f, g, h, i, j, k, l, 
        m, n, o, p, q, r, s, t, u, v, w, x, y, z 
        A, B, C, D, E, F, G, H, I, J, K, L, M, N, 
        O, P, Q, R, S, T, U, V, W, X, Y, Z
    Res = Result[Item, string]

let itemSet = {
    'a': a,'b': b,'c': c,'d': d,'e': e,'f': f,'g': g,'h': h,'i': i,'j': j,'k': k,'l': l,'m': m,'n': n,'o': o,'p': p,'q': q,'r': r,'s': s,'t': t,'u': u,'v': v,'w': w,'x': x,'y': y,'z': z,
    'A': A,'B': B,'C': C,'D': D,'E': E,'F': F,'G': G,'H': H,'I': I,'J': J,'K': K,'L': L,'M': M,'N': N,'O': O,'P': P,'Q': Q,'R': R,'S': S,'T': T,'U': U,'V': V,'W': W,'X': X,'Y': Y,'Z': Z,
}.toTable

proc charToItem(inChar: char): Res =          
    if inChar in 'a'..'z' or inChar in 'A'..'Z':
        return Res.ok itemSet.getOrDefault(inChar)
    else:
        result.err "Invalid Character"            

proc splitInHalf(s: string): (string, string) =
    var 
        first: string
        second: string
    if len(s) mod 2 == 0:
        first  = s[0..<len(s) div 2]
        second = s[len(s) div 2..^1]
    else:
        first  = s[0..<len(s) div 2]
        second = s[(len(s) div 2)+1..^1]  
    result = (first, second)

proc findMatchInThreeContainers(first: openArray[Item], second: openArray[Item], 
    third: openArray[Item]): Res =
    for item in Item:
        if first.contains(item) and second.contains(item) and third.contains(item):
            return ok(item)
    result.err "Bad Input"

proc findMatchInTwoContainers(first: openArray[Item], second: openArray[Item]): Res =
    for item in Item:
        if first.contains(item) and second.contains(item):
            return ok(item)
        result.err "Bad Input"

proc parseContainer(s: string): seq[Item] =
    var 
        hold: seq[Item]
        res: Res
    for c in s:
        res = charToItem(c)
        if res.isErr:
            echo res.error
            break
        else:
            hold.add(res.get)
    return hold

var 
    oneLineSum: int
    threeLineSum: int
    match1, match2: Res
    
let file = readFile("input.txt").splitLines

for count, line in file:
    let (f, s) = splitInHalf(line) 
    match1 = findMatchInTwoContainers(parseContainer(f), parseContainer(s))
    if match1.isOk:
        oneLineSum += ord(match1.get())
    else:
        echo match1.error
        break

    if (count + 1) mod 3 == 0:
        match2 = findMatchInThreeContainers(parseContainer(line), 
        parseContainer(file[count-1]), parseContainer(file[count-2]))
        if match2.isOk:
            threeLineSum += ord(match2.get())
        else:
            echo match2.error
            break

echo oneLineSum
echo threeLineSum

    








        


    