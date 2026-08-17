{
  myvars,
  lib,
}:
let
  username = myvars.username;
  hosts = [ "MacBook-Pro-16" ];
in
lib.genAttrs hosts (_: "/Users/${username}")
