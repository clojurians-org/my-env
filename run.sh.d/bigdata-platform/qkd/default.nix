{ fetchzip, maven, jdk, makeWrapper, stdenv, ... }:
stdenv.mkDerivation rec {
  name = "shrbank-qkd-${version}";
  version = "1.0.0";
  rev = "1d88acd1edd78f2e907e38f00308264cb7c17267" ;

  src = fetchzip {
    url= "http://10.132.37.56/kangminghui/qkd/repository/archive.tar.gz?ref=${rev}";
    sha256 = "11ncahfnn6ljy2ra6nbszb8kfng5s72q6zfx3svhc0bs4063v595" ;
  } ;

  # This is adapted from https://github.com/volth/nixpkgs/blob/6aa470dfd57cae46758b62010a93c5ff115215d7/pkgs/applications/networking/cluster/hadoop/default.nix#L20-L32
  fetchedMavenDeps = stdenv.mkDerivation {
    name = "shrbank-qkd-${version}-maven-deps";
    inherit src nativeBuildInputs;
    buildPhase = ''
      while timeout --kill-after=21m 20m mvn package -Dmaven.repo.local=$out/.m2; [ $? = 124 ]; do
        echo "maven hangs while downloading :("
      done
    '';
    installPhase = ''find $out/.m2 -type f \! -regex '.+\(pom\|jar\|xml\|sha1\)' -delete''; # delete files with lastModified timestamps inside
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = "00r69n9hwvrn5cbhxklx7w00sjmqvcxs7gvhbm150ggy7bc865qv";
  };

  # The purpose of this is to fetch the jar file out of public Maven and use Maven
  # to build a monolithic, standalone jar, rather than build everything from source
  # (given the state of Maven support in Nix). We're not actually building any java
  # source here.
  nativeBuildInputs = [ maven ];
  buildInputs = [ makeWrapper ];
  buildPhase = ''
      mvn package --offline -Dmaven.repo.local=$(cp -dpR ${fetchedMavenDeps}/.m2 ./ && chmod +w -R .m2 && pwd)/.m2
  '';
  meta = with stdenv.lib; {
    homepage = http://10.132.37.56/kangminghui/qkd ;
    description = "qkd" ;
    license = licenses.asl20;
    platforms = platforms.unix;
  };

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/java
    mv target/$name.jar $out/share/java/
    makeWrapper ${jdk}/bin/java $out/bin/start-shrbank-qkd.sh --add-flags "-jar $out/share/java/$name.jar" --suffix PATH : ${stdenv.lib.makeBinPath [ jdk ]}
  '';
}
