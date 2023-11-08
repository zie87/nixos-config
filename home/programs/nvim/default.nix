{
  config,
  pkgs,
  inputs,
  ...
}: {
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

  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nil # nix lsp
      alejandra # nix formatter
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      plenary-nvim
      {
        # Fuzzy Finder (files, lsp, etc)
        plugin = telescope-nvim;
      }
      # Fuzzy Finder Algorithm
      telescope-fzf-native-nvim
      telescope-file-browser-nvim

      {
        plugin = which-key-nvim;
      }

      #Detect tabstop and shiftwidth automatically
      vim-sleuth

      # Additional lua configuration, makes nvim stuff amazing!
      neodev-nvim

      # LSP Configuration & Plugins
      # The configuration is done below. Search for lspconfig to find it below.
      nvim-lspconfig
      {
        # Useful status updates for LSP
        plugin = fidget-nvim;
        config = toLua ''
          require('fidget').setup()
        '';
      }
      none-ls-nvim

      #  Highlight, edit, and navigate code
      nvim-treesitter-textobjects
      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-c
          p.tree-sitter-cpp
          p.tree-sitter-doxygen
          p.tree-sitter-rust
          p.tree-sitter-ada
          p.tree-sitter-zig
          p.tree-sitter-arduino

          p.tree-sitter-lua
          p.tree-sitter-luadoc
          p.tree-sitter-fennel

          p.tree-sitter-nix
          p.tree-sitter-elixir

          p.tree-sitter-vim
          p.tree-sitter-vimdoc

          p.tree-sitter-bash
          p.tree-sitter-python
          p.tree-sitter-ruby

          p.tree-sitter-devicetree
          p.tree-sitter-dtd
          p.tree-sitter-kconfig
          p.tree-sitter-dockerfile

          p.tree-sitter-make
          p.tree-sitter-ninja
          p.tree-sitter-meson
          p.tree-sitter-cmake

          p.tree-sitter-gitignore
          p.tree-sitter-gitcommit
          p.tree-sitter-gitattributes
          p.tree-sitter-git_config
          p.tree-sitter-git_rebase

          p.tree-sitter-json
          p.tree-sitter-jsonc
          p.tree-sitter-ini
          p.tree-sitter-css
          p.tree-sitter-rst
          p.tree-sitter-markdown
          p.tree-sitter-markdown_inline
          p.tree-sitter-norg
        ]);
      }

      {
        plugin = trouble-nvim;
        config = toLua ''
          require('trouble').setup()
        '';
      }

      # Autocompletion
      nvim-cmp
      # Snippet Engine & its associated nvim-cmp source
      luasnip
      cmp_luasnip
      # Adds LSP completion capabilities
      cmp-nvim-lsp
      # Adds a number of user-friendly snippets
      friendly-snippets

      {
        # "gc" to comment visual regions/lines
        plugin = comment-nvim;
        config = toLua ''
          require('Comment').setup()
        '';
      }

      #   vim-nix

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

          vim.cmd.colorscheme 'doom-one'
        '';
      }
      {
        plugin = lualine-nvim;
        config = toLua ''
          require('lualine').setup {
            options = {
              icons_enable = true,
              theme = 'auto',
              -- component_separators = '|',
              -- section_separators = "";
            },
          }
        '';
      }
      rainbow-delimiters-nvim
      {
        plugin = indent-blankline-nvim;
        config = toLua ''
          require('ibl').setup()
        '';
      }
      {
        plugin = nvim-tree-lua;
        config = toLua ''
          require('nvim-tree').setup()
        '';
      }
      {
        plugin = nvim-colorizer-lua;
        config = toLua ''
          require('colorizer').setup()
        '';
      }
      neorg
      headlines-nvim
    ];

    extraLuaConfig = ''
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Set '-' as the leader key
      -- See `:help mapleader`
      --  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
      vim.g.mapleader = '-'
      vim.g.maplocalleader = '#'

      -- NOTE: You should make sure your terminal supports this
      vim.o.termguicolors = true

      vim.cmd ":command! WQ wq"
      vim.cmd ":command! Wq wq"
      vim.cmd ":command! Wqa wqa"
      vim.cmd ":command! W w"
      vim.cmd ":command! Q q"
      vim.cmd ":command! Qa qa"


      -- [[ Setting options ]]
      -- See `:help vim.o`

      -- Set highlight on search
      vim.o.hlsearch = false

      -- Make line numbers default
      vim.wo.number = true

      -- Enable mouse mode
      vim.o.mouse = 'a'

      -- Sync clipboard between OS and Neovim.
      --  Remove this option if you want your OS clipboard to remain independent.
      --  See `:help 'clipboard'`
      vim.o.clipboard = 'unnamedplus'

      -- Enable break indent
      vim.o.breakindent = true

      -- Save undo history
      vim.o.undofile = true

      -- Case-insensitive searching UNLESS \C or capital in search
      vim.o.ignorecase = true
      vim.o.smartcase = true

      -- Keep signcolumn on by default
      vim.wo.signcolumn = 'yes'

      -- Decrease update time
      vim.o.updatetime = 250
      vim.o.timeoutlen = 300

      -- Set completeopt to have a better completion experience
      vim.o.completeopt = 'menuone,noselect'


      vim.o.splitbelow = true       -- put new windows below current
      vim.o.splitright = true       -- put new windows right of current

      vim.wo.cursorline = true      -- enable highlighting of the current line
      vim.wo.colorcolumn = "80,120" -- line wisth markers

      -- [[ Basic Keymaps ]]

      -- Keymaps for better default experience
      -- See `:help vim.keymap.set()`
      vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

      -- Remap for dealing with word wrap
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

      -- [[ Highlight on yank ]]
      -- See `:help vim.highlight.on_yank()`
      local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
      })


      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'file_browser')

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', "<leader>sr", '<cmd>Telescope file_browser<CR>', { desc = 'File Browser' })

      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup {
          ensure_installed = {},
          -- ignore_install = { 'haskell', 'javascript' },
          -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
          auto_install = false,

          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = '<c-space>',
              node_incremental = '<c-space>',
              scope_incremental = '<c-s>',
              node_decremental = '<M-space>',
            },
          },
          textobjects = {
            select = {
              enable = true,
              lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
              keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true, -- whether to set jumps in the jumplist
              goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
              },
              goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
              },
              goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
              },
              goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
              },
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>a'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>A'] = '@parameter.inner',
              },
            },
          },
        }
      end, 0)

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


      vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Toogle trouble window" })
      vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
        { desc = "Open Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
        { desc = "Open Document Diagnostics" })
      vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = "Open Quickfix" })
      vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = "Open LocList" })

      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })
      end

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      require('lspconfig').lua_ls.setup {
          on_attach = on_attach,
          capabilities = capabilities,
      	  root_dir = function()
                return vim.loop.cwd()
            end,
      	  cmd = { "lua-lsp" },
          settings = {
              Lua = {
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
              },
          }
      }
      require('lspconfig').nil_ls.setup{
          on_attach = on_attach,
          capabilities = capabilities,
      }

      -- [[ Configure auto format]]
      -- Switch for controlling whether you want autoformatting.
      --  Use :KickstartFormatToggle to toggle autoformatting on or off
      local format_is_enabled = true
      vim.api.nvim_create_user_command('KickstartFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == 'tsserver' then
            return
          end

          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          local opts = { noremap = true, silent = true, desc = "[F]ormat current buffer" }
          buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", opts)

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })

      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }

      -- [[ Configure Neorg ]]
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.summary"] = {}, -- Allows summary generation
          ["core.qol.toc"] = {
            config = {
              close_after_use = true,
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Workspace/private/notes",
              },
              default_workspace = "notes",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = { extensions = "all" },
          },
          ["core.neorgcmd.commands.module.list"] = {},
        },
      }
      require("headlines").setup({
          norg = {
              headline_highlights = {"Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6"},
              codeblock_highlight = {"NeorgCodeBlock"},
          }
      })


      -- [[ Configure WhichKey ]]
      -- document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Diagnostics', _ = 'which_key_ignore' },
      }
    '';
  };
}
