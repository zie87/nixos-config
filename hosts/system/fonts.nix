{pkgs, ...}: {
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "RobotoMono"
        "Monofur"
      ];
    })
    roboto
    font-awesome
  ];
}
