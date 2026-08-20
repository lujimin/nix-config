{
  config,
  mylib,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
in
{
  # Import the upstream Darwin Home Manager profile as the source of truth,
  # then selectively enable modules from otherwise disabled aggregate profiles.
  imports = map mylib.relativeToRoot [
    "home/darwin"
    "home/base/gui/terminal/kitty.nix"
    "home/base/tui/editors"
    "home/base/tui/encryption"
    "home/base/tui/shell"
    "home/base/tui/zellij"
    "home/hosts/darwin/digital-world-gui.nix"
  ];

  # Start conservatively: these upstream modules either contain Ryan-specific
  # data, may replace existing dotfiles, or install a large desktop profile.
  # Remove one entry at a time to enable and test it.
  disabledModules = map mylib.relativeToRoot [
    "home/base/core/shells" # Bash and Nushell configuration
    "home/base/tui" # Private SSH, GPG, work, and development settings
    "home/base/gui/dev-tools.nix" # Replaced by a host-specific AI tool selection
    "home/base/gui/terminal" # Enable only Kitty instead of every terminal
    "home/darwin/aerospace" # Out-of-store Aerospace configuration link
    "home/darwin/proxy" # Proxy tools and configuration
    "home/darwin/rime-squirrel.nix" # Force-replaces ~/Library/Rime
    "home/darwin/shell.nix" # Zsh and Miniforge initialization
    "home/darwin/terminal.nix" # Terminal-specific font overrides
  ];

  # Fish equivalent of the reusable user paths from home/base/core/shells.
  # Keep the upstream Bash/Nushell module disabled until those shells are wanted.
  home.sessionPath = [
    "${homeDirectory}/.local/bin"
    "${homeDirectory}/go/bin"
    "${homeDirectory}/.cargo/bin"
    "${homeDirectory}/.npm/bin"
  ];

  programs = {
    home-manager.enable = true;
    nushell.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        # Homebrew installs Fish completions outside Fish's default search path.
        # Use fixed host paths so shell startup does not need to execute `brew --prefix`.
        for completionDir in \
          /opt/homebrew/share/fish/completions \
          /opt/homebrew/share/fish/vendor_completions.d
          if test -d $completionDir; and not contains -- $completionDir $fish_complete_path
            set --prepend fish_complete_path $completionDir
          end
        end
      '';
      shellAliases = {
        k = "kubectl";
        urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
        urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
      };
    };

    # The upstream profile primarily targets Bash, Zsh, and Nushell. Keep its
    # core tools integrated with this host's Fish login shell.
    atuin.enableFishIntegration = false;
    fzf = {
      enableFishIntegration = true;
      # Atuin owns Ctrl-R in Nushell; FZF remains available through its command
      # and keeps its other shell bindings.
      historyWidget.nushell.command = "";
    };
    eza.enableFishIntegration = true;
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
