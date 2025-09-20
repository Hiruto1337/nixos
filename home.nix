{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  # nixpkgs.config.allowUnfree = true;

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
      };
    };
  };

  # Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/Config/nixos";
      config = "nnn ~/Config/nixos";
    };
  };

  # Emacs
  programs.emacs = {
    enable = true;
  };

  # Git
  programs.git = {
    enable = true;
    userEmail = "https://Hiruto1337@github.com";
    userName = "Hiruto1337";
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$fileManager" = "nnn";
    "$menu" = "wofi --show drun";
    input = {
      kb_layout = "dk";
      kb_variant = "mac";
      accel_profile = "adaptive";
      natural_scroll = true;
      touchpad = {
        disable_while_typing = true;
      };
    };
    monitor = [
      "eDP-1,highres,auto,1.0"
    ];

    exec-once = [ "hyprpaper" "waybar" ];

    bind =
      [
        "$mod, RETURN, exec, $terminal"
        "$mod, SPACE, exec, $menu"
	      "$mod, Q, killactive,"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
   };
  };

  # Waybar
  programs.waybar = {
    enable = true;
  };

  # Wofi
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      prompt = "Search";
      width = "40%";
      height = "40%";
      location = "center";
      lines = 10;
      insensitive = true;
      allow-images = true;
    };
    style = ''
      window {
        background-color: #282c34;
        border: 2px solid #1a2f47;
        border-radius: 8px;
        font-size: 18px;
        font-family: "TeX Gyre Adventor", monospace;
      }

      #outer-box {
        margin: 8px;
      }

      #input {
        background-color: #282c34;
        color: #e5c07b;
        margin-bottom: 16px;
      }

      #scroll {}

      #inner-box {}

      #entry {
        color: #e5c07b;
        border-radius: 4px;
        margin: 4px;
      }

      #entry:selected {
        background-color: #343a44;
      }
    '';
  };
  
  home.packages = with pkgs; [
    hyprpaper
    neofetch
    firefox
  ];
}
