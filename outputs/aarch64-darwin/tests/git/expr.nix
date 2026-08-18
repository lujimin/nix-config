{
  myvars,
  outputs,
  ...
}:
let
  git =
    outputs.darwinConfigurations.digital-world.config.home-manager.users.${myvars.username}.programs.git;
in
{
  inherit (git) enable;

  identity = {
    inherit (git.settings.user) email name;
  };

  credential = {
    inherit (git.settings.credential) helper;
    codeupProvider = git.settings.credential."https://codeup.aliyun.com".provider;
    azureUseHttpPath = git.settings.credential."https://dev.azure.com".useHttpPath;
  };

  hasRyanRewrite = (git.settings.url or { }) ? "ssh://git@github.com/ryan4yin";
  unsafeSafeDirectory = git.settings.safe.directory or null;
}
