let
  sources = import ./nix/sources.nix;
  nixpkgs = sources."nixpkgs-unstable";
  emacs-overlay = import ./default.nix;
  pkgs = import nixpkgs { config = {}; overlays = [ emacs-overlay ]; };
in
{
  emacsGcc = pkgs.emacsGcc;
  emacsGccWrapped = pkgs.emacsGccWrapped;
}
