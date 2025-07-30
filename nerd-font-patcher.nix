{
  font,
  font-patcher,
  mono-variant ? false,
  fontforge,
  runCommandNoCC,
  fd,
  ...
}:
let
  name = if mono-variant then "nosevka-nerd-fonts-mono" else "nosevka-nerd-fonts";
in
runCommandNoCC name
  {
    buildInputs = [
      fontforge
      fd
    ];
  }
  ''
    mkdir -p $out
    cp -r ${font}/share/fonts .
    chmod 777 -R fonts


    fd --extension ttf . fonts/truetype -x \
      fontforge -script ${font-patcher}/font-patcher \
        ${if mono-variant then "--mono" else ""} \
        --outputdir $out/share/fonts/truetype/ \
        --no-progressbar \
        --makegroup 5 \
        --complete
  ''
