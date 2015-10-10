#définition du tableau de valeurs et de son pointeur
var memory: array[30000, int8]
var pointer: int16 = 0

proc startWhile(code: string, index: int) =
  if memory[pointer] != 0:
    var discover = 1
    while discover != 0:
      case code[index]
        of '[': discover+=1
        of ']': discover-=1
        else: discard
      #inc(index)

proc endWhile(code: string, index: int) =
  echo("end: ", $index) #todo

proc interpret*(code: string) =
  var index: int = 1
  while index<(code.len-1):
    case code[index]:
      of '>': pointer+=1
      of '<': pointer-=1
      of '+': memory[pointer]+=1
      of '-': memory[pointer]-=1
      of '[': startWhile(code, index)
      of ']': endWhile(code, index)
      of '.': write(stdout, char(memory[pointer]))
      else: discard
    inc(index)
