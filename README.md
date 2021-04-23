[![CI](https://github.com/twlz0ne/nix-gccemacs-darwin/workflows/CI/badge.svg)](https://github.com/twlz0ne/nix-gccemacs-darwin/actions?query=workflow%3ACI)

# nix-gccemacs-darwin

Build gccemacs for macOS 10.15 or newer using Nix.

## Installation

- Build on local machine

    ``` sh
    git clone https://github.com/twlz0ne/nix-gccemacs-darwin
    cd nix-gccemacs-darwin && nix-env -iA emacsGccDarwin -f default.nix
    ```

- Pull pre-built binaries from Cachix (recommend)

    ``` sh
    nix-env -iA cachix -f https://cachix.org/api/v1/install
    cachix use gccemacs-darwin
    nix-env -iA emacsGccDarwin -f https://github.com/twlz0ne/nix-gccemacs-darwin/archive/master.zip
    ```

For macOS 10.12 see [nix-gccemacs-sierra](https://github.com/twlz0ne/nix-gccemacs-sierra).

## Usage 
Launch emacs from your `nix-env`

``` sh
emacs </dev/null &>/dev/null &
```
