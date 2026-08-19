{
  lib,
  myvars,
  outputs,
  ...
}:
let
  darwinConfig = outputs.darwinConfigurations.digital-world.config;
  homeConfig = darwinConfig.home-manager.users.${myvars.username};
in
{
  editors = {
    helix = homeConfig.programs.helix.enable;
    nixvim = homeConfig.programs.nixvim.enable;
    nixfmt = lib.any (package: lib.getName package == "nixfmt") darwinConfig.environment.systemPackages;
    inherit (homeConfig.home.sessionVariables) EDITOR SUDO_EDITOR VISUAL;
  };

  zellij = {
    inherit (homeConfig.programs.zellij) enable;
    alias = homeConfig.programs.fish.shellAliases.zj;
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
