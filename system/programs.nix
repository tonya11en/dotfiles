{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # -----------------------------------------------------------------------------------------------
  nixpkgs.config = {

    allowUnfree = true;

    firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
    };

    chromium = {
     enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
    };

  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    pkgs.firefoxWrapper
    pkgs.chromium
    zsh
    google-chrome
    bazel
    clang
    gcc
    rofi
  ];

  # -----------------------------------------------------------------------------------------------

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh.enable = true;
}
