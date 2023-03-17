import strutils

type
    RoundResult = enum
        roundLoss = 0, roundDraw = 3, roundWin = 6 
    Move = enum
        mRock = 1, mPaper = 2, mScissors = 3
    Round = object
        opponentMove: Move
        yourMove: Move
        parsedCorrect: bool

proc parseRound(s: openArray[string]): Round =
    var
        opMove = s[0]
        uMove  = s[1]
        r: Round
    case opMove:
        of "A":
            r.opponentMove = mRock
        of "B":
            r.opponentMove = mPaper
        of "C":
            r.opponentMove = mScissors
        else:
            errorMessageWriter("ERROR: Unrecognized Character" & opMove)
            r.parsedCorrect = false
    
    case uMove:
        of "X":
            r.yourMove = mRock
        of "Y":
            r.yourMove = mPaper
        of "Z":
            r.yourMove = mScissors
        else:
            errorMessageWriter("ERROR: Unrecognized Character" & uMove)
            r.parsedCorrect = false
    
    r.parsedCorrect = true
    result = r
            
proc evaluateRound(r: Round): RoundResult =
    case r.opponentMove:
        of mRock:
            case r.yourMove:
                of mRock:
                    result = roundDraw
                of mPaper:
                    result = roundWin
                of mScissors:
                    result = roundLoss
        of mPaper:
            case r.yourMove:
                of mRock:
                    result = roundLoss
                of mPaper:
                    result = roundDraw
                of mScissors:
                    result = roundWin
        of mScissors:
            case r.yourMove:
                of mRock:
                    result = roundWin
                of mPaper:
                    result = roundLoss
                of mScissors:
                    result = roundDraw

proc calcScore(round: Round): int =
    result = ord(round.yourMove) + ord(evaluateRound(round))


#Main Code

const inputFile: string = "input.txt"

let fileIn = readFile(inputFile)

let contents = splitLines(fileIn)

var
    moves: seq[string]
    totalScore: int

for line in contents:
    moves  = split(line, ' ')
    var round = parseRound(moves)

    if round.parsedCorrect:
        totalScore += calcScore(round)
    else:
        break    


echo totalScore

