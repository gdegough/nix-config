{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  systemd = {
    # set gdm monitor configuration and link for ipsec l2tp secrets
    tmpfiles.rules = [
      ''f+ /run/gdm/.config/monitors.xml - gdm gdm - <monitors version="2"><configuration><logicalmonitor><x>0</x><y>0</y><scale>1</scale><primary>yes</primary><monitor><monitorspec><connector>eDP-1</connector><vendor>CMN</vendor><product>0x1408</product><serial>0x00000000</serial></monitorspec><mode><width>1920</width><height>1080</height><rate>60.000</rate></mode></monitor></logicalmonitor></configuration></monitors>''
    ];
  };
}
