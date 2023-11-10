{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
      };
    };

    keymaps = [
      { mode = ["n"]; key = "<leader>,"; action ="<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>"; options = { desc = "Switch Buffer"; }; }
      { mode = ["n"]; key = "<leader>/"; action = "require('telescope.builtin').live_grep"; lua = true; options = { desc = "Grep (root dir)"; }; }
      { mode = ["n"]; key = "<leader>:"; action = "<cmd>Telescope command_history<cr>"; options = { desc = "Command History"; }; }
      { mode = ["n"]; key = "<leader><space>"; action = "require('telescope.builtin').find_files"; lua = true; options = { desc = "Find Files (root dir)"; }; }
      # find
      { mode = ["n"]; key = "<leader>fb"; action = "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>"; options = { desc ="Buffers"; }; }
      #{ mode = ["n"]; key = "<leader>fc"; action = "require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })"; lua = true; options = { desc ="Find Config File"; }; }
      { mode = ["n"]; key = "<leader>ff"; action = "require('telescope.builtin').find_files"; lua = true; options = { desc ="Find Files (root dir)"; }; }
      #{ mode = ["n"]; key = "<leader>fF"; action = "require('telescope.builtin').find_files({ cwd = false })"; lua = true; options = { desc ="Find Files (cwd)"; }; }
      { mode = ["n"]; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<cr>"; options = { desc ="Recent"; }; }
      # { mode = ["n"]; key = "<leader>fR"; action = "require('telescope.builtin').oldfiles({ cwd = vim.loop.cwd() })"; lua = true; options = { desc ="Recent (cwd)"; }; }
      # git
      { mode = ["n"]; key = "<leader>gc"; action = "<cmd>Telescope git_commits<CR>"; options = { desc ="commits"; }; }
      { mode = ["n"]; key = "<leader>gs"; action = "<cmd>Telescope git_status<CR>"; options = { desc ="status"; }; }
      # search
      { mode = ["n"]; key = ''<leader>s"''; action = "<cmd>Telescope registers<cr>"; options = { desc ="Registers"; }; }
      { mode = ["n"]; key = "<leader>sa";   action = "<cmd>Telescope autocommands<cr>"; options = { desc ="Auto Commands"; }; }
      { mode = ["n"]; key = "<leader>sb";   action = "<cmd>Telescope current_buffer_fuzzy_find<cr>"; options = { desc ="Buffer"; }; }
      { mode = ["n"]; key = "<leader>sc";   action = "<cmd>Telescope command_history<cr>"; options = { desc ="Command History"; }; }
      { mode = ["n"]; key = "<leader>sC";   action = "<cmd>Telescope commands<cr>"; options = { desc ="Commands"; }; }
      { mode = ["n"]; key = "<leader>sd";   action = "<cmd>Telescope diagnostics bufnr=0<cr>"; options = { desc ="Document diagnostics"; }; }
      { mode = ["n"]; key = "<leader>sD";   action = "<cmd>Telescope diagnostics<cr>"; options = { desc ="Workspace diagnostics"; }; }
      { mode = ["n"]; key = "<leader>sg";   action = "require('telescope.builtin').live_grep"; options = { desc ="Grep (root dir)"; }; }
      # { mode = ["n"]; key = "<leader>sG", Util.telescope("live_grep", { cwd = false }); options = { desc ="Grep (cwd)"; }; }
      { mode = ["n"]; key = "<leader>sh"; action = "<cmd>Telescope help_tags<cr>"; options = { desc ="Help Pages"; }; }
      { mode = ["n"]; key = "<leader>sH"; action = "<cmd>Telescope highlights<cr>"; options = { desc ="Search Highlight Groups"; }; }
      { mode = ["n"]; key = "<leader>sk"; action = "<cmd>Telescope keymaps<cr>"; options = { desc ="Key Maps"; }; }
      { mode = ["n"]; key = "<leader>sM"; action = "<cmd>Telescope man_pages<cr>"; options = { desc ="Man Pages"; }; }
      { mode = ["n"]; key = "<leader>sm"; action = "<cmd>Telescope marks<cr>"; options = { desc ="Jump to Mark"; }; }
      { mode = ["n"]; key = "<leader>so"; action = "<cmd>Telescope vim_options<cr>"; options = { desc ="Options"; }; }
      { mode = ["n"]; key = "<leader>sR"; action = "<cmd>Telescope resume<cr>"; options = { desc ="Resume"; }; }
#      { mode = ["n"]; key = "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }); options = { desc ="Word (root dir)"; }; }
#      { mode = ["n"]; key = "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }); options = { desc ="Word (cwd)"; }; }
#      { mode = ["n"]; key = "<leader>sw", Util.telescope("grep_string"), mode = "v"; options = { desc ="Selection (root dir)"; }; }
#      { mode = ["n"]; key = "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v"; options = { desc ="Selection (cwd)"; }; }
#      { mode = ["n"]; key = "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }); options = { desc ="Colorscheme with preview"; }; }
#      {
#        "<leader>ss",
#        function()
#          require("telescope.builtin").lsp_document_symbols({
#            symbols = require("lazyvim.config").get_kind_filter(),
#          })
#        end,
#        desc = "Goto Symbol",
#      },
#      {
#        "<leader>sS",
#        function()
#          require("telescope.builtin").lsp_dynamic_workspace_symbols({
#            symbols = require("lazyvim.config").get_kind_filter(),
#          })
#        end,
#        desc = "Goto Symbol (Workspace)",
#      },
    ];
  };
}
