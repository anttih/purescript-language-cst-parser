module BenchFile where

import Prelude

import Data.Foldable (for_)
import Effect (Effect)
import Effect.Class.Console as Console
import Performance.Minibench (benchWith)
import PureScript.CST (RecoveredParserResult(..), parseModule)
import PureScript.CST.Errors (printParseError)
import PureScript.CST.Parser.Monad (PositionedError)

foreign import readFile :: Effect String

main :: Effect Unit
main = do
  -- contents <- readFile fileName
  contents <- readFile
  -- Console.log $ "Benchmarking " <> fileName
  Console.log $ "Test "
  case parseModule contents of
    ParseSucceeded _ -> Console.log "Parsing worked"
    ParseSucceededWithErrors _ errs -> do
      Console.log "Parse succeeded with errors."
      for_ errs $ Console.error <<< printPositionedError
    ParseFailed err -> do
      Console.log "Parse failed."
      Console.error $ printPositionedError err
  Console.log $ "Benchmarking "
  benchWith 10 \_ -> parseModule contents

printPositionedError :: PositionedError -> String
printPositionedError { error, position } =
  "[" <> show (position.line + 1) <> ":" <> show (position.column + 1) <> "] " <> printParseError error
