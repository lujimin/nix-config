{
  pkgs,
  myvars,
  ...
}:
{
  # Determinate Nix owns the daemon and Nix installation.  nix-darwin must not
  # try to replace or manage it.
  nix.enable = false;

  nix.settings.auto-optimise-store = false;
  nix.gc.automatic = false;

  system = {
    primaryUser = myvars.username;
    stateVersion = 5;
  };

  users.users.${myvars.username}.home = "/Users/${myvars.username}";

  # Keep the first generation small while providing the tools used by this
  # repository's normal deployment workflow.
  environment.systemPackages = with pkgs; [
    git
    just
    nushell
  ];

  programs = {
    # Keep zsh available as the macOS fallback shell and configure Fish because
    # it is this user's current login shell.
    zsh.enable = true;
    fish.enable = true;
  };
}
