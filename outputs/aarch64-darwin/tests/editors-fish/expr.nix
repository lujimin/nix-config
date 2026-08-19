{
  lib,
  myvars,
  outputs,
  ...
}:
let
  darwinConfig = outputs.darwinConfigurations.digital-world.config;
  homeConfig = darwinConfig.home-manager.users.${myvars.username};
  homePackageNames = map lib.getName homeConfig.home.packages;
in
{
  homeStateVersion = homeConfig.home.stateVersion;

  editors = {
    helix = homeConfig.programs.helix.enable;
    nixvim = homeConfig.programs.nixvim.enable;
    nixfmt = lib.any (package: lib.getName package == "nixfmt") darwinConfig.environment.systemPackages;
    tuiPackages = lib.genAttrs [
      "nixd"
      "taplo"
      "marksman"
      "python3"
      "rustc"
      "go"
      "nodejs"
    ] (package: lib.elem package homePackageNames);
    inherit (homeConfig.home.sessionVariables) EDITOR SUDO_EDITOR VISUAL;
  };

  gui = {
    appManagement = {
      copyApps = homeConfig.targets.darwin.copyApps.enable;
      linkApps = homeConfig.targets.darwin.linkApps.enable;
    };
    terminals = {
      kitty = {
        enable = homeConfig.programs.kitty.enable;
        packageManaged = homeConfig.programs.kitty.package != null;
      };
      alacritty = homeConfig.programs.alacritty.enable;
      ghostty = homeConfig.programs.ghostty.enable;
      foot = homeConfig.programs.foot.enable;
    };
    zed = homeConfig.programs.zed-editor.enable;
    mediaPackages = lib.genAttrs [
      "ffmpeg-full"
      "imagemagick"
      "graphviz"
      "viu"
    ] (package: lib.elem package homePackageNames);
    agentPackages = lib.genAttrs [
      "codex"
      "claude-code"
      "opencode"
      "herdr"
    ] (package: lib.elem package homePackageNames);
    excludedAgents = lib.genAttrs [
      "cursor-cli"
      "kimi-code"
      "rtk"
    ] (package: !(lib.elem package homePackageNames));
  };

  zellij = {
    inherit (homeConfig.programs.zellij) enable;
    alias = homeConfig.programs.fish.shellAliases.zj;
    configManaged = homeConfig.xdg.configFile."zellij/config.kdl".source != null;
    nushell = {
      enable = homeConfig.programs.nushell.enable;
      autoStart = lib.hasInfix "^zellij" homeConfig.programs.nushell.extraConfig;
      customCompletions =
        lib.all (completion: lib.hasInfix completion homeConfig.programs.nushell.extraConfig)
          [
            "custom-completions/git/git-completions.nu"
            "custom-completions/just/just-completions.nu"
            "custom-completions/nix/nix-completions.nu"
            "custom-completions/ssh/ssh-completions.nu"
          ];
      unsafeWorkConfigCommented =
        lib.all (line: lib.hasInfix line homeConfig.programs.nushell.extraConfig)
          [
            "# source /etc/agenix/alias-for-work.nushell"
            "# $env.ANTHROPIC_BASE_URL = $env.WORK_ANTHROPIC_BASE_URL"
            "# $env.ANTHROPIC_AUTH_TOKEN = $env.WORK_ANTHROPIC_AUTH_TOKEN"
            "# use modules/kubernetes *"
          ];
    };
  };

  packageManagers = {
    npm = homeConfig.home.file.".npmrc".text;
    pnpm = homeConfig.xdg.configFile."pnpm/config.yaml".text;
    pip = homeConfig.xdg.configFile."pip/pip.conf".text;
    uv = homeConfig.xdg.configFile."uv/uv.toml".text;
  };

  fish = {
    inherit (homeConfig.programs.fish) enable;
    atuinIntegration = homeConfig.programs.atuin.enableFishIntegration;
    homebrewCompletionsEnabled =
      lib.all (path: lib.hasInfix path homeConfig.programs.fish.interactiveShellInit)
        [
          "/opt/homebrew/share/fish/completions"
          "/opt/homebrew/share/fish/vendor_completions.d"
        ];
    aliases = {
      inherit (homeConfig.programs.fish.shellAliases)
        k
        urldecode
        urlencode
        vi
        vim
        ;
    };
    sessionPath = homeConfig.home.sessionPath;
  };
}
