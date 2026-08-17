{
  pkgs,
  myvars,
  ...
}:
{
  home = {
    username = myvars.username;
    homeDirectory = "/Users/${myvars.username}";

    # Preserve the compatibility baseline used by this repository.
    stateVersion = "24.11";

    packages = with pkgs; [
      ripgrep
      fd
      jq
    ];
  };

  programs.home-manager.enable = true;
}
