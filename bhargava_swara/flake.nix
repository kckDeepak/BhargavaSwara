{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";  # Or use a specific commit
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";  # Adjust if you're on a different architecture
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; }; # Allow unfree packages if necessary.

  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        python311
        python311Packages.pip
        python311Packages.flask
        python311Packages.google-generativeai
      ];
      shellHook = ''
        export PIP_PREFIX=$(pwd)/_pip_packages
        export PYTHONPATH="$PIP_PREFIX/lib/python3.11/site-packages:$PYTHONPATH"
        unset SOURCE_DATE_EPOCH
      '';
    };
  };
}