{
  mylib,
  ...
}:
{
  # Import the upstream Darwin Home Manager profile as the source of truth.
  imports = [ (mylib.relativeToRoot "home/darwin") ];

  # Start conservatively: these upstream modules either contain Ryan-specific
  # data, may replace existing dotfiles, or install a large desktop profile.
  # Remove one entry at a time to enable and test it.
  disabledModules = map mylib.relativeToRoot [
    "home/base/core/editors" # Neovim and Helix configuration
    "home/base/core/npm.nix" # Existing ~/.npmrc may conflict
    "home/base/core/pip.nix" # Changes Python package indexes
    "home/base/core/shells" # Bash and Nushell configuration
    "home/base/core/zellij" # Zellij configuration
    "home/base/tui" # Private SSH, GPG, work, and development settings
    "home/base/gui" # Large GUI and terminal profile
    "home/darwin/aerospace" # Out-of-store Aerospace configuration link
    "home/darwin/proxy" # Proxy tools and configuration
    "home/darwin/rime-squirrel.nix" # Force-replaces ~/Library/Rime
    "home/darwin/shell.nix" # Zsh and Miniforge initialization
    "home/darwin/terminal.nix" # Terminal-specific font overrides
  ];

  programs = {
    home-manager.enable = true;
    fish.enable = true;

    # The upstream profile primarily targets Bash, Zsh, and Nushell. Keep its
    # core tools integrated with this host's Fish login shell.
    atuin.enableFishIntegration = true;
    eza.enableFishIntegration = true;
    fzf.enableFishIntegration = true;
    starship.enableFishIntegration = true;
    yazi.enableFishIntegration = true;
    zoxide.enableFishIntegration = true;

    # Preserve the credential-manager settings from this Mac's previous
    # ~/.gitconfig while the shared Git module manages the rest.
    git.settings.credential = {
      helper = [
        ""
        "/usr/local/share/gcm-core/git-credential-manager"
      ];
      "https://codeup.aliyun.com".provider = "generic";
      "https://dev.azure.com".useHttpPath = true;
    };
  };
}
