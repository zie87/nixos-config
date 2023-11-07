{pkgs, ...}: let
  gitConfig = {
    core = {
      editor = "nvim";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    pull.rebase = true;
    push.autoSetupRemote = false;
  };
in {
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy   # git diff with colors
    hub             # github command-line client
    tig             # diff and commit view
  ];

  programs.git =
    {
      enable = true;
      aliases = {
        amend = "commit --amend -m";
        fixup = "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
        ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
        ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      };
      extraConfig = gitConfig;
      userEmail = "zie.develop@gmail.com";
      userName = "Tobias Zindl";
    };
}
