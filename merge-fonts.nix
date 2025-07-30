{
  fonts ? [ ],
  runCommandNoCC,
  ripgrep,
  sd,
  ...
}:
let
  inherit (builtins) toString;
in
runCommandNoCC "nosevka-complete" { buildInputs = [ ripgrep sd  ]; } ''
  mkdir -p $out/share/fonts/truetype

  for font in ${toString fonts}; do
    familyname=$(echo $font | rg '/nix/store/[^\-]*\-(.*)(\-[\d\.]+)?' --only-matching  -r '$1')
    for fontfile in $font/share/fonts/truetype/*; do
      name=$(basename $fontfile | sd '^[^-]+' "$familyname")
      out_name="$out/share/fonts/truetype/$name"
      cp --update=none-fail "$fontfile" "$out_name"
    done
  done
''
