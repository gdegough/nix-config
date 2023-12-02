{
  inputs,
  config,
  pkgs,
  ...
}: 
{
  # Mutation of users outside of the config?
  users.mutableUsers = false;
}
