{ config, lib, pkgs, ... }:
let
  cfg = config.host.home.applications.postgres;
in
with lib;
{
  options = {
    host.home.applications.postgres = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = "Postgres db";
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      postgres = {
        enable = true;
        package = pkgs.postgresql_16;
        ensureDatabases = [ "mydatabase" ];
        authentication = pkgs.lib.mkOverride 10 ''
          #type database  DBuser  auth-method
          local all       all     trust
        '';
      };
    };
  };
}
