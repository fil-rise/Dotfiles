--===================================================================================================================
--PLUGINS
--===================================================================================================================

vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
  Plug 'windwp/nvim-autopairs'
  Plug 'numToStr/Comment.nvim'
  Plug 'alvan/vim-closetag'

  call plug#end()
]]

--===================================================================================================================
--BACKGROUND & COLORSCHEMES
--===================================================================================================================

vim.cmd("colorscheme custom")

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})            
vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})          
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})       
vim.api.nvim_set_hl(0, "FloatBorder", {bg = "none"})       
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})        

--===================================================================================================================
--SETUPS+PLUGINS
--===================================================================================================================

require("statusline")

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "python", "c", "cpp", "html", "css" },
  highlight = { enable = true },
  indent = { enable = true }
}

-- Autopairs
require('nvim-autopairs').setup{}

-- Comment.nvim
require('Comment').setup()

-- vim-closetag
vim.g.closetag_filenames = '*.html'
vim.g.closetag_filetypes = 'html'

--===================================================================================================================
--OPTIONS
--===================================================================================================================

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.opt.numberwidth = 5

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true
vim.o.scrolloff = 10

vim.o.confirm = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.opt.termguicolors = true
vim.opt.tabstop = 4  
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true


vim.opt.wrap = true          -- Don't wrap long lines
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.signcolumn = "yes"    -- Always show sign column (prevents text shifting)

vim.opt.completeopt = { "menu", "menuone", "noselect" }

--open from where you left
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

vim.opt.signcolumn = 'no'

--===================================================================================================================
--KEYMAPS
--===================================================================================================================

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Move line down with Ctrl-j in all modes
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<C-j>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })

-- Optional: Also add Ctrl-k to move line up for completeness
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<C-k>', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- Quick save, exit etc
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>x', ':x<CR>')
vim.keymap.set('n', '<leader>xa', ':xa<CR>')
vim.keymap.set('n', '<leader>so', ':so %<CR>')

-- Remove search highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>')

-- Netrw shortcut
vim.keymap.set('n', '<leader>n', ':Ex<CR>')

-- Split
vim.keymap.set('n', '<leader>vs', ':vsplit | Ex<CR>')
vim.keymap.set('n', '<leader>hs', ':split | Ex<CR>')

--===================================================================================================================
--CODE-RUNNER
--===================================================================================================================

local function run_file()
    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%:t')  -- Get filename with extension
    local filepath = vim.fn.expand('%:p')  -- Get full path

    local command = ""

    if filetype == 'cpp' then
        command = string.format(
            "g++ '%s' -o cpp.out && clear && ./cpp.out", 
            filepath
        )
    elseif filetype == 'c' then
        command = string.format(
            "gcc '%s' -o c.out && clear && ./c.out", 
            filepath
        )
    elseif filetype == 'python' then
        command = string.format(
            "clear && python3 '%s'", 
            filepath
        )
    else
        vim.notify("Unsupported file type: " .. filetype, vim.log.levels.WARN)
        return
    end

    vim.cmd('w')
    vim.cmd('vsplit | terminal ' .. command)
end

vim.keymap.set('n', '<leader>h', run_file, { 
    desc = "Run current file in new terminal",
    silent = true 
})

