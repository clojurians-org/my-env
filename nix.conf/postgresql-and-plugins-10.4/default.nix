{ stdenv, fetchFromGitHub, pkgs, postgresql, ... }:
pkgs.buildEnv rec {
  name = "postgresql-and-plugins-10.4";
  paths = [ postgresql postgresql.lib pkgs.postgis pkgs.pgjwt pkgs.pgtap pkgs.pg_cron ] ;
  buildInputs = [ pkgs.makeWrapper ];
  postBuild =
    ''
      mkdir -p $out/bin
      rm $out/bin/{pg_config,postgres,pg_ctl}
      cp --target-directory=$out/bin ${postgresql}/bin/{postgres,pg_config,pg_ctl}
      wrapProgram $out/bin/postgres --set NIX_PGLIBDIR $out/lib
    '';
}
