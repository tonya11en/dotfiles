" Vim syntax file for Envoy log files
" Tony Allen
"
" :help color to see type -> color mappings

"syntax match logCategory /\(\[\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\]\[\S\+\]\[\S\+\]\)\@<=\[\S\+\]/
"hi def link logCategory  Label

"syntax match logFile '\(\[\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\]\[[0-9]\+\]\[[a-z]\+\]\[[a-z]\+\]\s\+\[\)\@<=\(\([a-z0-9_]\+\/\)\+\)\S\+\.\S\{2}'
"hi def link logFile  Keyword

syntax match logDate     /\[\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\]/
hi def link logDate  StorageClass


syntax match logFile '\(\[\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\]\[[0-9]\+\]\[[a-z]\+\]\[[a-z]\+\]\s\+\[\)\([a-z0-9_]\+\/\)\+\S\+'
hi def link logFile  Keyword


let b:current_syntax = "envoy-log"
