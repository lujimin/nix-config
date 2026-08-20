{
  mylib,
  myvars,
  ...
}:
{
  home.homeDirectory = "/Users/${myvars.username}";

  # Determinate Nix owns the installation and its nix.conf on macOS.
  # Keep Home Manager from installing a second, upstream Nix implementation.
  nix.enable = false;

  # Fish enables this by default for completion generation, but Home Manager
  # 26.05 intentionally uses the native man implementation on Darwin.
  programs.man.generateCaches = false;

  # Home Manager's generated option manual currently triggers the same Nix
  # store-context warning as nix-darwin's generated option manual.
  manual.manpages.enable = false;

  imports = (mylib.scanPaths ./.) ++ [
    ../base/core
    ../base/tui
    ../base/gui
    ../base/home.nix
  ];

  # enable management of XDG base directories on macOS.
  xdg.enable = true;
}
