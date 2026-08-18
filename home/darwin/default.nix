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
  imports = (mylib.scanPaths ./.) ++ [
    ../base/core
    ../base/tui
    ../base/gui
    ../base/home.nix
  ];

  # enable management of XDG base directories on macOS.
  xdg.enable = true;
}
