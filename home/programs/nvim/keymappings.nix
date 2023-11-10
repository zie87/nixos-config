{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    keymaps = [
      { mode = ["n" "v"]; key = "<Space>"; action = "<Nop>"; options = { silent = true; }; }

      # better up/down
      { mode = ["n" "x"]; key = "j";      action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
      { mode = ["n" "x"]; key = "k";      action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }
      { mode = ["n" "x"]; key = "<Down>"; action = "v:count == 0 ? 'gj' : 'j'"; options = { expr = true; silent = true; }; }
      { mode = ["n" "x"]; key = "<Up>";   action = "v:count == 0 ? 'gk' : 'k'"; options = { expr = true; silent = true; }; }

      # Move to window using the <ctrl> hjkl keys
      { mode = ["n"]; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Go to left window";  remap = true; }; }
      { mode = ["n"]; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Go to lower window"; remap = true; }; }
      { mode = ["n"]; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Go to upper window"; remap = true; }; }
      { mode = ["n"]; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Go to right window"; remap = true; }; }

      # Resize window using <ctrl> arrow keys
      { mode = ["n"]; key = "<C-Up>";    action = "<cmd>resize +2<cr>";          options = { desc = "Increase window height"; }; }
      { mode = ["n"]; key = "<C-Down>";  action = "<cmd>resize -2<cr>";          options = { desc = "Decrease window height"; }; }
      { mode = ["n"]; key = "<C-Left>";  action = "<cmd>vertical resize -2<cr>"; options = { desc = "Decrease window width";  }; }
      { mode = ["n"]; key = "<C-Right>"; action = "<cmd>vertical resize +2<cr>"; options = { desc = "Increase window width";  }; }

      # Move Lines
      { mode = ["n"]; key = "<A-j>"; action = "<cmd>m .+1<cr>==";        options = { desc = "Move down"; }; }
      { mode = ["n"]; key = "<A-k>"; action = "<cmd>m .-2<cr>==";        options = { desc = "Move up";   }; }
      { mode = ["i"]; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; options = { desc = "Move down"; }; }
      { mode = ["i"]; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; options = { desc = "Move up";   }; }
      { mode = ["v"]; key = "<A-j>"; action = ":m '>+1<cr>gv=gv";        options = { desc = "Move down"; }; }
      { mode = ["v"]; key = "<A-k>"; action = ":m '<-2<cr>gv=gv";        options = { desc = "Move up";   }; }

      # buffers
      { mode = ["n"]; key = "<S-h>";      action = "<cmd>bprevious<cr>"; options = { desc = "Prev buffer"; }; }
      { mode = ["n"]; key = "<S-l>";      action = "<cmd>bnext<cr>";     options = { desc = "Next buffer"; }; }
      { mode = ["n"]; key = "[b";         action = "<cmd>bprevious<cr>"; options = { desc = "Prev buffer"; }; }
      { mode = ["n"]; key = "]b";         action = "<cmd>bnext<cr>";     options = { desc = "Next buffer"; }; }
      { mode = ["n"]; key = "<leader>bb"; action = "<cmd>e #<cr>";       options = { desc = "Switch to Other Buffer"; }; }
      { mode = ["n"]; key = "<leader>`";  action = "<cmd>e #<cr>";       options = { desc = "Switch to Other Buffer"; }; }

      # Clear search with <esc>
      { mode = ["i" "n"]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; options = { desc = "Escape and clear hlsearch"; }; }

      # Clear search, diff update and redraw (taken from runtime/lua/_editor.lua)
      { mode = ["n"]; key ="<leader>ur"; action ="<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"; options = { desc = "Redraw / clear hlsearch / diff update"; }; }

      # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      { mode = ["n"]; key = "n"; action = "'Nn'[v:searchforward].'zv'"; options ={ expr = true; desc = "Next search result"; }; }
      { mode = ["x"]; key = "n"; action = "'Nn'[v:searchforward]";      options ={ expr = true; desc = "Next search result"; }; }
      { mode = ["o"]; key = "n"; action = "'Nn'[v:searchforward]";      options ={ expr = true; desc = "Next search result"; }; }
      { mode = ["n"]; key = "N"; action = "'nN'[v:searchforward].'zv'"; options ={ expr = true; desc = "Prev search result"; }; }
      { mode = ["x"]; key = "N"; action = "'nN'[v:searchforward]";      options ={ expr = true; desc = "Prev search result"; }; }
      { mode = ["o"]; key = "N"; action = "'nN'[v:searchforward]";      options ={ expr = true; desc = "Prev search result"; }; }

      # Add undo break-points
      { mode = ["i"]; key =  ","; action = ",<c-g>u"; }
      { mode = ["i"]; key =  "."; action = ".<c-g>u"; }
      { mode = ["i"]; key =  ";"; action = ";<c-g>u"; }

      # save file
      { mode = ["i" "x" "n" "s"]; key = "<C-s>"; action = "<cmd>w<cr><esc>"; options = { desc = "Save file"; }; }

      # keywordprg
      { mode = ["n"]; key = "<leader>K"; action = "<cmd>norm! K<cr>"; options = { desc = "Keywordprg"; }; }

      # better indenting
      { mode = ["v"]; key = "<"; action = "<gv"; }
      { mode = ["v"]; key = ">"; action = ">gv"; }

      # Terminal Mappings
      { mode = ["t"]; key = "<esc><esc>"; action = "<c-\\><c-n>"; options = { desc = "Enter Normal Mode"; }; }
      { mode = ["t"]; key = "<C-h>"; action ="<cmd>wincmd h<cr>"; options = { desc = "Go to left window";  }; }
      { mode = ["t"]; key = "<C-j>"; action ="<cmd>wincmd j<cr>"; options = { desc = "Go to lower window"; }; }
      { mode = ["t"]; key = "<C-k>"; action ="<cmd>wincmd k<cr>"; options = { desc = "Go to upper window"; }; }
      { mode = ["t"]; key = "<C-l>"; action ="<cmd>wincmd l<cr>"; options = { desc = "Go to right window"; }; }
      { mode = ["t"]; key = "<C-/>"; action ="<cmd>close<cr>"; options = { desc = "Hide Terminal"; }; }
      { mode = ["t"]; key = "<c-_>"; action ="<cmd>close<cr>"; options = { desc = "which_key_ignore"; }; }

      # windows
      { mode = ["n"]; key = "<leader>ww"; action ="<C-W>p"; options = { desc = "Other window";       remap = true; }; }
      { mode = ["n"]; key = "<leader>wd"; action ="<C-W>c"; options = { desc = "Delete window";      remap = true; }; }
      { mode = ["n"]; key = "<leader>w-"; action ="<C-W>s"; options = { desc = "Split window below"; remap = true; }; }
      { mode = ["n"]; key = "<leader>w|"; action ="<C-W>v"; options = { desc = "Split window right"; remap = true; }; }
      { mode = ["n"]; key = "<leader>-";  action ="<C-W>s"; options = { desc = "Split window below"; remap = true; }; }
      { mode = ["n"]; key = "<leader>|";  action ="<C-W>v"; options = { desc = "Split window right"; remap = true; }; }

      # tabs
      { mode = ["n"]; key = "<leader><tab>l";     action = "<cmd>tablast<cr>";     options = { desc = "Last Tab";    }; }
      { mode = ["n"]; key = "<leader><tab>f";     action = "<cmd>tabfirst<cr>";    options = { desc = "First Tab";   }; }
      { mode = ["n"]; key = "<leader><tab><tab>"; action = "<cmd>tabnew<cr>";      options = { desc = "New Tab";     }; }
      { mode = ["n"]; key = "<leader><tab>]";     action = "<cmd>tabnext<cr>";     options = { desc = "Next Tab";    }; }
      { mode = ["n"]; key = "<leader><tab>d";     action = "<cmd>tabclose<cr>";    options = { desc = "Close Tab";   }; }
      { mode = ["n"]; key = "<leader><tab>[";     action = "<cmd>tabprevious<cr>"; options = { desc = "Previous Tab";}; }

      # new file
      { mode = ["n"]; key = "<leader>fn"; action = "<cmd>enew<cr>"; options = { desc = "New File"; }; }

      { mode = ["n"]; key = "<leader>xl"; action = "<cmd>lopen<cr>"; options = { desc = "Location List"; }; }
      { mode = ["n"]; key = "<leader>xq"; action = "<cmd>copen<cr>"; options = { desc = "Quickfix List"; }; }

      { mode = ["n"]; key = "[q"; action = "vim.cmd.cprev"; lua = true; options = { desc = "Previous quickfix"; }; }
      { mode = ["n"]; key = "]q"; action = "vim.cmd.cnext"; lua = true; options = { desc = "Next quickfix"; }; }

      # quit
      { mode = ["n"]; key = "<leader>qq"; action = "<cmd>qa<cr>"; options = { desc = "Quit all"; }; }

      # highlights under cursor
      { mode = ["n"]; key = "<leader>ui"; action = "vim.show_pos"; lua = true; options = { desc = "Inspect Pos"; }; }
    ];
  };
}
