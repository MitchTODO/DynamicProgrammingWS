import std/[ algorithm, bitops, math, random, sequtils, sets, setutils, strformat, strscans, strtabs, strutils, times, tables ]

type
    MemoKey = tuple[x, v: uint]
    MemoType = Table[MemoKey, uint]
    MemoPath = seq[MemoKey]

var world = @[0,0,1,0,0,1,0,1,0,1,1,0,0,0,0].mapIt(it.bool)

var memo: MemoType

template `+`(s1, s2: string): string = s1 & s2

proc nb(x, v: uint, memo: var MemoType, path: MemoPath = @[]): uint =
    let key: MemoKey = (x, v)
    var newPath = path
    newPath.add key
    if key in memo:
        return memo[key]

    if x > uint high world:
        return (high uint) - 1 # eaten by sarlacc
    if world[x]:
        return (high uint) - 1 # crashed
    if v <= 1:
        echo "path: ", $newPath
        return 0 # landed safely
    result = 1 + min(nb(x + v - 1, v - 1, memo, newPath), min(nb(x + v, v, memo, newPath), nb(x + v + 1, v + 1, memo, newPath)))
    memo[key] = result

echo &"Landed in {nb(0, 3, memo)} bounces."
