{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./editor
    ./colorscheme.nix
    ./ui.nix
    # ./barbar.nix
    # ./comment.nix
    # ./floaterm.nix
    # ./harpoon.nix
    # ./lsp.nix
    # ./lualine.nix
    # ./markdown-preview.nix
    # ./neorg.nix
    # ./startify.nix
    # ./tagbar.nix
    # ./telescope.nix
    # ./treesitter.nix
    # ./vimtex.nix
  ];

  programs.nixvim = {
    extraPackages = with pkgs; [
      lua-language-server
      nil # nix lsp
      alejandra # nix formatter
    ];

    plugins = {
      gitsigns = {
        enable = true;
        trouble = true;
        signs = {
          add = {text = "+";};
          change = {text = "~";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          changedelete = {text = "~";};
        };
        onAttach.function = ''
          function(bufnr)
            vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ 'n', 'v' }, ']c', function()
              if vim.wo.diff then
                return ']c'
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
              if vim.wo.diff then
                return '[c'
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
          end
        '';
      };

      nvim-colorizer = {
        enable = true;
      };
    };
  };
}
