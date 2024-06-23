syn clear gitcommitSummary
syn match   gitcommitSummary    "^.*" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
syn clear gitcommitOverflow
syn clear gitcommitBlank
setlocal nomodeline tabstop=8 formatoptions+=tl textwidth=0
