{ myvars, ... }:
let
  homeDirectory = "/Users/${myvars.username}";
in
{
  homeStateVersion = "26.05";

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

  gui = {
    appManagement = {
      copyApps = true;
      linkApps = false;
    };
    terminals = {
      kitty = {
        enable = true;
        packageManaged = true;
      };
      alacritty = false;
      ghostty = false;
      foot = false;
    };
    zed = true;
    mediaPackages = {
      ffmpeg-full = true;
      imagemagick = true;
      graphviz = true;
      viu = true;
    };
    agentPackages = {
      codex = true;
      claude-code = true;
      opencode = true;
      herdr = true;
    };
    excludedAgents = {
      cursor-cli = true;
      kimi-code = true;
      rtk = true;
    };
  };

  zellij = {
    enable = true;
    alias = "zellij";
    configManaged = true;
    nushell = {
      enable = true;
      autoStart = true;
      customCompletions = true;
      unsafeWorkConfigCommented = true;
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

  warningFixes = {
    catppuccinGemini = false;
    manGenerateCaches = false;
    homeManagerManual = false;
    atuinNushellIntegration = true;
    fzfNushellHistory = "";
    darwinDocumentation = false;
    darwinMan = true;
    darwinInfo = true;
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
