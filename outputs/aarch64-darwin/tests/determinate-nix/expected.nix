{ myvars, ... }:
{
  home = {
    enable = false;
    package = null;
  };

  system = {
    enable = true;
    nixDarwinEnable = false;
    customSettings = {
      trusted-users = [
        "root"
        myvars.username
      ];
      extra-substituters = [
        "https://cache.numtide.com"
        "https://nix-community.cachix.org"
        "https://catppuccin.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
      builders-use-substitutes = true;
      auto-optimise-store = false;
    };
    garbageCollectorStrategy = "disabled";
  };
}
