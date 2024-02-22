{
  config,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.adoptopenjdk-icedtea-web  # for javaws
    pkgs.jdk                       # for complete java environment
  ];
}
