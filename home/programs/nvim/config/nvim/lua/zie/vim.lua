local function init()
    vim.cmd ":command! WQ wq"
    vim.cmd ":command! Wq wq"
    vim.cmd ":command! W w"
    vim.cmd ":command! Q q"
    vim.cmd ":command! Qa qa"
   
    -- This file is automatically loaded by plugins.core
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"

    vim.o.clipboard = "unnamedplus"
    
    vim.o.termguicolors = true -- True color support
end

return {
    init = init,
}
