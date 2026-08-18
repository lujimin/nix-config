{
  myvars,
  lib,
}:
let
  username = myvars.username;
  hosts = [
    "MacBook-Pro-16"
    "digital-world"
  ];
in
lib.genAttrs hosts (_: "/Users/${username}")
