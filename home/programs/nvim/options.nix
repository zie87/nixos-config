{
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2

      # disable netrw at the very start of your init.lua
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;

      mapleader = "-";
      mapLocalleader = "#";
    };

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    options = {
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|

      hlsearch = false; # Set highlight on search 

      number = true; # Display the absolute line number of the current line
      mouse = "a"; # Enable mouse control

      breakindent = true; # Enable break indent
      undofile = true; # Automatically save and restore undo history

      # Case-insensitive searching UNLESS \C or capital in search
      ignorecase = true; # When the search query is lower-case, match both lower and upper-case patterns
      smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper case characters

      # Decrease update time
      updatetime = 250;
      timeoutlen = 300;

      signcolumn = "yes"; # Whether to show the signcolumn
      cursorline = true;      # enable highlighting of the current line
      colorcolumn = "80,120"; # line width markers

      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one
    };
  };
}
