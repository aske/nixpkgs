self: super: 

{
  haskellPackages = super.haskellPackages.override {
    overrides = hself: hsuper: rec {
      status-notifier-item = self.haskell.lib.overrideCabal hsuper.status-notifier-item (_: {
        patches = [
          ./status-notifier-1.patch
        ];
      });

      gtk2hs-buildtools = self.haskell.lib.overrideCabal hsuper.gtk2hs-buildtools (_: {
        patches = [
          ./gtk2hs-buildtools-ghc-8.6.1.patch
        ];
      });

      taffybar = self.haskell.lib.overrideCabal hsuper.taffybar (_: {
        patches = [
          ./taffybar-1.patch
        ];
      });
      buildHaskellPackages = hsuper.buildHaskellPackages // { inherit gtk2hs-buildtools status-notifier-item taffybar; };
    };
  };
}
