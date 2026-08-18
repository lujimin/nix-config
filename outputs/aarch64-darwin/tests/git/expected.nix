{ myvars, ... }:
{
  enable = true;

  identity = {
    email = myvars.useremail;
    name = myvars.userfullname;
  };

  credential = {
    helper = [
      ""
      "/usr/local/share/gcm-core/git-credential-manager"
    ];
    codeupProvider = "generic";
    azureUseHttpPath = true;
  };

  hasRyanRewrite = false;
  unsafeSafeDirectory = null;
}
