-- vim: tw=80
-- paynes_grayscale
--
--[[

Refinement of my old colorscheme(s).

   (1) Colors must aid in understanding of the text

       E.g., strings have a unique highlight. It is important to recognize
       strings apart from code. It is more important to recognize interpolation
       within a string.

       Syntax highlighting both visually cues where the string is, and isn't.

   (2) Color emphasis should mirror code importance.

       The eye is drawn to high contrast. A very bright white on a black
       background is more visually distinct than a mid-gray. Colors should 'pop'
       only when useful.

       Control flow is important to easily distinguish, thus it is useful to
       increase contrast. Comments can be pushed to the background, and require
       more intentionality to read.

   (3) Colors must mean something.

       For a token to be uniquely highlighted, there must be meaning to it's
       highlight group. Is there a reason one would highlight floats differently
       from ints. Or bools differently from strings. Maybe. Depends on language
       and function.

Yes emphasis
- Strings (white for escape chars)
- Types
- User-defined methods
- "Named values"
   - nil/none/null
   - true/false
- Control flow
   - if/else
   - cond/case
   - while/until

No emph.
- Statements
- Built-ins
- Operators

Grayscale should be used to push "less important" bits to the background. Still
visible, but less so. E.g., brackets. String start/end quotes.

Unimportant
- Brackets
- String start/end tokens
- Comments

Colors based on slate gray from here:
https://www.colorxs.com/color/hex-708090

Colors:
 #161a1d \
 #22262b  +-- bg colors
 #2d333a /
 #384048
 #434d56 \
 #5a6673  |
 #708090  +-- fg colors
 #8d9aa6  |
 #c6ccd3 /

Monochrome:
bg:
 #000000
 #0d0d0d
 #121212 <-- bg[0]
 #181818
 #222222
 #282828
fg:
 #424242
 #6a6a6a
 #a0a0a0 <-- fg[0]
 #cfcfcf
 #ffffff

TODO: I've found #181818 is somehow a bit too much of a value increase from
      the default background color of #121212. Can maybe decrease the steps by
      30% or so.

--]]

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'a'

--- Special/accent colors ------------------------------------------------------
local yellow = '#eb9753'

local green = {
   [ 0] = '#1c3536',    -- bg
   [ 1] = '#5f8787',    -- fg
}

local blue = {
   [ 0] = '#1c2836',    -- bg dark
   [ 1] = '#2d4157',    -- bg light(er)
}

local red = {
   [ 0] = '#361C29',    -- bg dark
   [ 1] = '#572d41',    -- bg light(er)
   [ 2] = '#A7485A',    -- fg
}

--- Grayscale ------------------------------------------------------------------
local bg_mono =  {
   [-2] = '#000000',
   [-1] = '#0d0d0d',
   [ 0] = '#121212',
   [ 1] = '#181818',
   [ 2] = '#222222',
   [ 3] = '#282828',
}

local fg_mono = {
   [-2] = '#424242',
   [-1] = '#6a6a6a',
   [ 0] = '#a0a0a0',
   [ 1] = '#cfcfcf',
   [ 2] = '#ffffff',
}

--- Monochrome slate gray ------------------------------------------------------
local bg_color = {
   [ 0] = '#161a1d',
   [ 1] = '#22262b',
   [ 2] = '#2d333a',
}

local fg_color = {
   [-2] = '#434d56',
   [-1] = '#5a6673',
   [ 0] = '#708090',
   [ 1] = '#8d9aa6',
   [ 2] = '#c6ccd3',
}

for idx,tbl in ipairs({
   bg_mono,
   bg_color,
   fg_mono,
   fg_color,
}) do
   setmetatable(tbl, {
      -- TODO: Add traceback. Find where this originated.
      __index = function (tbl, key) error() end
   })
end

--------------------------------------------------------------------------------
local fg = fg_mono[0]
local bg = bg_mono[0]

--------------------------------------------------------------------------------
local nvim_set_hl = vim.api.nvim_set_hl 

for name, highlight in pairs({
   Normal = { fg = fg },

   --- Text --------------------------------------------------------------------
   Comment    = { fg = fg_mono[-2] },
   String     = { fg = fg_color[-1] },

   Constant   = { link = 'Normal' },
   NonText    = { link = 'Normal' },
   Todo       = { fg = yellow },
   DiffAdd    = { fg = fg, bg = green[0] },
   DiffDelete = { fg = bg_mono[1], bg = bg },
   DiffChange = { fg = fg, bg = blue[0] },
   DiffText   = { fg = fg_mono[2], bg = blue[1], bold = true },
   SpellBad   = { fg = fg_mono[2], bg = red[0] },
   SpellLocal = { fg = fg_mono[2], bg = blue[0] },
   Conceal    = { link = 'Comment' },

   --- Variables & functions ---------------------------------------------------
   Macro      = { link = 'Normal' },
   Function   = { link = 'Normal' },
   Exception  = { fg = fg_mono[2] },
   Identifier = { fg = fg_color[1] },
   Type       = { fg = fg_color[2] },
   TypeDef    = { fg = fg_color[2], bold = true },

   --- User interface ----------------------------------------------------------
   -- The color blue I picked for diff changed is the same as visual selection.
   -- I'm consider changing the selection color, but for now just doing this...
   Visual       = vim.o.diff and { reverse = true }
                  or { fg = fg_mono[1], bg = blue[0] },

   Pmenu        = { fg = fg_mono[-2], bg = bg_mono[-1] },
   PmenuSel     = { fg = fg, bg = bg_mono[-1]  },
   PmenuThumb   = { bg = fg_mono[-1] },
   PmenuSbar    = { bg = bg_mono[1] },
   Folded       = { fg = fg_mono[-2], bg = bg_mono[1] },
   FoldColumn   = { fg = bg_color[2], bg = bg },
   Directory    = { fg = blue[1] },
   Title        = { fg = blue[1] },
   Question     = { link = 'Normal' },
   MoreMsg      = { link = 'Normal' },
   Error        = { link = 'SpellBad' },
   ErrorMsg     = { fg = red[2] },
   WarningMsg   = { fg = yellow },
   EndOfBuffer  = { link = 'LineNr' },
   ColorColumn  = { bg = bg_mono[1] },
   CursorLineNr = { fg = fg },
   LineNr       = { link = 'Comment' },
   Search       = { reverse = true },
   IncSearch    = { link = 'Search' },
   WinSeparator = { fg = fg_mono[-2] },
   MatchParen   = { fg = fg, bg = blue[1] },
   SignColumn   = { bg = bg },
   QuickFixLine = { link = 'Visual' },

   NormalInactive = { bg = bg },
   NormalFloat    = { bg = bg_mono[-1] },
   FloatBorder    = { fg = fg_color[-1], bg = bg_mono[0] },
   FloatShadow    = { bg = bg_color[0] },
   FloatShadowThrough = { bg = bg },

   -- TODO: To add from `:h highlight-groups` docs:
   --[[
      Substitute        `:s`  replacement text highlighting
      ModeMsg
      ModeArea
      MsgSeparator
   --]]

   --- Literals ----------------------------------------------------------------
   Constant   = { link = 'Normal' },
   Float      = { link = 'Normal' },
   Boolean    = { link = 'Normal' },
   Number     = { link = 'Normal' },
   SpecialKey = { link = 'Special' }, -- e.g., when you <C-v>V and it makes a ^V

   --- Language features, built-ins, etc. --------------------------------------
   Identifier  = { link = 'Normal' },
   Statement   = { link = 'Normal' },
   Keyword     = { link = 'Normal' },
   Special     = { link = 'Normal' },
   Conditional = { fg = fg_mono[2] },
   Repeat      = { fg = fg_mono[2] },
   PreProc     = { fg = fg_mono[-1] },
   Define      = { fg = fg_mono[-1] },
   Operator    = { fg = fg_mono[-1] },
   
   -- My statusline groups.
   Statusline_Cursor       = { fg = fg_mono[1], bg = bg_mono[1], bold = true },
   Statusline_Filetype     = { fg = fg, bg = bg },
   Statusline_Mode_Normal  = { fg = fg_mono[2], bg = blue[0], bold = true },
   Statusline_Mode_Insert  = { fg = fg_mono[2], bg = green[0], bold = true },
   Statusline_Mode_Visual  = { fg = fg_mono[2], bg = bg_color[0], bold = true },
   Statusline_Mode_Replace = { fg = fg_mono[2], bg = red[0], bold = true },

   -- Built-in statusline groups, but should probably go with the above.
   StatusLineNC = { fg = fg_mono[-1], bg = bg_mono[1] },
   StatusLine   = { fg = fg, bg = bg_mono[1] },
 
   -- LSP groups.
   ['@field']       = { fg = fg },
   ['@variable']    = { fg = fg },
   ['@boolean']     = { fg = fg_mono[2] },
   ['@bracket']     = { fg = fg_mono[-2] },
   ['@punctuation'] = { link = '@bracket' },
   ['@constructor'] = { link = '@bracket' },

   --- Language-specific  ------------------------------------------------------
   ['@variable.bash'] = { fg = fg_color[2] },
   ['@constant.bash'] = { link = '@variable.bash' },
   ['@punctuation.special.bash'] = { link = '@variable.bash' },

   --- Plugins -----------------------------------------------------------------
   --- lazy.nvim ---------------------------------------------------------------
   -- Just :Inspect the element in the :Lazy ui and change its highlight or
   -- whatever.
   LazyH1           = { fg = fg_mono[2] },
   LazyReasonPlugin = { fg = fg },
   LazySpecial      = { fg = fg },
   LazyReasonStart  = { fg = fg_color[0] },
   LazyProp         = { fg = fg_mono[-1] },
   LazyButton       = { fg = fg_mono[-1], bg = bg },
   LazyCommit       = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyReasonCmd    = { link = 'Comment' },

   --- nvim-treesitter-context -------------------------------------------------
   TreesitterContext = { bg = bg_mono[1] },

   -- LSP nonsense
   DiagnosticHint             = { link = 'Comment' },
   DiagnosticInfo             = { link = 'Comment' },
   DiagnosticWarn             = { fg = fg },
   DiagnosticError            = { fg = fg_mono[-1] },
   DiagnosticVirtualTextHint  = { link = 'Comment' },
   DiagnosticVirtualTextInfo  = { link = 'Comment' },
   DiagnosticVirtualTextWarn  = { link = 'Comment' },
   DiagnosticVirtualTextError = { fg = red[2] },
   DiagnosticFloatingHint     = { fg = fg_mono[2] },
   DiagnosticFloatingInfo     = { fg = fg_mono[2] },
   DiagnosticFloatingWarn     = { fg = fg_mono[2] },
   DiagnosticFloatingError    = { fg = fg_mono[2] },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the same thing

}) do
   nvim_set_hl(0, name, highlight)
end
