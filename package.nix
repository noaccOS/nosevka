{ iosevka, ... }:
let
  privateBuildPlan = {
    exportGlyphNames = true;
    family = "Nosevka";
    ligations.inherits = "dlig";
    noCvSs = false;
    serifs = "sans";
    spacing = "normal";
    variants = {
      # JetBrains Mono
      inherits = "ss14";
      design = {
        a = "double-storey-serifed";
        at = "threefold";
        b = "toothless-rounded-serifless";
        capital-x = "curly-serifless";
        dollar = "slanted-interrupted";
        f = "tailed";
        g = "double-storey-open";
        i = "tailed-serifed";
        micro-sign = "tailed-serifed";
        n = "earless-corner-tailed-serifless";
        p = "earless-corner-serifless";
        q = "earless-corner-diagonal-tailed-serifless";
        x = "semi-chancery-straight-serifless";
      };
    };
    widths.Normal = {
      css = "normal";
      menu = 5;
      shape = 600;
    };
  };
in
iosevka.override {
  set = "nosevka";
  inherit privateBuildPlan;
}
