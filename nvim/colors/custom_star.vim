set bg=dark
hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'custom_star'

" ============================================================================
" Editor UI
" ============================================================================
highlight Normal guifg=#FEFEFE guibg=#202020
highlight NormalFloat guifg=#FEFEFE guibg=#202020
highlight Conceal guibg=#262626
highlight Directory guifg=#C1C88D
highlight Error guifg=#C34143 gui=undercurl
highlight ErrorMsg guifg=#FFFEDB
highlight LineNrAbove guifg=#888888
highlight LineNrBelow guifg=#888888
highlight LineNr guifg=#d6d2c8
highlight MatchParen guifg=#FFFEDB
highlight NonText guifg=#303030
highlight Pmenu guifg=#918988 guibg=#303030
highlight PmenuSbar guifg=#918988 guibg=#262626
highlight PmenuSel guifg=#BFBBBA guibg=#303030
highlight PmenuThumb guifg=#918988 guibg=#262626 gui=reverse
highlight Question guifg=#9b8d7f
highlight QuickFixLine guibg=#303030
highlight Search guibg=#5F5958
highlight SpecialKey guifg=#676767
highlight StatusLine guifg=#FFFEDB guibg=#34383C
highlight Substitute guifg=#1A1A1A guibg=#C1C88D
highlight TabLine guifg=#A09998 guibg=#212121
highlight TabLineFill guifg=#A09998 guibg=#212121
highlight TabLineSel guifg=#A09998 guibg=#40474F
highlight Title guifg=#FFFEDB term=none cterm=none
highlight Underlined gui=undercurl
highlight VertSplit guifg=#303030
highlight Visual guibg=#454545
highlight WarningMsg guifg=#FFFEDB
highlight WinSeparator guibg=#111111 guifg=#888888

" ============================================================================
" Diff
" ============================================================================
highlight DiffAdd guifg=#FFFEDB guibg=#2B3328
highlight DiffChange guifg=#FFFEDB guibg=#262636
highlight DiffDelete guifg=#C34143 guibg=#42242B
highlight DiffText guifg=#FFFEDB guibg=#49443C

" ============================================================================
" Tree-sitter Syntax Groups
" ============================================================================

" Comments
highlight @comment guifg=#6f7b68
highlight @comment.documentation guifg=#6f7b68

" Constants
highlight @constant guifg=#cccccc
highlight @constant.builtin guifg=#cccccc
highlight @constant.macro guifg=#cccccc

" Strings
highlight @string guifg=#A2A970
highlight @string.documentation guifg=#A2A970
highlight @string.escape guifg=#C1C88D
highlight @string.regexp guifg=#C1C88D
highlight @string.special guifg=#C1C88D
highlight @string.special.symbol guifg=#C1C88D

" Characters
highlight @character guifg=#C1C88D
highlight @character.special guifg=#C1C88D

" Numbers & Booleans
highlight @number guifg=#6f7b68
highlight @number.float guifg=#6f7b68
highlight @boolean guifg=#6f7b68

" Functions
highlight @function guifg=#AA9AAC gui=bold
highlight @function.builtin guifg=#AA9AAC gui=bold
highlight @function.call guifg=#AA9AAC gui=bold
highlight @function.macro guifg=#AA9AAC gui=bold
highlight @function.method guifg=#AA9AAC gui=bold
highlight @function.method.call guifg=#AA9AAC gui=bold
highlight @constructor guifg=#AA9AAC gui=bold

" Keywords (dull brownish-gray)
highlight @keyword guifg=#a1583d gui=bold
highlight @keyword.conditional guifg=#a1583d gui=bold
highlight @keyword.repeat guifg=#a1583d gui=bold
highlight @keyword.return guifg=#a1583d gui=bold
highlight @keyword.function guifg=#a1583d gui=bold
highlight @keyword.operator guifg=#a1583d gui=bold
highlight @keyword.import guifg=#a1583d gui=bold
highlight @keyword.exception guifg=#a1583d gui=bold
highlight @keyword.directive guifg=#a1583d gui=bold
highlight @keyword.modifier guifg=#a1583d gui=bold

" Operators
highlight @operator guifg=#DEBF7C

" Variables
highlight @variable guifg=#FFF
highlight @variable.builtin guifg=#FFF
highlight @variable.parameter guifg=#FFF
highlight @variable.member guifg=#FFF
highlight @variable.parameter.builtin guifg=#FFF

" Types & Classes (dull greenish-gray)
highlight @type guifg=#7a8570
highlight @type.builtin guifg=#7a8570
highlight @type.definition guifg=#7a8570
highlight @type.qualifier guifg=#7a8570

" Type primitives (int, float, double, etc.) - slightly duller
highlight @type.builtin.c guifg=#6e7566
highlight @type.builtin.cpp guifg=#6e7566
highlight @type.builtin.python guifg=#6e7566

" Attributes & Annotations
highlight @attribute guifg=#8B9698
highlight @attribute.builtin guifg=#8B9698

" Properties & Fields
highlight @property guifg=#8B9698
highlight @field guifg=#8B9698

" Parameters
highlight @parameter guifg=#8B9698
highlight @parameter.builtin guifg=#8B9698

" Namespaces & Modules
highlight @namespace guifg=#AA9AAC
highlight @module guifg=#AA9AAC
highlight @module.builtin guifg=#AA9AAC

" Preprocessor
highlight @preproc guifg=#8B9698
highlight @include guifg=#8B9698
highlight @define guifg=#8B9698

" Structure & Special
highlight @structure guifg=#AA9AAC
highlight @special guifg=#cccccc

" Punctuation
highlight @punctuation.delimiter guifg=#DEBF7C
highlight @punctuation.bracket guifg=#DEBF7C
highlight @punctuation.special guifg=#DEBF7C

" Tags (HTML/XML)
highlight @tag guifg=#AA9AAC
highlight @tag.attribute guifg=#8B9698
highlight @tag.delimiter guifg=#DEBF7C

" Labels
highlight @label guifg=#C1C88D

" Todo/Fixme in comments
highlight @text.todo guifg=#8B9698
highlight @text.note guifg=#8B9698
highlight @text.warning guifg=#FFFEDB
highlight @text.danger guifg=#C34143

" Markup (Markdown, etc.)
highlight @markup.strong gui=bold
highlight @markup.italic gui=italic
highlight @markup.underline gui=underline
highlight @markup.strikethrough gui=strikethrough
highlight @markup.heading guifg=#FFFEDB
highlight @markup.link guifg=#C1C88D
highlight @markup.link.label guifg=#C1C88D
highlight @markup.link.url guifg=#8B9698 gui=underline
highlight @markup.raw guifg=#A2A970
highlight @markup.list guifg=#DEBF7C
highlight @markup.list.checked guifg=#C1C88D
highlight @markup.list.unchecked guifg=#6f7b68

" Markdown specific
highlight @markup.link.label.markdown_inline cterm=NONE
