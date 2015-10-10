#Récupération de la fonction getchhar du langage C
proc getchar*(): int {.importc: "getchar", header: "stdio.h", cdecl, discardable.}

#définition du tableau de valeurs et de son pointeur
var memory: array[30000, int]
var pointer: int = 0

proc startWhile(code: string, index: var int) =
  if memory[pointer] == 0:
    var discover = 1
    while discover != 0 and index < code.len:
      inc(index)
      case code[index]
        of '[': discover+=1
        of ']': discover-=1
        else: discard

proc endWhile(code: string, index: var int) =
  if memory[pointer] != 0:
    var discover = 1
    while discover != 0 and index > 0:
      dec(index)
      case code[index]
        of '[': discover-=1
        of ']': discover+=1
        else: discard

proc incPointer() =
  if pointer < 30000:
    pointer+=1

proc decPointer() =
  if pointer > 0:
    pointer-=1

proc incValue() =
  if memory[pointer] < 255:
    memory[pointer]+=1

proc decValue() =
  if memory[pointer] > 0:
    memory[pointer]-=1

proc writeValue() =
  write(stdout, char(memory[pointer]))

proc readValue() =
  memory[pointer] = getchar()

proc interpret*(code: string) =
  var index: int = 0
  while index<(code.len-1):
    case code[index]:
      of '>': incPointer()
      of '<': decPointer()
      of '+': incValue()
      of '-': decValue()
      of '[': startWhile(code, index)
      of ']': endWhile(code, index)
      of '.': writeValue()
      of ',': readValue()
      else: discard
    inc(index)
