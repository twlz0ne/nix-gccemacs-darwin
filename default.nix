let
  sources = import ./nix/sources.nix;
  nixpkgs = sources."nixpkgs-unstable";
  pkgs = import nixpkgs {};
  emacs-nativecomp = sources."emacs-nativecomp";
  libPath = with pkgs; lib.concatStringsSep ":" [
    "${lib.getLib libgccjit}/lib/gcc/${stdenv.targetPlatform.config}/${libgccjit.version}"
    "${lib.getLib stdenv.cc.cc}/lib"
    "${lib.getLib stdenv.glibc}/lib"
  ];
  emacsGcc = builtins.foldl' (drv: fn: fn drv)
    pkgs.emacs
    [

      (drv: drv.override { srcRepo = true; })

      (
        drv: drv.overrideAttrs (
          old: {
            name = "emacsGcc";
            version = "28.0.50";
            src = pkgs.fetchFromGitHub {
              inherit (emacs-nativecomp) owner repo rev sha256;
            };

            configureFlags = old.configureFlags
            ++ [ "--with-ns" ];

            patches = [
              (
                pkgs.fetchpatch {
                  name = "clean-env.patch";
                  url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/clean-env.patch";
                  sha256 = "0lx9062iinxccrqmmfvpb85r2kwfpzvpjq8wy8875hvpm15gp1s5";
                }
              )
              (
                pkgs.fetchpatch {
                  name = "tramp-detect-wrapped-gvfsd.patch";
                  url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/tramp-detect-wrapped-gvfsd.patch";
                  sha256 = "19nywajnkxjabxnwyp8rgkialyhdpdpy26mxx6ryfl9ddx890rnc";
                }
              )
            ];

            postPatch = old.postPatch + ''
              substituteInPlace lisp/loadup.el \
              --replace '(emacs-repository-get-version)' '"${emacs-nativecomp.rev}"' \
              --replace '(emacs-repository-get-branch)' '"master"'
            '';

          }
        )
      )
      (
        drv: drv.override {
          nativeComp = true;
        }
      )
    ];
in
_: _:
  {
    ci = (import ./nix {}).ci;

    inherit emacsGcc;

    emacsGccWrapped = pkgs.symlinkJoin {
      name = "emacsGccWrapped";
      paths = [ emacsGcc ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/emacs \
        --set LIBRARY_PATH ${libPath}
      '';
      meta.platforms = pkgs.stdenv.lib.platforms.linux;
      passthru.nativeComp = true;
      src = emacsGcc.src;
    };
  }
