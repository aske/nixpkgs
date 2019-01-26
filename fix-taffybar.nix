self: super: 

{
  haskellPackages = super.haskellPackages.override {
    overrides = hself: hsuper: rec {
      taffybar = self.haskell.lib.overrideCabal hsuper.taffybar (_: {
         src = self.fetchFromGitHub {
           owner = "taffybar";
           repo = "taffybar";
           rev = "e382599358bb06383ba4b08d469fc093c11f5915";
           sha256 = "0qncwpfz0v2b6nbdf7qgzl93kb30yxznkfk49awrz8ms3pq6vq6g";
         };
      });
      buildHaskellPackages = hsuper.buildHaskellPackages // { inherit taffybar; };
    };
  };
}
