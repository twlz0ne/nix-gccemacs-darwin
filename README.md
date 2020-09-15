[![Build Status](https://travis-ci.com/twlz0ne/nix-gccemacs-darwin.svg?branch=master)](https://travis-ci.com/twlz0ne/nix-gccemacs-darwin)

# nix-gccemacs-darwin

Build gccemacs for macOS 10.15 or newer using Nix.

## Installation

- Build on local machine

    ``` sh
    git clone https://github.com/twlz0ne/nix-gccemacs-darwin
    cd nix-gccemacs-darwin && nix-env -iA emacsGccDarwin
    ```

- Pull pre-built binaries from Cachix (recommend)

    ``` sh
    nix-env -iA cachix -f https://cachix.org/api/v1/install
    cachix use gccemacs-darwin
    nix-env -iA emacsGccDarwin -f https://github.com/twlz0ne/nix-gccemacs-darwin/archive/master.zip
    ```

## Create symlink

``` sh
ln -snf $(nix path-info $(which emacs))/{lib/emacs/28.0.50/native-lisp,bin/native-lisp}
```

---

For macOS 10.12 see [nix-gccemacs-sierra](https://github.com/twlz0ne/nix-gccemacs-sierra).
