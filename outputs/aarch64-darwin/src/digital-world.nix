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
  name = "digital-world";
  legacyName = "MacBook-Pro-16";

  modules = {
    darwin-modules = map mylib.relativeToRoot [
      "modules/darwin"
      "hosts/darwin-${name}"
    ];

    home-modules = map mylib.relativeToRoot [
      "home/hosts/darwin/darwin-${name}.nix"
    ];
  };

  systemArgs = modules // args;
  configuration = mylib.macosSystem systemArgs;
in
{
  # Keep the old output as a one-deployment bridge: `just local` selects the
  # output using the machine's current hostname. Remove it after switching.
  darwinConfigurations = {
    ${name} = configuration;
    ${legacyName} = configuration;
  };
}
