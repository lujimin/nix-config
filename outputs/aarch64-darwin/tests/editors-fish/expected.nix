{ myvars, ... }:
let
  homeDirectory = "/Users/${myvars.username}";
in
{
  editors = {
    helix = true;
    nixvim = false;
    nixfmt = true;
    tuiPackages = {
      nixd = true;
      taplo = true;
      marksman = true;
      python3 = true;
      rustc = true;
      go = true;
      nodejs = true;
    };
    EDITOR = "hx";
    SUDO_EDITOR = "nvim --clean";
    VISUAL = "hx";
  };

  zellij = {
    enable = true;
    alias = "zellij";
    configManaged = true;
    nushell = {
      enable = true;
      autoStart = true;
    };
  };

  packageManagers = {
    npm = ''
      prefix=/Users/${myvars.username}/.npm
      min-release-age=2
    '';
    pnpm = ''
      minimumReleaseAge: 2880
    '';
    pip = ''
      [global]
      index-url = https://mirrors.bfsu.edu.cn/pypi/web/simple

      [install]
      uploaded-prior-to = P2D
    '';
    uv = ''
      exclude-newer = "2 days"
    '';
  };

  fish = {
    enable = true;
    atuinIntegration = false;
    homebrewCompletionsEnabled = true;
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
