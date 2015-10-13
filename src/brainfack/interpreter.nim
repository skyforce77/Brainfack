#Importation du module time
import os, times

#Récupération des fonctions getchar et printf du langage C
proc getchar*(): int {.importc: "getchar", header: "stdio.h", cdecl, discardable.}
proc printf(formatstr: cstring) {.importc: "printf", varargs, header: "<stdio.h>".}

#Définition de la pile de boucles
var loopSeq = newSeq[int]()

#Définition du tableau de valeurs et de son pointeur
var memory: array[30000, int]
var pointer: int = 0
var print = ""

proc startWhile(code: string, index: var int) =
  if memory[pointer] == 0:
    var discover = 1
    while discover != 0 and index < code.len:
      inc(index)
      case code[index]
        of '[': discover+=1
        of ']': discover-=1
        else: discard
  else:
    loopSeq.add(index)

proc endWhile(code: string, index: var int) =
  if memory[pointer] != 0:
    index = loopSeq.pop()-1
  else:
    discard loopSeq.pop()

proc incPointer() =
  if pointer < memory.len-1:
    pointer+=1

proc decPointer() =
  if pointer > 0:
    pointer-=1

proc incValue() =
  if memory[pointer] < 255:
    memory[pointer]+=1

proc printInfos(inst: char) =
  #cursor definition
  var
    startIndex: int = 0
    endIndex: int = 10

  if pointer >= 5 and pointer <= memory.len-1-5:
    startIndex = pointer-5
    endIndex = pointer+5
  else:
    if pointer > memory.len-1-5:
      startIndex = memory.len-1-10

  #clear terminal
  printf("\e[1;1H\e[2J");
  printf("Stack trace:\n")

  #print memory
  printf("Memory         ")
  var i: int = startIndex
  while i <= endIndex:
    printf("|  %*d  ", 3, memory[i])
    i+=1
  echo "|"

  #print pointer location
  printf("Actual pointer ")
  i = startIndex
  while i <= endIndex:
    if i == pointer:
      printf("|   ^   ", memory[i])
    else:
      printf("|       ", memory[i])
    i+=1
  echo "|"

  #print index
  printf("Case number    ")
  i = startIndex
  while i <= endIndex:
    printf("| %*d ", 5, i)
    i+=1
  echo "|"

  printf("Last instruction: %c\n", inst)
  printf("Print: \n%s\n", print)

proc decValue() =
  if memory[pointer] > 0:
    memory[pointer]-=1

proc writeValue() =
  print = print&char(memory[pointer])

proc readValue() =
  memory[pointer] = getchar()

proc interpret*(code: string, time: int) =
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
    printInfos(code[index])
    sleep(time)
    inc(index)
