with import <nixpkgs> {} ;
let

in
mkShell {
  buildInputs = [
    (haskellPackages.ghcWithPackages ( p: 
      [ p.xmonad
      ]
    ))
  ];
}
