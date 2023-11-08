{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    keymaps = [
      {
        mode = ["n" "v"];
        key = "<Space>";
        action = "<Nop>";
        options = {
          silent = true;
        };
      }
      {
        mode = "n";
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        mode = "n";
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }
    ];
  };
}
