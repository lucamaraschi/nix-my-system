{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];

  homebrew = {
    enable = true;
    casks  = [
      "1password"
      "adobe-creative-cloud"
      "discord"
      "dozer"
      "figma"
      "github"
      "google-chrome"
      "hammerspoon"
      "imageoptim"
      "istat-menus"
      "kitty"
      "microsoft-office"
      "miro"
      "monodraw"
      "notion"
      "notion-calendar"
      "orbstack"
      "protonvpn"
      "raycast"
      "rectangle"
      "signal"
      "slack"
      "spotify"
      "telegram"
      "virtualbuddy"
      "visual-studio-code"
      "vivaldi"
      "vmware-fusion"
      "zoom"
    ];
    masApps = {
      Tailscale = 1475387142;
      Xcode = 497799835;
    }
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.batman = {
    home = "/Users/batman";
    shell = pkgs.fish;
  };
}
