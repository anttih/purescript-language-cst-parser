(library (PureScript.CST.Lexer foreign)
  (export regexMatchUncons)
  (import (chezscheme)
          (only (purs runtime pstring) pstring-regex-match-uncons))

  (define regexMatchUncons pstring-regex-match-uncons)
  )

