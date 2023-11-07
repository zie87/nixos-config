{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignorespace"];
    historyIgnore = ["cd" "exit"];
    sessionVariables = {
      MANROFFOPT="-c"; # avoids formatting issues
      MANPAGER="sh -c 'col -bx | bat -l man -p'";

      DOTNET_CLI_TELEMETRY_OPTOUT=1;
    };
    shellAliases = {
      cp="cp -i";
      mv="mv -i";
      rm="rm -i";
      
      ls="ls --color";
      la="ls --color -A";
      ll="ls --color -al";
      
      els="eza --icons";
      ell="eza --icons --long --header --git --git-ignore";
      ela="eza --icons --long --header --git --all";
      
      grep="grep --color=auto";
      fgrep="fgrep --color=auto";
      egrep="egrep --color=auto";
    };
  };
}
