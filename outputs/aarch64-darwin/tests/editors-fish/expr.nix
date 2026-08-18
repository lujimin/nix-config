{
  myvars,
  outputs,
  ...
}:
let
  homeConfig =
    outputs.darwinConfigurations.digital-world.config.home-manager.users.${myvars.username};
in
{
  editors = {
    helix = homeConfig.programs.helix.enable;
    nixvim = homeConfig.programs.nixvim.enable;
    inherit (homeConfig.home.sessionVariables) EDITOR SUDO_EDITOR VISUAL;
  };

  fish = {
    inherit (homeConfig.programs.fish) enable;
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
