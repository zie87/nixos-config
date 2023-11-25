local function init()
    require 'zie.vim'.init()
    require 'zie.keymaps'.init()
    
    -- require'nvim-treesitter.configs'.setup()

    require 'zie.colorscheme'.init()
    require 'zie.neorg'.init()
end

return {
    init = init,
}
