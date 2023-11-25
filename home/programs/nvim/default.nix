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

    
    zie-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "zie";
      src = ./config/nvim;
    };
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
	nvim-treesitter.withAllGrammars
	
	plenary-nvim
        popup-nvim
        telescope-nvim

	neorg

    	doom-one-nvim
	headlines-nvim
	zie-nvim
    ];

    extraConfig = ''
      lua << EOF
        require 'zie'.init()
      EOF
    '';
  };
}
