{ stdenv, fetchFromGitHub, pkgs, postgresql, ... }:
let 
mysql_fdw = stdenv.mkDerivation rec {
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
oracle_fdw = stdenv.mkDerivation rec {
  name = "oracle_fdw-${version}" ;
  version = "2.0.0" ;

  buildInputs = [ postgresql pkgs.oracle-instantclient ];

  src = fetchFromGitHub {
    owner = "laurenz" ;
    repo = "oracle_fdw" ;
    rev = "9c00b4a222184419a2fc9d6b5fc26c5367162930" ;
    sha256 = "076dx35284lnsbmmpirxsqa93hr4w1lj3cgccz1i5d0xb1ylgyas" ;
  } ;

  buildPhase = ''
    export ORACLE_HOME=${pkgs.oracle-instantclient}
    export OCI_LIB_DIR=$ORACLE_HOME/lib
    export OCI_INC_DIR=$ORACLE_HOME/include
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
    paths = [ postgresql postgresql.lib pkgs.postgis pkgs.pgjwt pkgs.pgtap pkgs.pg_cron mysql_fdw oracle_fdw ] ;
    buildInputs = [ pkgs.makeWrapper ];
    postBuild =
      ''
        mkdir -p $out/bin
        rm $out/bin/{pg_config,postgres,pg_ctl}
        cp --target-directory=$out/bin ${postgresql}/bin/{postgres,pg_config,pg_ctl}
        wrapProgram $out/bin/postgres --set NIX_PGLIBDIR $out/lib
      '';
  }
