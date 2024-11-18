{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix { inherit inputs; })
  ];

  homebrew = {
    enable = true;

    brews = [
    "coreutils"
    "direnv"
    "fd"
    "gcc"
    "git"
    "grep"
    "helm"
    "jq"
    "k3d"
    "pnpm"
    "ripgrep"
    "terraform"
    "trash"
  ];
    casks  = [
      "1password"
      "adobe-creative-cloud"
      "arc"
      "blender"
      "discord"
      "docker"
      "dozer"
      "figma"
      "github"
      "google-chrome"
      "google-cloud-sdk"
      "grammarly-desktop"
      "hammerspoon"
      "imageoptim"
      "istat-menus"
      "kitty"
      "linear-linear"
      "loom"
      "microsoft-office"
      "microsoft-teams"
      "miro"
      "monodraw"
      "notion"
      "notion-calendar"
      "obs"
      "orbstack"
      "orka-desktop"
      "proton-mail"
      "protonvpn"
      "raycast"
      "rectangle"
      "screenflow"
      "slack"
      "spotify"
      "virtualbuddy"
      "visual-studio-code"
      "vmware-fusion"
      "zoom"
    ];
    masApps = {
      Tailscale = 1475387142;
      Xcode = 497799835;
      "iA-Writer" = 775737590;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    defaults = {
      LaunchServices.LSQuarantine = true;

      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };

      dock = {
        static-only = true;
        tilesize = 20;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NSDocumentSaveNewDocumentsToCloud = false; 
        ApplePressAndHoldEnabled = false;
      };

      CustomUserPreferences = {
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
        "com.apple.WindowManager".GloballyEnabled = true;
      };
    };
  };

 fonts = {
    packages = [
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      pkgs.font-awesome
      pkgs.material-design-icons
      pkgs.tenderness
      pkgs.spleen
    ];
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.batman = {
    home = "/Users/batman";
    shell = pkgs.fish;
  };
}
