{
  lib,
  inputs,
  ...
}@args:
let
  inherit (inputs) haumea;

  # Keep upstream host definitions in their original paths so future merges
  # remain straightforward, but only expose hosts managed by this fork.
  enabledHosts = [ "MacBook-Pro-16" ];
  allData = haumea.lib.load {
    src = ./src;
    inputs = args;
  };
  data = lib.getAttrs enabledHosts allData;

  # nix file names is redundant, so we remove it.
  dataWithoutPaths = builtins.attrValues data;

  # Merge all the machine's data into a single attribute set.
  outputs = {
    darwinConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.darwinConfigurations or { }) dataWithoutPaths
    );
  };
in
outputs
// {
  inherit data; # for debugging purposes

  # NixOS's unit tests.
  evalTests = haumea.lib.loadEvalTests {
    src = ./tests;
    inputs = args // {
      inherit outputs;
    };
  };
}
