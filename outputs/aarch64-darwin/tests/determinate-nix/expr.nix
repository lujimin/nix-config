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
  inherit (homeConfig.nix) enable package;
}
