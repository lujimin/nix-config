{
  myvars,
  lib,
  outputs,
}:
let
  username = myvars.username;
  hosts = [
    "MacBook-Pro-16"
    "digital-world"
  ];
in
lib.genAttrs hosts (
  name: outputs.darwinConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
)
