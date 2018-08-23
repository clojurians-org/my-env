{ fetchgit, stdenv, readline, zlib, perl, bison, flex, ... }:
stdenv.mkDerivation rec {
  name = "postgres-xl-${version}" ;
  version = "10.0" ;
  rev = "0e7174157b7762959089ab0dd508237679a301c8" ;

  buildInputs = [ readline zlib perl bison flex ];

  src = fetchgit {
    url= "git://git.postgresql.org/git/postgres-xl.git" ;
    rev = rev ;
    sha256 = "0nv8s4wyswfikb6pbmj9mq6qr8j7vc1d9nhkr6jmnymfkx4rwjxk" ;
  } ;
}

