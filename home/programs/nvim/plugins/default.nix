{
  pkgs,
  inputs,
  ...
}: {
  imports = [
     ./neo-tree.nix
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

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins =
          prev.vimPlugins
          // {
            doom-one-nvim = prev.vimUtils.buildVimPlugin {
              name = "doom-one";
              src = inputs.doom-one-nvim;
            };
          };
      })
    ];
  };

  programs.nixvim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = doom-one-nvim;
        config = toLua ''
          -- Add color to cursor
          vim.g.doom_one_cursor_coloring = true
          -- Set :terminal colors
          vim.g.doom_one_terminal_colors = true
          -- Enable italic comments
          vim.g.doom_one_italic_comments = true
          -- Enable TS support
          vim.g.doom_one_enable_treesitter = true
          -- Color whole diagnostic text or only underline
          vim.g.doom_one_diagnostics_text_color = false
          -- Enable transparent background
          vim.g.doom_one_transparent_background = false
          -- Pumblend transparency
          vim.g.doom_one_pumblend_enable = false
          vim.g.doom_one_pumblend_transparency = 20
          -- Plugins integration
          vim.g.doom_one_plugin_neorg = true
          vim.g.doom_one_plugin_barbar = false
          vim.g.doom_one_plugin_telescope = true
          vim.g.doom_one_plugin_neogit = true
          vim.g.doom_one_plugin_nvim_tree = true
          vim.g.doom_one_plugin_dashboard = false
          vim.g.doom_one_plugin_startify = false
          vim.g.doom_one_plugin_whichkey = true
          vim.g.doom_one_plugin_indent_blankline = true
          vim.g.doom_one_plugin_vim_illuminate = false
          vim.g.doom_one_plugin_lspsaga = false
        '';
      }
    ];

    colorscheme = "doom-one";

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
