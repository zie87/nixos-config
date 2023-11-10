{
  programs.nixvim = {
    # file explorer
    plugins.neo-tree = {
      enable = true;
      sources = ["filesystem" "buffers" "git_status" "document_symbols"];
      extraOptions = {
        open_files_do_not_replace_types = ["terminal" "Trouble" "trouble" "qf" "Outline"];
        filesystem = {
          bind_to_cwd = false;
          follow_current_file = { enabled = true; };
          use_libuv_file_watcher = true;
        };
        window = {
          mappings = {
            "<space>" = "none";
          };
        };
        default_component_configs = {
          indent = {
            with_expanders = true; # if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "";
            expander_expanded = "";
            expander_highlight = "NeoTreeExpander";
          };
        };
      }; 
    };

    keymaps = [
      { 
        mode = ["n"]; key = "<leader>fe"; action = ''
        function()
          require("neo-tree.command").execute({ toggle = true })
        end
        ''; lua = true; options = { desc = "Explorer NeoTree (root dir)"; }; 
      }
      { 
        mode = ["n"]; key = "<leader>fE"; action = ''
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end
        ''; lua = true; options = { desc = "Explorer NeoTree (cwd)"; }; 
      }
      { mode = ["n"]; key = "<leader>e"; action = "<leader>fe"; options = { desc = "Explorer NeoTree (root dir)"; remap = true; }; }
      { mode = ["n"]; key = "<leader>E"; action = "<leader>fE"; options = { desc = "Explorer NeoTree (cwd)"; remap = true; }; }
      {
        mode = ["n"]; key = "<leader>ge"; action = ''
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end
        ''; lua = true; options = { desc = "Git explorer"; }; 
      }
      {
        mode = ["n"]; key = "<leader>be"; action = ''
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end
        ''; lua = true; options = { desc = "Buffer explorer"; };
      }
    ];
  };
}
