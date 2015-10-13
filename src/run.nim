when isMainModule:
  import brainfack.interpreter, docopt, os, strutils

  const help = """
Usage:
  brainfack <file> [--speed=<millis>]
  brainfack (-h | --help)
  brainfack --version

Options:
  -h --help         Show this screen.
  --version         Show version.
  --speed=<millis>  Speed in millis [default: 1000].
"""

  let args = docopt(help, version="brainfack 0.1")
  if args["<file>"]:
    if fileExists($args["<file>"]):
      if args["--speed"]:
        interpret(readFile($args["<file>"]), parseInt($args["--speed"]))
      else:
        interpret(readFile($args["<file>"]), 1000)
    else:
      echo "file does not exists"
  else:
    echo "error"
