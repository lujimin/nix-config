{
  myvars,
  lib,
}:
let
  username = myvars.username;
  # Home Manager is intentionally disabled for the bootstrap host.
  hosts = [ ];
in
lib.genAttrs hosts (_: "/Users/${username}")
