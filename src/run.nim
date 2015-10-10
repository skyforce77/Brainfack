when isMainModule:
  import brainfack.interpreter, docopt, os, times

  const help = """
Usage:
  brainfack <file>
"""

  let args = docopt(help, version="brainfack 0.1")
  if args["<file>"]:
    if fileExists($args["<file>"]):
      interpret(readFile($args["<file>"]))
      echo cpuTime()
    else:
      echo "file does not exists"
  else:
    echo "error"
