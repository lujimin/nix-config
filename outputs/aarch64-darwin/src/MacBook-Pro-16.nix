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

    home-modules = map mylib.relativeToRoot [
      "home/hosts/darwin/darwin-${name}.nix"
    ];
  };

  systemArgs = modules // args;
in
{
  darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
