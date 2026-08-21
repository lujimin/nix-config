{
  lib,
  pkgs,
  ...
}:
###########################################################
#
# Kitty Configuration
#
# Useful Hot Keys for Linux(replace `ctrl + shift` with `cmd` on macOS)):
#   1. Increase Font Size: `ctrl + shift + =` | `ctrl + shift + +`
#   2. Decrease Font Size: `ctrl + shift + -` | `ctrl + shift + _`
#   3. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
###########################################################
{
  programs.kitty = {
    enable = true;
    font = {
      name = "Maple Mono NF CN";
      # use different font size on macOS
      size = 13;
    };

    # consistent with other terminal emulators
    keybindings = {
      "ctrl+shift+m" = "toggle_maximized";
      "ctrl+shift+f" = "show_scrollback"; # search in the current window
    };

    settings = {
      # Keep Linux behavior unchanged while showing the native traffic-light
      # controls on macOS.
      hide_window_decorations =
        if pkgs.stdenv.hostPlatform.isDarwin then "no" else "titlebar-and-corners";
      macos_titlebar_color = "background";
      macos_show_window_title_in = "none";

      background_opacity = "0.93";
      background_blur = 1; # requires kitty >= 0.46.2 and compositor support (e.g. niri v26.04+)
      macos_option_as_alt = true; # Option key acts as Alt on macOS
      #  To resolve issues:
      #    1. https://github.com/ryan4yin/nix-config/issues/26
      #    2. https://github.com/ryan4yin/nix-config/issues/8
      #  Spawn a nushell in login mode via `bash`
      shell = "${pkgs.bash}/bin/bash --login -c 'nu --login --interactive'";
    };
  };
}
