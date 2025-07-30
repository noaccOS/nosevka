{
  font-patcher-zip,
  runCommandNoCC,
  unzip,
  ...
}:
runCommandNoCC "font-patcher" { buildInputs = [ unzip ]; } ''
  mkdir -p $out
  unzip ${font-patcher-zip} -d $out
''
