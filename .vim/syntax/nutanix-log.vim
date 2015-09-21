" Vim syntax file for Nutanix log files
" Pete wyckoff

" :help color to see type -> color mappings

syntax match logStart /^Log file created at:.*$/
syntax match logStart /^Running on machine:.*$/
syntax match logStart /^Log line format:.*$/
hi def link logStart Todo

" Log line format: [IWEF]mmdd hh:mm:ss.uuuuuu threadid file:line] msg
syntax match logSecs     /\(^[IWEF]\d\{4} \d\{2}:\d\{2}:\)\@<=\d\{2}\.\d\{6} /
syntax match logFileLine /\(^[IWEF]\d\{4} \d\{2}:\d\{2}:\d\{2}\.\d\{6} \+\d\+ \)\@<=[0-9a-zA-Z_.]\+:\d\+] /he=e-2
syntax match logText     /\(^[IWEF]\d\{4} \d\{2}:\d\{2}:\d\{2}\.\d\{6} \+\d\+ [0-9a-zA-Z_.]\+:\d\+] \)\@<=.*/
hi def link logSecs     Constant
hi def link logFileLine Statement
hi def link logText     Comment

let b:current_syntax = "nutanix-log"

