setl wrap                        " softwrap the text
setl linebreak                   " don't break in the middle of the word
setl nolist                      " list disables linebreak
setl textwidth=72
setl formatprg=par\ -B+.,\\-\\!\\?\\\"\\\'\\*\\<\ -w72qie
setl enc=utf-8
setl nojs
setl nosmartindent
setl spell

setl comments=n:>
setl formatoptions=
setl fo+=r " Insert the current comment leader after hitting <Enter> in Insert mode.
setl fo+=o " Insert the current comment leader after hitting 'o' or 'O' in Normal mode.
setl fo+=q " Allow formatting of comments with "gq".
setl fo+=w " Trailing white space indicates a paragraph continues in the next line.
setl fo+=b " Like 'v', but only auto-wrap if you enter a blank at or before the wrap margin.
setl fo+=j " Where it makes sense, remove a comment leader when joining lines.

match ErrorMsg '\s\s\+$'

syn match quote0 "^>"
syn match quote1 "^> *>"
syn match quote2 "^> *> *>"
syn match quote3 "^> *> *> *>"
syn match quote4 "^> *> *> *> *>"
syn match quote5 "^> *> *> *> *> *>"
syn match quote6 "^> *> *> *> *> *> *>"
syn match quote7 "^> *> *> *> *> *> *> *>"

hi quote0 ctermfg=magenta
hi quote1 ctermfg=cyan
hi quote2 ctermfg=blue
hi quote3 ctermfg=yellow
hi quote4 ctermfg=magenta
hi quote5 ctermfg=cyan
hi quote6 ctermfg=blue
hi quote7 ctermfg=yellow
