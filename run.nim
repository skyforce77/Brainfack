when isMainModule:
  import brainfack.interpreter, docopt, os

  const help = """
Usage:
  brainfack <file>
"""

  let args = docopt(help, version="brainfack 0.1")
  if args["<file>"]:
    if fileExists($args["<file>"]):
      interpret(readFile($args["<file>"]))
    else:
      echo "file does not exists"
  else:
    echo "error"
