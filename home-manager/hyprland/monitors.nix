{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = lib.mkIf config.qm.desktop.hyprland.enable {
    monitor = [
      "DP-2, 2560x1440@180, 0x0, 1, bitdepth, 10, vrr, 2"
      "DP-1,1920x1080@60, auto-right, 1, transform, 3, vrr, 0"
      "HDMI-A-1, 1920x1080@60, auto-up, 1, vrr, 0"
    ];

    workspace = [
      "1, monitor:DP-2"
      "2, monitor:DP-2"
      "3, monitor:DP-2"
      "4, monitor:DP-2"
      "5, monitor:DP-1"
      "6, monitor:DP-1"
      "7, monitor:DP-1"
      "8, monitor:DP-1"
      "9, monitor:HDMI-A-1"
      "10, monitor:HDMI-A-1"
      "name:G, monitor:DP-2"
    ];
  };
}
