# nix-build -E 'with import <nixpkgs> {}; callPackage ./qkd/default.nix {}'
nix-build -E 'with import <nixpkgs> {}; callPackage ./ipcrs/default.nix {}'
