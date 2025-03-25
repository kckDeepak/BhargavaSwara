{
  pkgs ? import <nixpkgs> {}
}:
pkgs.mkShell {
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
}