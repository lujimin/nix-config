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

  modules = {
    darwin-modules =
      (map mylib.relativeToRoot [
        "modules/darwin"
        "hosts/darwin-${name}"
      ])
      ++ [
        {
          modules.desktop.fonts.enable = true;
        }
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
