{
  mylib,
  myvars,
  pkgs,
  ...
}:
let
  hostname = "digital-world";
  computerName = "digital world";
in
{
  # These upstream modules are intentionally disabled for the first rollout.
  # Remove one entry at a time after reviewing and adapting that module.
  disabledModules = map mylib.relativeToRoot [
    "modules/darwin/apps.nix" # Homebrew packages and cleanup policy
    "modules/darwin/security.nix" # GPG agent and sshd policy
    "modules/darwin/system.nix" # macOS defaults and keyboard mappings
  ];

  networking.hostName = hostname;
  networking.computerName = computerName;

  system = {
    primaryUser = myvars.username;
    defaults.smb.NetBIOSName = hostname;
  };

  users.users.${myvars.username}.home = "/Users/${myvars.username}";

  # Keep the existing Apple Silicon Homebrew installation available without
  # letting nix-darwin manage its packages yet.
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  # Register Fish as a valid shell and keep the existing macOS account's login
  # shell in sync. nix-darwin does not manage properties of existing admins.
  environment.shells = [ pkgs.fish ];
  system.activationScripts.postActivation.text = ''
    desiredShell="/run/current-system/sw/bin/fish"
    currentShell=$(/usr/bin/dscl . -read "/Users/${myvars.username}" UserShell | /usr/bin/awk '{ print $2 }')

    if [ "$currentShell" != "$desiredShell" ]; then
      echo "setting login shell for ${myvars.username} to $desiredShell..." >&2
      /usr/bin/dscl . -create "/Users/${myvars.username}" UserShell "$desiredShell"
    fi
  '';

  programs = {
    fish.enable = true;
    zsh.enable = true;
  };
}
