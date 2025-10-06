--=====================================================================================
--PLUGINS
--=====================================================================================

vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-treesitter/nvim-treesitter', {'do':':TSUpdate'}
  Plug 'windwp/nvim-autopairs'
  Plug 'numToStr/Comment.nvim'
  Plug 'alvan/vim-closetag'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  " Plug 'gmr458/cold.nvim'
  " Plug 'sainnhe/gruvbox-material'
  " Plug 'AlexvZyl/nordic.nvim'
  " Plug 'savq/melange-nvim'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'


  call plug#end()
]]

--=====================================================================================
--CMP
--=====================================================================================

local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    }),
})

--=====================================================================================
--BACKGROUND & COLORSCHEMES
--=====================================================================================

vim.o.background = "dark"
vim.cmd("colorscheme custom_star")

vim.opt.colorcolumn = "87"
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 0, bg = "#303030" })

vim.api.nvim_set_hl(0, "Normal", {bg = "none"})            
vim.api.nvim_set_hl(0, "NormalNC", {bg = "none"})          
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})       
vim.api.nvim_set_hl(0, "FloatBorder", {bg = "none"})       
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})        

-- Statusline colors
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#303030" })  -- default
vim.api.nvim_set_hl(0, "StatusLineMode", { fg = "#000000", bg = "#98c379", bold = true })
vim.api.nvim_set_hl(0, "StatusLineMedium", { fg = "#abb2bf", bg = "#303030" })

-- Git colors
vim.api.nvim_set_hl(0, "StatusLineGitDiffAdded", { fg = "#98c379", bg = "#303030" })
vim.api.nvim_set_hl(0, "StatusLineGitDiffChanged", { fg = "#e5c07b", bg = "#303030" })
vim.api.nvim_set_hl(0, "StatusLineGitDiffRemoved", { fg = "#e06c75", bg = "#303030" })
vim.api.nvim_set_hl(0, "StatusLineGitBranchIcon", { fg = "#61afef", bg = "#303030" })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98c379", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#e5c07b", bg = "none" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#e06c75", bg = "none" })

--=====================================================================================
--OPTIONS
--=====================================================================================

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

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        vim.cmd('normal gg=G``')  -- `` returns to original position
    end,
})

vim.opt.clipboard = "unnamedplus"

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


--=====================================================================================
--SETUPS+PLUGINS
--=====================================================================================

require('statusline')
require('gitsigns').setup()
require('colorizer').setup()

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

--=====================================================================================
--KEYMAPS
--=====================================================================================

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

vim.keymap.set('n', '<leader>vt', ':vsplit |terminal <CR>')

-- Remove search highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>')

-- Netrw shortcut
vim.keymap.set('n', '<leader>n', ':Ex<CR>')

-- Split
vim.keymap.set('n', '<leader>vs', ':vsplit | Ex<CR>')
vim.keymap.set('n', '<leader>hs', ':split | Ex<CR>')

--=====================================================================================
--TELESCOP
--=====================================================================================

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

local function find_project_root(path)
    path = path or vim.fn.getcwd()

    if vim.fn.filereadable(path .. '/.project') == 1 then
        return path
    end

    local parent = vim.fn.fnamemodify(path, ':h')
    if parent == path then
        return nil
    end

    return find_project_root(parent)
end

local function project_find_files(opts)
    opts = opts or {}

    local project_root = find_project_root()
    if project_root then
        opts.cwd = project_root
    else
        opts.cwd = vim.fn.getcwd()
    end

    builtin.find_files(opts)
end

local function find_projects()
    local home = vim.fn.expand('~')
    local projects = {}

    local search_dirs = {
        home .. '/projects',
        home .. '/work',
        home .. '/code',
        home .. '/dev',
        home .. '/src',
        home,
    }

    for _, dir in ipairs(search_dirs) do
        if vim.fn.isdirectory(dir) == 1 then
            local find_cmd = string.format('find %s -name ".project" -type f 2>/dev/null', vim.fn.shellescape(dir))
            local handle = io.popen(find_cmd)
            if handle then
                for line in handle:lines() do
                    local project_dir = vim.fn.fnamemodify(line, ':h')
                    local project_name = vim.fn.fnamemodify(project_dir, ':t')
                    table.insert(projects, {
                        name = project_name,
                        path = project_dir,
                        display = string.format("%s (%s)", project_name, project_dir)
                    })
                end
                handle:close()
            end
        end
    end

    return projects
end

local function switch_project()
    local projects = find_projects()

    if #projects == 0 then
        print("No projects with .project files found")
        return
    end

    require('telescope.pickers').new({}, {
        prompt_title = 'Switch Project',
        finder = require('telescope.finders').new_table({
            results = projects,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.display,
                    ordinal = entry.name .. ' ' .. entry.path,
                }
            end,
        }),
        sorter = require('telescope.config').values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            require('telescope.actions').select_default:replace(function()
                local selection = require('telescope.actions.state').get_selected_entry()
                require('telescope.actions').close(prompt_bufnr)

                if selection then
                    vim.cmd('cd ' .. selection.value.path)
                    print('Switched to project: ' .. selection.value.name)
                end
            end)
            return true
        end,
    }):find()
end

telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist/",
            "build/",
            "target/",
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        find_files = {
            hidden = true,
            attach_mappings = function(prompt_bufnr, map)
                return true
            end,
        },
    },
})

vim.keymap.set('n', '<leader>ff', project_find_files, { desc = 'Find files (project-aware)' })
vim.keymap.set('n', '<leader>fp', switch_project, { desc = 'Switch project' })

vim.keymap.set('n', '<leader>fg', function()
    local project_root = find_project_root()
    builtin.live_grep({
        cwd = project_root or vim.fn.getcwd()
    })
end, { desc = 'Live grep in project' })

vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search in current file' })
vim.keymap.set('n', '<leader>th', ':Telescope colorscheme<CR>', { desc = 'Change theme' })






