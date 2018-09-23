{ stdenv, fetchFromGitHub, pkgs, postgresql, ... }:
let mysql_fdw = stdenv.mkDerivation rec {
  name = "mysql_fdw-${version}";
  version = "2.4";

  buildInputs = [ postgresql pkgs.mysql ];

  src = fetchFromGitHub {
    owner  = "EnterpriseDB";
    repo   = "mysql_fdw";
    rev = "6d436e01266a0e04d7b4c9a4a5558b7da1284684" ;
    sha256 = "1i4xcyd4cs0rpx79ll8x41pv28xqwaydfg34y162b3wybxfp96sk";
  };

  buildPhase = ''
    sed -i 's,^PG_CPPFLAGS +=.*,PG_CPPFLAGS += -D _MYSQL_LIBNAME=\\"${pkgs.mysql}/lib/libmysqlclient$(DLSUFFIX)\\",' Makefile
    make USE_PGXS=1
  '';

  installPhase = ''
    mkdir -p $out/{lib,share/extension}
    cp *.so      $out/lib
    cp *.sql     $out/share/extension
    cp *.control $out/share/extension
  '';
} ;
in
  pkgs.buildEnv rec {
    name = "postgresql-and-plugins-10.4";
    paths = [ postgresql postgresql.lib pkgs.postgis pkgs.pgjwt pkgs.pgtap pkgs.pg_cron mysql_fdw ] ;
    buildInputs = [ pkgs.makeWrapper ];
    postBuild =
      ''
        mkdir -p $out/bin
        rm $out/bin/{pg_config,postgres,pg_ctl}
        cp --target-directory=$out/bin ${postgresql}/bin/{postgres,pg_config,pg_ctl}
        wrapProgram $out/bin/postgres --set NIX_PGLIBDIR $out/lib
      '';
  }
