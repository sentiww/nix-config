{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    google-drive-ocamlfuse
  ];

  systemd.services.google-drive = {
    description = "Mount Google Drive";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse /home/senti/google-drive";
      Restart = "always";
      User = "senti";
    };
  };
}
