{
  myvars,
  outputs,
  ...
}:
let
  darwinConfig = outputs.darwinConfigurations.digital-world.config;
  homeConfig = darwinConfig.home-manager.users.${myvars.username};
in
{
  home = {
    inherit (homeConfig.nix) enable package;
  };

  system = {
    inherit (darwinConfig.determinateNix) enable;
    nixDarwinEnable = darwinConfig.nix.enable;
    customSettings = {
      inherit (darwinConfig.determinateNix.customSettings)
        auto-optimise-store
        builders-use-substitutes
        extra-substituters
        extra-trusted-public-keys
        trusted-users
        ;
    };
    garbageCollectorStrategy = darwinConfig.determinateNix.determinateNixd.garbageCollector.strategy;
  };
}
