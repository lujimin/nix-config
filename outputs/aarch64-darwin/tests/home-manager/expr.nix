{
  myvars,
  lib,
  outputs,
}:
let
  username = myvars.username;
  # Home Manager is intentionally disabled for the bootstrap host.
  hosts = [ ];
in
lib.genAttrs hosts (
  name: outputs.darwinConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
)
