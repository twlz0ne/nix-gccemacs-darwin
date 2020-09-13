let
  sources = import ./nix/sources.nix;
  nixpkgs = sources."nixpkgs-unstable";
  emacs-overlay = import ./emacs.nix;
  pkgs = import nixpkgs { config = {}; overlays = [ emacs-overlay ]; };
in
{
  emacsGccDarwin = pkgs.emacsGccDarwin;
  emacsGccDarwinWrapped = pkgs.emacsGccDarwinWrapped;
}
