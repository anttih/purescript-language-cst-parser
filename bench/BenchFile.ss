(library (BenchFile foreign)
  (export readFile)
  (import (chezscheme)
          (only (purs runtime pstring) string->pstring))

  (define readFile
    (lambda ()
      (with-input-from-file "./src/PureScript/CST/Parser.purs"
        (lambda ()
          (let loop ((chars '())
                     (next-char (read-char)))
             (if (eof-object? next-char)
                 (string->pstring (list->string (reverse chars)))
                 (loop (cons next-char chars)
                       (read-char))))))))

  )
