{
  myvars,
  lib,
}:
let
  username = myvars.username;
  hosts = [ "digital-world" ];
in
lib.genAttrs hosts (_: "/Users/${username}")
