" vim: set foldmethod=marker foldlevel=1 :
" Preamble & vars
"
" Author:   Cormac Relf <web@cormacrelf.net>
"
" Note:     Based on github's syntax highlighting theme as of 2018.
"           Originally based on https://github.com/endel/vim-github-colorscheme,
"           but none of that code remains.
"
" Usage:    colorscheme github
"           " optional, if you use airline
"           let g:airline_theme = "github"

hi clear
if exists("syntax_on")
    syntax reset
endif

if !exists("g:github_colors_extra_functions")
  let g:github_colors_extra_functions = 1
endif

if !exists("g:github_colors_soft")
  let g:github_colors_soft = 0
endif

if !exists("g:github_colors_block_diffmark")
  let g:github_colors_block_diffmark = 0
endif

let colors_name = "github"

" Helper functions
" from vim-gotham

function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Spell(group, attr)
  let l:attrs = [a:group, 'guisp=' . s:colors[a:attr].gui ]
  call s:Highlight(l:attrs)
endfunction


function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction

" Colors

let s:lib = {}    " to build s:colors from, not to be used directly
let s:colors = {} " the 'stable API' you can access through s:Col

" color docs
" --light mode --------------- dark mode
"   base0 = dark text fg     | lightest text fg
"   base1 = dark solid       | light solid
"   base2 = comment
"   base3 = darker gutter fg
"   base4 = normal gutter fg
"   grey0 = ui grey darker   | ui grey lighter
"   grey1 = ui grey medium   | ui grey medium
"   grey2 = ui grey bright   | ui grey dark
"   gutter = linenr bg
"   overlay = overlay background
"   bg = bg
"   visualblue = for visual selections
"   lightblue  = for folds

let s:lib.white      = { 'gui': '#fafbfc', 'cterm': 231 }
let s:lib.base0      = { 'gui': '#24292e', 'cterm': 235 }
let s:lib.base1      = { 'gui': '#2f363d', 'cterm': 238 }
let s:lib.base2      = { 'gui': '#444d56', 'cterm': 238 }
let s:lib.base3      = { 'gui': '#586069', 'cterm': 243 }
let s:lib.base4      = { 'gui': '#6a737d', 'cterm': 243 }

let s:lib.darktext     = [
      \{ 'gui': '#959da5', 'cterm': 255 },
      \{ 'gui': '#6a737d', 'cterm': 254 },
      \{ 'gui': '#586069', 'cterm': 251 },
      \{ 'gui': '#444d56', 'cterm': 251 },
      \{ 'gui': '#444d56', 'cterm': 251 },
      \{ 'gui': '#24292e', 'cterm': 251 },
      \s:lib.base0
      \]

" actual colorful colors
let s:colors.red            = { 'gui': '#f97583', 'cterm': 167 }
let s:colors.darkred        = { 'gui': '#ea4a5a', 'cterm': 124 }
let s:colors.purple         = { 'gui': '#b392f0', 'cterm': 91  }
let s:colors.darkpurple     = { 'gui': '#8a63d2', 'cterm': 237 }
let s:colors.yellow         = { 'gui': '#ffea7f', 'cterm': 230 }
let s:colors.green          = { 'gui': '#85e89d', 'cterm': 29  }
let s:colors.boldgreen      = { 'gui': '#34d058', 'cterm': 29  }
let s:colors.orange         = { 'gui': '#ffab70', 'cterm': 166 }
let s:colors.boldorange     = { 'gui': '#fb8532', 'cterm': 166 }
let s:colors.lightgreen     = { 'gui': '#bef5cb', 'cterm': 85  }
let s:colors.lightred       = { 'gui': '#fdaeb7', 'cterm': 167 }
let s:colors.lightorange    = { 'gui': '#ffd1ac', 'cterm': 230 }
let s:colors.difftext       = { 'gui': '#86181d', 'cterm': 222 }
let s:colors.darkblue       = { 'gui': '#c8e1ff', 'cterm': 17  }
let s:colors.blue           = { 'gui': '#79b8ff', 'cterm': 26  }
let s:colors.blue0          = { 'gui': '#005cc5', 'cterm': 153 }
let s:colors.blue1          = { 'gui': '#044289', 'cterm': 153 }
let s:colors.blue2          = { 'gui': '#032f62', 'cterm': 153 }
let s:colors.blue3          = { 'gui': '#0366d6', 'cterm': 153 }
let s:colors.blue4          = { 'gui': '#05264c', 'cterm': 153 }
let s:colors.errorred       = { 'gui': '#b74951', 'cterm': 167 }

let s:colors.base0        = s:lib.darktext[0]
let s:colors.base1        = s:lib.darktext[1]
let s:colors.base2        = s:lib.darktext[2]
let s:colors.base3        = s:lib.darktext[3]
let s:colors.base4        = s:lib.darktext[4]

let s:colors.grey0        = s:lib.base4
let s:colors.grey1        = s:lib.base3
let s:colors.grey2        = s:lib.base2

let s:colors.uisplit      = s:lib.base3
let s:colors.bg           = s:lib.base0
let s:colors.fg           = s:lib.white
let s:colors.gutter       = s:lib.base0
let s:colors.endofbuf     = s:lib.base0
let s:colors.gutterfg     = s:colors.base2
let s:colors.lightblue    = s:colors.blue1
let s:colors.visualblue   = s:colors.blue2
let s:colors.overlay      = s:lib.base1


" named groups to link to
call s:Col('ghBackground', 'bg')
call s:Col('ghBlack', 'base0')
call s:Col('ghBase0', 'base0')
call s:Col('ghBase1', 'base1')
call s:Col('ghBase2', 'base2')
call s:Col('ghBase3', 'base3')
call s:Col('ghBase4', 'base4')
call s:Col('ghGrey0', 'grey0')
call s:Col('ghGrey1', 'grey1')
call s:Col('ghGrey2', 'grey2')
call s:Col('ghGreen', 'green')
call s:Col('ghBlue', 'blue')
call s:Col('ghBlue2', 'blue2')
call s:Col('ghBlue3', 'blue3')
call s:Col('ghBlue4', 'blue4')
call s:Col('ghDarkBlue', 'darkblue')
call s:Col('ghRed', 'red')
call s:Col('ghDarkRed', 'darkred')
call s:Col('ghPurple', 'purple')
call s:Col('ghDarkPurple', 'darkpurple')
call s:Col('ghOrange', 'orange')
call s:Col('ghLightOrange', 'lightorange')
call s:Col('ghYellow', 'yellow')
call s:Col('ghLightRed', 'lightred')
call s:Col('ghOver', 'overlay')
call s:Col('ghUISplit', 'uisplit')

" UI colors

call s:Col('Normal', 'fg', 'bg')
call s:Col('Cursor', 'bg', 'fg')
call s:Col('Visual', '', 'visualblue')
call s:Col('VisualNOS', '', 'lightblue')
call s:Col('Search', '', 'yellow') | call s:Attr('Search', 'bold')
call s:Col('Whitespace', 'base4', 'bg')
call s:Col('NonText',    'base4', 'bg')
call s:Col('SpecialKey', 'base4', 'bg')
call s:Col('Conceal',    'red')

call s:Col('MatchParen', 'darkblue', 'blue3')
call s:Col('WarningMsg', 'orange')
call s:Col('ErrorMsg', 'errorred')
call s:Col('Error', 'gutterfg', 'errorred')
call s:Col('Title', 'base1')
call s:Attr('Title', 'bold')

call s:Col('VertSplit',    'uisplit', 'uisplit')
call s:Col('LineNr',       'base4',  'gutter')
call s:Col('EndOfBuffer',  '',  'endofbuf')
call s:Col('ColorColumn',  '',       'grey2')

call s:Col('CursorLineNR', 'gutterfg',  'base4')
call s:Col('CursorLine',   '',       'base4')
call s:Col('CursorColumn', '',       'base4')

call s:Col('QuickFixLine', '', 'blue3') | call s:Attr('QuickFixLine', 'bold')
call s:Col('qfLineNr', 'gutterfg', 'gutter')

call s:Col('Folded',     'gutterfg', 'lightblue')
call s:Col('FoldColumn', 'blue0', 'gutter')

call s:Col('StatusLine',      'grey2', 'base0')
call s:Col('StatusLineNC',    'gutterfg', 'grey1')
" statusline determines inactive wildmenu entries too
call s:Col('WildMenu', 'grey2', 'blue')

call s:Col('airlineN1',       'fg', 'base0')
call s:Col('airlineN2',       'fg', 'base1')
call s:Col('airlineN3',       'fg',  'grey1')
call s:Col('airlineInsert1',  'fg', 'blue')
call s:Col('airlineInsert2',  'fg', 'darkblue')
call s:Col('airlineVisual1',  'fg', 'purple')
call s:Col('airlineVisual2',  'fg', 'darkpurple')
call s:Col('airlineReplace1', 'fg', 'red')
call s:Col('airlineReplace2', 'fg', 'darkred')

call s:Col('Pmenu',      'base0', 'overlay')
call s:Col('PmenuSel',   'overlay',  'blue') | call s:Attr('PmenuSel', 'bold')
call s:Col('PmenuSbar',  '',      'grey2')
call s:Col('PmenuThumb', '',      'grey0')

call s:Col('Question', 'green')

call s:Col('TabLine',     'base1', 'grey1') | call s:Attr('TabLine', 'none')
call s:Col('TabLineFill', 'base0', 'base0') | call s:Attr('TabLineFill', 'none')
call s:Col('TabLineFill', 'grey0', 'grey0') | call s:Attr('TabLineFill', 'none')
call s:Col('TabLineSel',  'base1'         ) | call s:Attr('TabLineSel', 'bold')

call s:Col('DiffAdd',    '', 'lightgreen')
call s:Col('DiffDelete', 'base4', 'lightred') | call s:Attr('DiffDelete', 'none')
call s:Col('DiffChange', '', 'lightorange')
call s:Col('DiffText',   '', 'difftext')

" Syntax highlighting

call s:Clear('Ignore') | call s:Col('Ignore', 'base4', 'bg')
call s:Col('Identifier', 'blue')
call s:Col('PreProc', 'red')
call s:Col('Macro', 'blue')
call s:Col('Define', 'purple')
call s:Col('Comment', 'base0')
call s:Col('Constant', 'blue')
call s:Col('String', 'darkblue')
call s:Col('Function', 'purple')
call s:Col('Statement', 'red')
call s:Col('Type', 'red')
call s:Col('Todo', 'purple') | call s:Attr('Todo', 'underline')
call s:Col('Special', 'purple')
call s:Col('SpecialComment', 'base0')
call s:Col('Label', 'base0')
call s:Col('StorageClass', 'red')
call s:Col('Structure', 'red')

" Particular Languages

hi link cDefine Define
highlight clear SignColumn

" html
" xml doesn't recognise xmlEndTag->xmlTagName, so colour it all green
call s:Col('xmlTag', 'green')
call s:Col('xmlEndTag', 'green')
call s:Col('xmlTagName', 'green')
call s:Col('xmlAttrib', 'purple')

call s:Col('htmlTag', 'base0')
hi link htmlEndTag  htmlTag
hi link htmlTagN    htmlTag
hi link htmlTagName xmlTagName
hi link htmlArg     xmlAttrib
hi link htmlLink    Underlined

" vim-jsx-pretty
hi link jsxTag htmlTag
hi link jsxCloseTag jsxTag
hi link jsxCloseString jsxTag
hi link jsxAttrib xmlAttrib
hi link jsxEqual Operator
hi link jsxTagName htmlTagName
call s:Col('jsxComponentName', 'blue')


" toml
hi link tomlTable ghPurple
hi link tomlKey   ghBlack
" yaml
hi link yamlBlockMappingKey ghGreen

call s:Col('ghNormalNoBg', 'fg', '')

" vimL
hi link vimHiTerm      ghBlack
hi link vimHiGroup     ghOrange
hi link vimUserFunc    ghPurple
hi link vimCommand     Statement
hi link vimNotFunc     Statement
hi link vimGroup       Statement
hi link vimHighlight   Identifier
hi link vimAutoCmd     Identifier
hi link vimAutoEvent   Identifier
hi link vimSyntax      Identifier
hi link vimSynType     Identifier
hi link vimMap         Identifier
hi link vimOption      Identifier
hi link vimUserCommand Identifier
hi link vimAugroupKey  Identifier
hi link vimParenSep    Delimiter

hi link Delimiter         ghNormalNoBg
hi link SpecialComment    Comment
hi link Character         Number
hi link CursorIM          Cursor
hi link cppSTL            Function
hi link cppSTLType        Type
hi link shDeref           Identifier
hi link shVariable        Function
hi link perlSharpBang     Special
hi link schemeFunc        Statement

" typescript
hi link typescriptBraces  ghBlack
hi link typescriptBraces  ghBlack
hi link typescriptParens  ghBlack

" ruby
hi link rubySharpBang     Special
hi link rubyDefine        PreProc
hi link rubyClass         PreProc
hi link rubyConstant      Define
hi link rubyInclude       PreProc

" python
hi link pythonBuiltin     Identifier

" fatih/vim-go
" you can enable more highlights from :h go-syntax
hi link goConstants       Constant
hi link goFunctionCall    Identifier

" rust
hi link rustModPath       Define
hi link rustIdentifier    Function
hi link rustAttribute     ghBase0
hi link rustDerive        rustAttribute
hi link rustDeriveTrait   ghDarkPurple
hi link rustCommentLineDoc ghBase2

" neovimhaskell/haskell-vim
hi link haskellIdentifier Function
hi link haskellType       Identifier

" diff (language)
call s:Col('diffFile',      'base0',    'grey2')
call s:Col('diffNewFile',   'base0',    'grey2')
call s:Col('diffIndexLine', 'darkblue', 'grey2')
call s:Col('diffLine',      'base2',    'lightblue')
call s:Col('diffSubname',   'darkblue', 'lightblue')
call s:Col('diffAdded',     'green',    'lightgreen')
call s:Col('diffRemoved',   'red',      'lightred')

" vim-pandoc-syntax
call s:Col('pandocAtxStart', 'base4')
call s:Col('pandocOperator', 'red')
call s:Col('pandocDelimitedCodeBlock', 'darkpurple')
call s:Col('pandocNoFormatted', 'base0', 'gutter')
call s:Col('pandocPCite', 'purple')
call s:Col('pandocCitekey', 'purple')

" tex
call s:Col('texMath', 'blue')
call s:Col('texStatement', 'red')
call s:Col('texType', 'purple')
hi link texSection Title

" plain builtin markdown
hi link htmlH Title
hi link markdownListMarker pandocOperator
hi link markdownCode pandocDelimitedCodeBlock
hi link markdownRule Title
hi link markdownHeadingDelimiter pandocAtxStart

" clojure
hi link clojureDefine Type
hi link clojureKeyword Identifier
hi link clojureMacro ghPurple

" Plugin Support

" GitGutter
call s:Col('GitGutterAdd',          'green', 'gutter')
call s:Col('GitGutterChange',       'orange', 'gutter')
call s:Col('GitGutterDelete',       'darkred', 'gutter')
call s:Col('GitGutterChangeDelete', 'orange', 'gutter')

" NERDTree
hi link NERDTreeDir       ghBlue
hi link NERDTreeCWD       ghRed
hi link NERDTreeExecFile  ghPurple
hi link NERDTreeFile      ghDarkBlue

" Startify
call s:Clear('Directory') " somehow it's linked to 'Blue' + bold?
hi link Directory         ghBlue
hi link StartifyPath      ghBlue
hi link StartifyHeader    ghBlue

call s:Col('ghSneak', 'bg', 'purple')
call s:Col('ghOverBg', '',  'overlay')
" vim-sneak
hi link Sneak             ghSneak
hi link SneakScope        ghOverBg
hi link sneakLabel        ghSneak

" fzf
" + means the selected one
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['fg', 'ghOver'],
  \ 'hl':      ['fg', 'ghBlue'],
  \ 'fg+':     ['fg', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine'],
  \ 'hl+':     ['fg', 'ghBlue'],
  \ 'info':    ['fg', 'ghRed'],
  \ 'border':  ['fg', 'ghGrey1'],
  \ 'prompt':  ['fg', 'ghBlue'],
  \ 'pointer': ['fg', 'ghRed'],
  \ 'marker':  ['fg', 'ghPurple'],
  \ 'spinner': ['fg', 'ghDarkBlue'],
  \ 'header':  ['fg', 'ghDarkBlue'] }

" Coc
call s:Col('CocHighlightText', '', 'gutter')

call s:Col('CocErrorSign', 'gutter', 'errorred')
call s:Attr('CocErrorSign', 'bold')
call s:Col('CocErrorHighlight', '', 'lightred')
call s:Attr('CocErrorHighlight', 'underline')

call s:Col('CocWarningHighlight', '', '')
call s:Attr('CocWarningHighlight', 'underline')
call s:Col('CocWarningSign', 'orange', 'gutter')

call s:Col('CocInfoSign', 'blue', 'gutter')
call s:Col('CocInfoHighlight', '', 'lightblue')

call s:Col('CocHintSign', 'base4', 'gutter')

" Spelling
if has("spell")
  call s:Col('SpellBad', 'red')
  call s:Attr('SpellBad', 'undercurl')
  call s:Spell('SpellBad', 'red')
  call s:Col('SpellCap', 'green')
  call s:Attr('SpellCap', 'undercurl')
  call s:Spell('SpellCap', 'green')
  call s:Col('SpellLocal', 'purple')
  call s:Attr('SpellLocal', 'undercurl')
  call s:Spell('SpellLocal', 'yellow')
  call s:Col('SpellRare', 'purple')
  call s:Attr('SpellRare', 'undercurl')
  call s:Spell('SpellRare', 'purple')
endif
