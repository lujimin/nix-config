{
  inputs,
  lib,
  mylib,
  myvars,
  system,
  genSpecialArgs,
  ...
}@args:
let
  name = "MacBook-Pro-16";

  modules = {
    darwin-modules = map mylib.relativeToRoot [
      "modules/darwin/bootstrap.nix"
      "hosts/darwin-${name}"
    ];

    # Home Manager is intentionally disabled for the first deployment.
    home-modules = [ ];
  };

  systemArgs = modules // args;
in
{
  darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
