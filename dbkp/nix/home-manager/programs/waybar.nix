{ config, pkgs }:

{
  enable = true;

  settings = {
    mainBar = {
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "idle_inhibitor" "clock" "custom/notification" ];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "custom/power"
      ];

      network = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ifname} ";
        format-disconnected = "";
        max-length = 50;
        on-click = "nm-connection-editor";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      tray = {
        icon-size = 15;
        spacing = 10;
      };

      clock = {
        on-click = "gnome-calendar";
      };

      pulseaudio = {
        format = "{volume}% {icon} ";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = "0% {icon} ";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };

      "custom/power" = {
        format = " ";
        on-click = "wlogout";
      };

      "custom/notification" = {
        format = "  ";
        tooltip = false;
        on-click = "swaync-client -t";
      };
    };
  };

  style = ''
    * {
        border: none;
        font-family: Font Awesome, Roboto, Arial, sans-serif;
        font-size: 13px;
        color: #ffffff;
        border-radius: 20px;
    }

    window {
    	/*font-weight: bold;*/
    }
    window#waybar {
        background: rgba(0, 0, 0, 0);
    }
    /*-----module groups----*/
    .modules-right {
    	background-color: rgba(0,43,51,0.85);
        margin: 2px 10px 0 0;
    }
    .modules-center {
    	background-color: rgba(0,43,51,0.85);
        margin: 2px 0 0 0;
    }
    .modules-left {
        margin: 2px 0 0 5px;
    	background-color: rgba(0,119,179,0.6);
    }
    /*-----modules indv----*/
    #workspaces button {
        padding: 1px 5px;
        background-color: transparent;
    }
    #workspaces button:hover {
        box-shadow: inherit;
    	background-color: rgba(0,153,153,1);
    }

    #workspaces button.active {
    	background-color: rgba(0,43,51,0.85);
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #temperature,
    #network,
    #pulseaudio,
    #custom-media,
    #tray,
    #mode,
    #custom-power,
    #custom-menu,
    #idle_inhibitor {
        padding: 0 10px;
    }
    #mode {
        color: #cc3436;
        font-weight: bold;
    }
    #custom-power {
        background-color: rgba(0,119,179,0.6);
        border-radius: 100px;
        margin: 5px 5px;
        padding: 1px 1px 1px 6px;
    }
    /*-----Indicators----*/
    #idle_inhibitor.activated {
        color: #2dcc36;
    }
    #pulseaudio.muted {
        color: #cc3436;
    }
    #battery.charging {
        color: #2dcc36;
    }
    #battery.warning:not(.charging) {
    	color: #e6e600;
    }
    #battery.critical:not(.charging) {
        color: #cc3436;
    }
    #temperature.critical {
        color: #cc3436;
    }
    /*-----Colors----*/
    /*
     *rgba(0,85,102,1),#005566 --> Indigo(dye)
     *rgba(0,43,51,1),#002B33 --> Dark Green
     *rgba(0,153,153,1),#009999 --> Persian Green
     *
     */  '';
}
