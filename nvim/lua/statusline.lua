local statusline_augroup =
    vim.api.nvim_create_augroup('gmr_statusline', { clear = true })

--- @param severity integer
--- @return integer
local function get_lsp_diagnostics_count(severity)
    if not rawget(vim, 'lsp') then
        return 0
    end

    local count = vim.diagnostic.count(0, { serverity = severity })[severity]
    if count == nil then
        return 0
    end

    return count
end

--- @param type string
--- @return integer
local function get_git_diff(type)
    local gsd = vim.b.gitsigns_status_dict
    if gsd and gsd[type] then
        return gsd[type]
    end

    return 0
end

--- @return string
local function mode()
    return string.format(
        '%%#StatusLineMode# %s %%*',
        vim.api.nvim_get_mode().mode
    )
end

--- @return string
local function git_diff_added()
    local added = get_git_diff 'added'
    if added > 0 then
        return string.format('%%#StatusLineGitDiffAdded#+%s%%*', added)
    end

    return ''
end

--- @return string
local function git_diff_changed()
    local changed = get_git_diff 'changed'
    if changed > 0 then
        return string.format('%%#StatusLineGitDiffChanged#~%s%%*', changed)
    end

    return ''
end

--- @return string
local function git_diff_removed()
    local removed = get_git_diff 'removed'
    if removed > 0 then
        return string.format('%%#StatusLineGitDiffRemoved#-%s%%*', removed)
    end

    return ''
end

--- @return string
local function git_branch_icon()
    return '%#StatusLineGitBranchIcon#%*'
end

--- @return string
local function git_branch()
    local branch = vim.b.gitsigns_head

    if branch == '' or branch == nil then
        return ''
    end

    return string.format('%%#StatusLineMedium#%s%%*', branch)
end

--- @return string
local function full_git()
    local full = ''
    local space = '%#StatusLineMedium# %*'

    local branch = git_branch()
    if branch ~= '' then
        local icon = git_branch_icon()
        full = full .. space .. icon .. space .. branch .. space
    end

    local added = git_diff_added()
    if added ~= '' then
        full = full .. added .. space
    end

    local changed = git_diff_changed()
    if changed ~= '' then
        full = full .. changed .. space
    end

    local removed = git_diff_removed()
    if removed ~= '' then
        full = full .. removed .. space
    end

    return full
end

--- @return string
local function file_percentage()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)

    return string.format(
        '%%#StatusLineMedium#  %d%%%% %%*',
        math.ceil(current_line / lines * 100)
    )
end

--- @return string
local function total_lines()
    local lines = vim.fn.line '$'
    return string.format('%%#StatusLineMedium#of %s %%*', lines)
end

--- @param hlgroup string
local function formatted_filetype(hlgroup)
    local filetype = vim.bo.filetype or vim.fn.expand('%:e', false)
    return string.format('%%#%s# %s %%*', hlgroup, filetype)
end

StatusLine = {}

StatusLine.inactive = function()
    return table.concat {
        formatted_filetype 'StatusLineMode',
    }
end

local redeable_filetypes = {
    ['qf'] = true,
    ['help'] = true,
    ['tsplayground'] = true,
}

StatusLine.active = function()
    local mode_str = vim.api.nvim_get_mode().mode
    if mode_str == 't' or mode_str == 'nt' then
        return table.concat {
            mode(),
            '%=',
            '%=',
            file_percentage(),
            total_lines(),
        }
    end

    if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
        return table.concat {
            formatted_filetype 'StatusLineMode',
            '%=',
            '%=',
            file_percentage(),
            total_lines(),
        }
    end

    --- @return string
    local function file_location()
        return string.format('%%#StatusLineMedium# %s %%*', vim.fn.expand('%F'))
    end

    --- @return string
    local function buffer_boxes()
        local buffers = vim.fn.getbufinfo({ buflisted = 1 })
        local count = #buffers
        local boxes = string.rep(' ', count)  -- big rounded symbols with spacing
        return string.format('%%#StatusLineBufferBox#%s%%*', boxes)
    end


    local statusline = {
        mode(),
        full_git(),
        '%=',
        file_location(),
        '%=',
        '%S ',
        buffer_boxes(),
        file_percentage(),
        total_lines(),
    }

    return table.concat(statusline)
end

vim.opt.statusline = '%!v:lua.StatusLine.active()'

