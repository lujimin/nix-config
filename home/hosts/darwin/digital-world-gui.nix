{
  llm-agents,
  pkgs,
  ...
}:
let
  agents = llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Keep the upstream GUI profile, but install only the GUI and AI tools used on this host.
  home.packages =
    (with pkgs; [
      aerospace
      jankyborders
    ])
    ++ (with agents; [
      codex
      claude-code
      opencode
      herdr
    ]);
}
