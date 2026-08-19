{
  config,
  myvars,
  ...
}:
{
  ###################################################################################
  #
  #  Core configuration for nix-darwin
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #
  # History Issues:
  #  1. Fixed by replace the determined nix-installer by the official one:
  #     https://github.com/LnL7/nix-darwin/issues/149#issuecomment-1741720259
  #
  ###################################################################################

  # The official Determinate module keeps nix-darwin from managing the Nix
  # installation and writes these settings to /etc/nix/nix.custom.conf.
  determinateNix = {
    enable = true;
    customSettings = {
      # Allow this user to accept flake-provided caches without the restricted
      # setting warnings emitted by the Nix daemon.
      trusted-users = [
        "root"
        myvars.username
      ];

      # Append project caches to Determinate's cache.nixos.org and installer
      # caches instead of replacing its defaults.
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

      # Disable auto-optimise-store because of:
      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = false;
    };

    determinateNixd.garbageCollector.strategy = "disabled";
  };

  system.stateVersion = 5;

  # Disabled until this fork has its own agenix-managed access token file.
  # nix.extraOptions = ''
  #   !include ${config.age.secrets.nix-access-tokens.path}
  # '';
}
