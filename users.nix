{ pkgs, ... }: {
  users.users.lasse_gay = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$y$j9T$4tEiA.Xuoi1JceLcUhm8p1$HlDTkFbrpfwsXAk8cl.9VSTgAYxRepehyOzru9Pupv5";
  };
}
