{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  # nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.7;
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
  # programs.emacs = {
  #   enable = true;
  # };

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
    device = {
      name = "synps/2-synaptics-touchpad";
      natural_scroll = true;
      disable_while_typing = true;
      accel_profile = "adaptive";
    };
    input = {
      kb_layout = "dk";
      kb_variant = "mac";
    };
    monitor = [
      "eDP-1,highres,auto,1.0"
    ];

    exec-once = [ "hyprpaper" ];

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

  # Neovim
  programs.neovim = {
    enable = true;
    extraConfig = ''
      highlight Normal guibg=none
      highlight NormalFloat guibg=none
    '';
  };

  # nnn
  programs.nnn = {
    enable = true;
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
    discordo
  ];
}
