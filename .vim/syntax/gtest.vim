" Vim syntax file for GTest output
" Tony Allen

" :help color to see type -> color mappings

" Log line format: [IWEF]mmdd hh:mm:ss.uuuuuu threadid file:line] msg
syntax match Failure     /^\[  FAILED  \].\+$/
syntax match FailureInfo     /^[  FAILED  ].\+$/
syntax match FileFailure     /.\+:\d\+: Failure$/

hi def link Failure         Exception
hi def link FailureInfo     String
hi def link FileFailure     Conditional

let b:current_syntax = "gtest"
