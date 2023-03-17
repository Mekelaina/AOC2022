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


#!TODO -- finish implementation
proc findMatchInContainers(first: openArray[Item], second: openArray[Item]): Res =
    for item in Item:
        if second.contains(item) and second.contains(item):
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


#hacky but promt assures all lines are even length
for line in lines "test.txt":
    var 
        half   = int(len(line)/2)
        first  = line.substr(low(line), half)
        second = line.substr(half, high(line))
    var 
        f = parseContainer(first)
        s = parseContainer(second)
    #echo $f & $s

    echo findMatchInContainers(f, s)






        


    