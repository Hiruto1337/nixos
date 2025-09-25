{ pkgs, ... }:

{
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
  
  # Set cursor
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
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
      ovs = "nnn ~/AU/semester_5/OVS";
      dss = "nnn ~/AU/semester_5/DSS";
      ml = "nnn ~/AU/semester_5/ML";
    };
  };

  # Git
  programs.git = {
    enable = true;
    userEmail = "https://Hiruto1337@github.com";
    userName = "Hiruto1337";
  };

  # Hyprpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc="on";
      preload = ["${builtins.toString (./wallpapers/nix-wallpaper.png)}"];
      wallpaper = [",${builtins.toString (./wallpapers/nix-wallpaper.png)}"];
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
    
    # Variables
    "$mod" = "SUPER";
    "$terminal" = "alacritty";
    "$fileManager" = "nnn";
    "$menu" = "wofi --show drun";

    # Touchpad and keyboard
    input = {
      kb_layout = "dk";
      kb_variant = "mac";
      touchpad = {
        scroll_factor = 0.3;
        middle_emulation = false;
        drag = true;
        drag_lock = false;

        natural_scroll = true;
        disable_while_typing = true;
        accel_profile = "adaptive";
      };
    };

  #    device = {
  #      name = "bcm5974";
  #    };

    monitor = [
      "eDP-1,highres,auto,1.0"
    ];

    exec-once = [
    "hyprpaper"
    "hyprctl setcursor Bibata-Modern-Classic 24"
    "waybar"
    ];

    bind =
      [
        "$mod, RETURN, exec, $terminal"
        "$mod, SPACE, exec, $menu"
	"$mod, Q, killactive,"
	"$mod SHIFT, S, exec, gnome-screenshot -f - | wl-copy" 
	"$mod, I, exec, firefox chatgpt.com"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          5)
      );
    gesture = [
      "3, horizontal, workspace"
    ];
   };
  };

  # Nixvim
  programs.nixvim = {
    enable = true;
    plugins.neo-tree.enable = true;
    
    colorschemes.tokyonight = {
      enable = true;
      settings.transparent = true;
    };

    extraConfigLua = ''
      vim.cmd([[
        hi Normal guibg=NONE ctermbg=NONE
        hi NormalNC guibg=NONE ctermbg=NONE
        hi NormalFloat guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi NeoTreeNormal guibg=NONE ctermbg=NONE
        hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
      ]])
    '';
  };

  # nnn
  programs.nnn = {
    enable = true;
  };

  # Waybar
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-center = ["clock"];
      modules-right = ["battery"];
    };
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

  xresources.properties = {
    "Xcursor.theme" = "Bibata-Modern-Classic";
    "Xcursor.size" = 24; # or adjust to taste
  };

  home.packages = with pkgs; [
    neofetch
    firefox
    discord
    bibata-cursors
    gnome-screenshot
  ];
}
