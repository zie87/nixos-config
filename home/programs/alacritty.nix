{ ... }: 
let
  fontFamily = "Monofur Nerd Font Mono";
  fontSize = 11;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = fontFamily;
          style = "Medium";
        };
        bold = {
          family = fontFamily;
          style = "Bold";
        };
        italic = {
          family = fontFamily;
          style = "Italic";
        };
        size = fontSize;
      };
      colors = {
        primary = {
          background = "#282c34";
          foreground = "#bbc2cf";
        };
        cursor = {
          text = "#282c34";
          cursor = "#51afef";
        };
        vi_mode_cursor = {
          text = "#282c34";
          cursor = "#51afef";
        };
        selection = {
          background = "#2257a0";
        };  
        normal = {
          black   = "#282c34";
          red     = "#ff6c6b";
          green   = "#98be65";
          yellow  = "#ecbe7b";
          blue    = "#51afef";
          magenta = "#a9a1e1";
          cyan    = "#46d9ff";
          white   = "#bbc2cf";
        };

        # Bright colors
        bright = {
          black   = "#3f444a";
          red     = "#ff6c6b";
          green   = "#98be65";
          yellow  = "#da8548";
          blue    = "#51afef";
          magenta = "#a9a1e1";
          cyan    = "#46d9ff";
          white   = "#efefef";
        };
      };
    };
  };
}
