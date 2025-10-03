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
    bashrcExtra = "export EDITOR='nvim'";
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixos";
      config = "nnn ~/.nixos";
      ovs = "nnn ~/AU/semester_5/OVS";
      dss = "nnn ~/AU/semester_5/DSS";
      ml = "nnn ~/AU/semester_5/ML";
    };
  };

  # Gestures
  # programs.libinput-gestures = {
  #   enable = true;
  # };

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
    "$menu" = "walker";

    # Touchpad and keyboard
    input = {
      kb_layout = "dk";
      kb_variant = "mac";
      touchpad = {
        scroll_factor = 0.3;
        drag_lock = false;
        natural_scroll = true;
        disable_while_typing = true;
      };
    };

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
	"$mod, A, exec, hyprctl dispatch workspace e-1"
	"$mod, D, exec, hyprctl dispatch workspace e+1"
	", F1, exec, brightnessctl s 10%-"
	", F2, exec, brightnessctl s 10%+"
	", F10, exec, pamixer -t"
	", F11, exec, pamixer -d 10"
	", F12, exec, pamixer -i 10"
	"$mod, S, exec, hyprshot -m region --clipboard-only"
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
   };
  };

  # Mako
  services.mako = {
    enable = true;
    iconPath = "/run/current-system/sw/share/icons";
  };

  # Nixvim
  programs.nixvim = {
    enable = true;
    plugins.web-devicons.enable = true;
    plugins.neo-tree.enable = true;
    # plugins.nvim-ufo.enable = true;
    
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
    plugins = {
      src = (pkgs.fetchFromGitHub {
        owner = "jarun";
	repo = "nnn";
	rev = "master";
	sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k="; 
      }) + "/plugins";

      mappings = {
        d = "dragdrop";
      };
    };
  };

  # VS Code
  programs.vscode.enable = true;

  # Walker
  programs.walker = {
    enable = true;
    runAsService = true;
  };

  # Waybar
  programs.waybar = {
    enable = true;
    settings.main = {
      modules-left = ["custom/nix" "hyprland/workspaces"];
      modules-center = ["clock"];
      modules-right = ["cpu" "temperature" "battery"];

      cpu = {
        format = " {usage}%";
      };

      memory = {
        format = " {used}GiB";
      };

      temperature = {
        format = " {temperatureC}°C";
      };

      battery = {
        format = "{icon} {capacity}%";
	format-icons = ["󰂎" "󰁻" "󰁽" "󰁿" "󰁹"];
      };

      "custom/nix" = {
        format = "";
	tooltip = "System info";
	on-click = "alacritty -e bash -c 'neofetch; exec bash'"; 
      };
    };

    style = ''
    * {
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 16px;
    }

    #cpu, #memory, #temperature, #battery, #custom-nix {
      padding: 0 8px;
    }

    #custom-nix {
      font-size: 20px;
      color: #5277C3;
    }
    '';
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    neofetch
    firefox
    discord
    hyprshot
    libnotify
    bibata-cursors
    nerd-fonts.jetbrains-mono
    brightnessctl
    pamixer
    zip
    unzip

    # 🦀 Rust
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer

    # 🐫 OCaml
    pkgs.ocamlPackages.ocaml
    pkgs.dune_3
    pkgs.ocamlPackages.ocaml-lsp

    # 🐍 Python
    pkgs.python3
    pkgs.python3Packages.pip

    # 🚀 Go
    pkgs.go

    # 🔧 Common
    pkgs.git
    pkgs.gnumake
  ];
}
