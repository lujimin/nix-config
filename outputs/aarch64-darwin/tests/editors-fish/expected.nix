{ myvars, ... }:
let
  homeDirectory = "/Users/${myvars.username}";
in
{
  editors = {
    helix = true;
    nixvim = false;
    EDITOR = "hx";
    SUDO_EDITOR = "nvim --clean";
    VISUAL = "hx";
  };

  fish = {
    enable = true;
    aliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      vi = "nvim";
      vim = "nvim";
    };
    sessionPath = [
      "${homeDirectory}/.local/bin"
      "${homeDirectory}/go/bin"
      "${homeDirectory}/.cargo/bin"
      "${homeDirectory}/.npm/bin"
    ];
  };
}
