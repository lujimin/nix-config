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

  # Register the stable system-profile path as a valid macOS login shell.
  environment.shells = [ pkgs.fish ];

  # Keep the existing Apple Silicon Homebrew installation available before
  # user shell configuration is evaluated.
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # nix-darwin intentionally does not manage properties of an existing admin
  # account.  Keep only the login shell in sync without taking ownership of or
  # recreating the macOS user.
  system.activationScripts.postActivation.text = ''
    desiredShell="/run/current-system/sw/bin/fish"
    currentShell=$(/usr/bin/dscl . -read "/Users/${myvars.username}" UserShell | /usr/bin/awk '{ print $2 }')

    if [ "$currentShell" != "$desiredShell" ]; then
      echo "setting login shell for ${myvars.username} to $desiredShell..." >&2
      /usr/bin/dscl . -create "/Users/${myvars.username}" UserShell "$desiredShell"
    fi
  '';

  # Provide the tools used by this repository's normal deployment workflow.
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
