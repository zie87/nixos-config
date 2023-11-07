{ ... }: 
let
  fontFamily = "Monofur Nerd Font Mono";
  fontSize = "11";

  background = "282c34";
  foreground = "bbc2cf";
  cursor = "51afef";

  normal = {
    black   = "282c34";
    red     = "ff6c6b";
    green   = "98be65";
    yellow  = "ecbe7b";
    blue    = "51afef";
    magenta = "a9a1e1";
    cyan    = "46d9ff";
    white   = "bbc2cf";
  };

  bright = {
    black   = "3f444a";
    red     = "ff6c6b";
    green   = "98be65";
    yellow  = "da8548";
    blue    = "51afef";
    magenta = "a9a1e1";
    cyan    = "46d9ff";
    white   = "efefef";
  };

in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font="${fontFamily}:size=${fontSize}";
      };
      
      cursor = {
        style="block";
        color="${background} ${cursor}";
        blink="yes";
      };

      colors = {
        # alpha=1.0
        background=background;
        foreground=foreground;
        
        ## Normal/regular colors (color palette 0-7)
        regular0=normal.black;
        regular1=normal.red;
        regular2=normal.green;
        regular3=normal.yellow;
        regular4=normal.blue;
        regular5=normal.magenta;
        regular6=normal.cyan;
        regular7=normal.white;
        
        ## Bright colors (color palette 8-15)
        bright0=bright.black;
        bright1=bright.red;
        bright2=bright.green;
        bright3=bright.yellow;
        bright4=bright.blue;
        bright5=bright.magenta;
        bright6=bright.cyan;
        bright7=bright.white;
        
        ## Misc colors
        selection-foreground=foreground;
        selection-background=background;
      };  
    };
  };
}
