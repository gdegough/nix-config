{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.kdePackages.kaccounts-providers
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.kdepim-runtime
    pkgs.kdePackages.kmail-account-wizard
    # pkgs.kdePackages.knotes # stable 24.05
    pkgs.kdePackages.kongress
    pkgs.kdePackages.kontact
    pkgs.kdePackages.skanpage
    pkgs.kdePackages.zanshin
  ];
}
