{
  config,
  pkgs,
  ...
}:
{
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = [
    pkgs.i3blocks
  ];
  home.file = {
    ".config/i3blocks/config".text = ''
      # i3blocks configuration file
      #
      # The i3blocks man page describes the usage of the binary,
      # and its website describes the configuration:
      #
      #     https://vivien.github.io/i3blocks

      # Global properties
      separator=true
      separator_block_width=15
      markup=pango
      command=$SCRIPT_DIR/$BLOCK_NAME

      #[documentation]
      #full_text=Documentation
      #website=https://vivien.github.io/i3blocks
      #command=xdg-open "$website"
      #color=#f12711

      [mediaplayer-status]
      interval=1

      #[os-type]
      #interval=-1

      [pw-volume-monitor]
      interval=1

      [wifi-status]
      interval=5

      [memory-status]
      interval=5

      [temperature-status]
      interval=5

      [load-status]
      interval=1

      #[backlight-status]
      #interval=5

      [battery-status]
      interval=60

      [time]
      command=date '+%Y-%m-%d %H:%M'
      interval=5

      #[keyindicator]
      #command=$SCRIPT_DIR/keyindicator -c
      #interval=1
    '';
    ".local/libexec/i3blocks/afs".executable = true;
    ".local/libexec/i3blocks/afs".text = ''
      #!/usr/bin/env python3

      # Show usage information for an AFS directory.

      # Copyright 2017 Johannes Lange
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.
      #
      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.
      #
      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      import argparse
      import os
      import subprocess as sp

      def _default(name, default=''', arg_type=str):
          val = default
          if name in os.environ:
              val = os.environ[name]
          return arg_type(val)

      parser = argparse.ArgumentParser(
          description='Get AFS quota and usage information.',
          formatter_class=argparse.ArgumentDefaultsHelpFormatter,
      )
      parser.add_argument('-c', '--critical', type=int, default=_default('CRITICAL', 90, int),
                          help='Critical usage percentage.')
      parser.add_argument('-fg', '--fg-color', type=str, default=_default('CRIT_FG_COLOR', "#FF0000"),
                          help='Foreground color for critical usage.')
      parser.add_argument('-bg', '--bg-color', type=str, default=_default('CRIT_BG_COLOR', '''),
                          help='Background color for critical usage.')
      args = parser.parse_args()

      # set the afs directory to be checked
      directory = os.environ.get('BLOCK_INSTANCE', '~/afs/')
      label = os.environ.get('LABEL', ''')

      # expand environment variables etc.
      directory = os.path.expandvars(directory)
      directory = os.path.expanduser(directory)

      fs_output = sp.check_output(['fs', 'lq', '-human', directory],
                                  universal_newlines=True)

      # second line contains the information
      fs_output = fs_output.split('\n')[1]
      quota, used, percentage = fs_output.split()[1:4]
      percentage = int(percentage.split('%')[0])

      output = '%s%s/%s (%i%%)' % (label, used, quota, percentage)

      if percentage >= args.critical:
          if args.bg_color:
              output = "<span color='%s' bgcolor='%s'>%s</span>" %\
                       (args.fg_color, args.bg_color, output)
          else:
              output = "<span color='%s'>%s</span>" % (args.fg_color, output)

      print(output)
    '';
    ".local/libexec/i3blocks/airly.py".executable = true;
    ".local/libexec/i3blocks/airly.py".text = ''
      #!/usr/bin/env python3
      # -*- coding: utf-8 -*-

      # Copyright © 2019 Kudlaty 01 <kudlok@mail.ru>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      import getopt, requests, urllib, yaml, sys, os

      gconfig = {
          'apikey': 'example_api_key',
          'installationId': 2955,
          # uncomment if lat/long is preferred instead of sensorId
          # 'lat': ''',
          # 'lng': '''
      }

      class AirlyApiClient:
          def __init__(self, config=None):
              """init with optionally config"""
              self.config = config or self.parseConfig(self.parseInstance())
              self.apiUrl = 'https://airapi.airly.eu/v2/measurements/%s?' % ('installation' if 'installationId' in self.config else 'point')

          def parseInstance(self):
              """ parse the instance environment variable """
              instance = '''
              try:
                  instance = os.environ['BLOCK_INSTANCE']
              except KeyError:
                  return None
              finally:
                  if len(instance):
                      return instance
              return None

          def parseConfig(self, instance):
              """parse the instance-specific config file or a default one"""
              _instance = instance or self.parseInstance()
              xdgHome = os.environ['XDG_CONFIG_HOME'] or os.environ['HOME'] + '/.config'
              configPath = xdgHome + '/i3blocks-airly/%s.yml' % (_instance or 'config')
              try:
                  with open(configPath, 'r') as stream:
                      config=yaml.load(stream)
                      return config
              except:
                  global gconfig
                  return gconfig

          def getMeasurement(self, config=None):
              """get the measurements for the place"""
              cfg = config or self.config
              r = requests.get(self.apiUrl + urllib.parse.urlencode(self.config))
              self.lastResult = r.json()
              return self.lastResult

          def getCurrentMeasurement(self, measurement=None):
              """get only the current measurement"""
              m = measurement or self.getMeasurement()
              return m['current']['indexes']

          def getCaqiMeasurement(self, measurement=None):
              """get only the current CAQUI measurement"""
              m = measurement or self.getCurrentMeasurement()
              caqi=next(c for c in m if c['name'] == 'AIRLY_CAQI')
              return caqi

          def getAirQualityIndex(self, caqiMeasurement=None):
              """get the air quality index value from given CAQI measurement
              it's current measuement by default"""
              m = caqiMeasurement or self.getCaqiMeasurement()
              index = m['value']
              return index

          def getColor(self, measurement=None):
              """get color for given air quality indes"""
              m = measurement or self.getCaqiMeasurement()
              return m['color']

          def displayResult(self,jsonData=None):
              """display the measurement result"""
              result = self.getAirQualityIndex()
              print(round(result,2))
              print(round(result))
              print(self.getColor())

      def main(argv):
          args=argv
          client = AirlyApiClient()
          client.displayResult()

      if __name__ == "__main__":
         main(sys.argv[1:])
    '';
    ".local/libexec/i3blocks/apt-upgrades".executable = true;
    ".local/libexec/i3blocks/apt-upgrades".text = ''
      #!/usr/bin/env bash
      #
      # Copyright (C) 2015 James Murphy                                                  
      # Licensed under the terms of the GNU GPL v2 only.                                 
      #                                                                                  
      # i3blocks blocklet script to display pending system upgrades 

      # FontAwesome refresh symbol, change if you do not want to install FontAwesome
      PENDING_SYMBOL=''${PENDING_SYMBOL:-"\uf021 "}

      # By default, show both the symbol and the numbers
      SYMBOL_ONLY=''${SYMBOL_ONLY:-0}

      # By default, show something when no upgrades are pending
      ALWAYS_PRINT=''${ALWAYS_PRINT:-1}

      # Colors for when there is/isn't a pending upgrade
      PENDING_COLOR=''${PENDING_COLOR:-"#00FF00"}
      NONPENDING_COLOR=''${NONPENDING_COLOR:-"#FFFFFF"}

      while getopts s:oc:n:Nh opt; do
          case "$opt" in
              s) PENDING_SYMBOL="$OPTARG" ;;
              o) SYMBOL_ONLY=1 ;;
              c) PENDING_COLOR="$OPTARG" ;;
              n) NONPENDING_COLOR="$OPTARG" ;;
              N) ALWAYS_PRINT=0 ;;
              h) printf \
      "Usage: apt-upgrades [-s pending_symbol] [-o] [-c pending_color] [-N|-n nonpending_color] [-h]
      Options:
      -s\tSpecify a refresh symbol. Default: \"\\\\uf021 \"
      -o\tShow refresh symbol only, but no numbers.
      -c\tColor when upgrade is pending. Default:  #00FF00
      -n\tColor when no upgrade is pending. Default: #FFFFFF
      -N\tOnly display text if upgrade is pending (supercedes -n)
      -h\tShow this help text\n" && exit 0;;
          esac
      done

      read upgraded new removed held < <(
      aptitude full-upgrade --simulate --assume-yes |\
          grep -m1 '^[0-9]\+ packages upgraded,' |\
          tr -cd '0-9 ' |\
          tr ' ' '\n' |\
          grep '[0-9]\+' |\
          xargs echo)

      if [[ $upgraded != 0 ]] || [[ $new != 0 ]] || [[ $removed != 0 ]] || [[ $held != 0 ]]; then
          color="$PENDING_COLOR"
          if [[ $SYMBOL_ONLY == 1 ]]; then
              echo -e "$PENDING_SYMBOL"
              echo -e "$PENDING_SYMBOL"
          else
              echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
              echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
          fi
          echo $color
      elif [[ $ALWAYS_PRINT == 1 ]]; then
          color="$NONPENDING_COLOR"
          echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
          echo -e "$PENDING_SYMBOL$upgraded/$new/$removed/$held"
          echo $color
      fi
    '';
    ".local/libexec/i3blocks/arch-update".executable = true;
    ".local/libexec/i3blocks/arch-update".text = ''
      #!/usr/bin/env python3
      #
      # Copyright (C) 2017 Marcel Patzwahl
      # Licensed under the terms of the GNU GPL v3 only.
      #
      # i3blocks blocklet script to see the available updates of pacman and the AUR
      import subprocess
      from subprocess import check_output
      import argparse
      import os
      import re


      def create_argparse():
          def _default(name, default=''', arg_type=str):
              val = default
              if name in os.environ:
                  val = os.environ[name]
              return arg_type(val)

          strbool = lambda s: s.lower() in ['t', 'true', '1']
          strlist = lambda s: s.split()

          parser = argparse.ArgumentParser(description='Check for pacman updates')
          parser.add_argument(
              '-b',
              '--base_color',
              default = _default('BASE_COLOR', 'green'),
              help='base color of the output(default=green)'
          )
          parser.add_argument(
              '-u',
              '--updates_available_color',
              default = _default('UPDATE_COLOR', 'yellow'),
              help='color of the output, when updates are available(default=yellow)'
          )
          parser.add_argument(
              '-a',
              '--aur',
              action = 'store_const',
              const = True,
              default = _default('AUR', 'False', strbool),
              help='Include AUR packages. Attn: Yaourt must be installed'
          )
          parser.add_argument(
              '-y',
              '--aur_yay',
              action = 'store_const',
              const = True,
              default = _default('AUR_YAY', 'False', strbool),
              help='Include AUR packages. Attn: Yay must be installed'
          )
          parser.add_argument(
              '-q',
              '--quiet',
              action = 'store_const',
              const = True,
              default = _default('QUIET', 'False', strbool),
              help = 'Do not produce output when system is up to date'
          )
          parser.add_argument(
              '-w',
              '--watch',
              nargs='*',
              default = _default('WATCH', arg_type=strlist),
              help='Explicitly watch for specified packages. '
              'Listed elements are treated as regular expressions for matching.'
          )
          return parser.parse_args()


      def get_updates():
          output = '''
          try:
              output = check_output(['checkupdates']).decode('utf-8')
          except subprocess.CalledProcessError as exc:
              # checkupdates exits with 2 and no output if no updates are available.
              # we ignore this case and go on
              if not (exc.returncode == 2 and not exc.output):
                  raise exc
          if not output:
              return []

          updates = [line.split(' ')[0]
                     for line in output.split('\n')
                     if line]

          return updates


      def get_aur_yaourt_updates():
          output = '''
          try:
              output = check_output(['yaourt', '-Qua']).decode('utf-8')
          except subprocess.CalledProcessError as exc:
              # yaourt exits with 1 and no output if no updates are available.
              # we ignore this case and go on
              if not (exc.returncode == 1 and not exc.output):
                  raise exc
          if not output:
              return []

          aur_updates = [line.split(' ')[0]
                         for line in output.split('\n')
                         if line.startswith('aur/')]

          return aur_updates

      def get_aur_yay_updates():
          output = check_output(['yay', '-Qua']).decode('utf-8')
          if not output:
              return []

          aur_updates = [line.split(' ')[0] for line in output.split('\n') if line]

          return aur_updates


      def matching_updates(updates, watch_list):
          matches = set()
          for u in updates:
              for w in watch_list:
                  if re.match(w, u):
                      matches.add(u)

          return matches


      label = os.environ.get("LABEL","")
      message = "{0}<span color='{1}'>{2}</span>"
      args = create_argparse()

      updates = get_updates()
      if args.aur:
          updates += get_aur_yaourt_updates()
      elif args.aur_yay:
          updates += get_aur_yay_updates()

      update_count = len(updates)
      if update_count > 0:
          if update_count == 1:
            info = str(update_count) + ' update available'
            short_info = str(update_count) + ' update'
          else:
            info = str(update_count) + ' updates available'
            short_info = str(update_count) + ' updates'

          matches = matching_updates(updates, args.watch)
          if matches:
              info += ' [{0}]'.format(', '.join(matches))
              short_info += '*'
          print(message.format(label, args.updates_available_color, info))
          print(message.format(label, args.updates_available_color, short_info))
      elif not args.quiet:
          print(message.format(label, args.base_color, 'system up to date'))
    '';
    ".local/libexec/i3blocks/aur-update".executable = true;
    ".local/libexec/i3blocks/aur-update".text = ''
      #!/usr/bin/env python3

      # List available updates from the Arch User Repository (AUR)

      # Copyright 2018 Johannes Lange
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.
      #
      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.
      #
      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      import json
      import os
      import requests
      import socket
      import subprocess as sp

      block_button = os.environ['BLOCK_BUTTON'] if 'BLOCK_BUTTON' in os.environ else None
      block_button = int(block_button) if block_button else None


      class Args(object):
          def add_argument(self, name, default=''', arg_type=str):
              val = default
              if name in os.environ:
                  val = os.environ[name]
                  if arg_type == list:
                      val = val.split()
              val = arg_type(val)
              setattr(self, name.lower(), val)
              return val


      args = Args()
      args.add_argument('UPDATE_COLOR', 'yellow')
      args.add_argument('QUIET', 0, int)
      args.add_argument('IGNORE', [], list)
      args.add_argument('CACHE_UPDATES', 0, int)
      args.add_argument('FORCE_IPV4', 1, int)


      def version_in_aur(pkg):
          p = {'v': '5', 'type': 'search', 'by': 'name', 'arg': pkg}
          response = requests.get('https://aur.archlinux.org/rpc/', params=p)
          response = response.json()
          for r in response['results']:
              if r['Name'] == pkg:
                  return r['Version']

          return "NotFound"


      def vcs_version(pkg, ver):
          """ Try to find a sensible version for VSC packages

          If pkg looks like a VCS package according to
             https://wiki.archlinux.org/index.php/VCS_package_guidelines
          try to extract a sensible (= comparable) version number.
          """

          suffices = ['-cvs', '-svn', '-hg', '-darcs', '-bzr', '-git']
          if not any(pkg.endswith(suffix) for suffix in suffices):
              # does not look like a VCS package
              return ver

          if '.r' in ver:
              # of the form RELEASE.rREVISION: only use the release
              return ver.split('.r')[0]
          # no base release to compare, just return None
          return None

      if args.force_ipv4:
          # This is useful, because the AUR API often gets timeouts with
          # IPV6 and the call does not return.

          # monkey-patch this function to always return the IPV4-version,
          # even if capable of IPV6
          requests.packages.urllib3.util.connection.allowed_gai_family = (
              lambda: socket.AF_INET
          )

      # show the list of updates already cached
      if args.cache_updates and block_button in [2, 3]:
          if '_update_cache' in os.environ:
              updates = os.environ['_update_cache']
          else:
              updates = 'no updates cached'
          sp.call(['${pkgs.libnotify}/bin/notify-send', 'AUR updates', updates or 'up to date'])

      # get list of foreign packages -- assumed to be from the AUR
      packages = sp.check_output(['pacman', '-Qm']).decode('utf8')

      installed_version = {}
      for pkg in packages.split('\n'):
          if not pkg:
              continue
          pkg, ver = pkg.split()
          installed_version[pkg] = ver

      updates = []
      for pkg in installed_version.keys():
          if pkg in args.ignore:
              continue
          v_aur = version_in_aur(pkg)
          v_inst = installed_version[pkg]
          if vcs_version(pkg, v_aur) != vcs_version(pkg, v_inst):
              updates.append(pkg + ' (%s -> %s)' % (v_inst, v_aur))

      # create the message for the block
      n_updates = len(updates)
      msg = '''
      if n_updates > 0:
          msg = "<span color='{0}'>{1} AUR updates</span>".format(args.update_color, n_updates)
      elif not args.quiet:
          msg = 'AUR up to date'

      # turn it into a json message
      msg = {'full_text': msg}

      # cache the new updates list
      if args.cache_updates:
          msg['_update_cache'] = '\n'.join(updates)

      print(json.dumps(msg))

      # if you don't use caching, show the new list of updates
      if not args.cache_updates and block_button in [2, 3]:
          sp.call(['${pkgs.libnotify}/bin/notify-send', 'AUR updates', '\n'.join(updates) or 'up to date'])

      if not 'BLOCK_NAME' in os.environ and n_updates > 0:
          # not called by i3blocks: show the complete list
          print('\n'.join(updates))
    '';
    ".local/libexec/i3blocks/backlight".executable = true;
    ".local/libexec/i3blocks/backlight".text = ''
      #!/usr/bin/env bash

      # Show the screen brightness value given by `xbacklight`.
      # Clicking uses `xset` to turn off the backlight, scrolling increases or decreases
      # the brightness.

      # Copyright 2019 Johannes Lange
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.
      #
      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.
      #
      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.


      STEP_SIZE=''${STEP_SIZE:-5}
      USE_SUDO=''${USE_SUDO:-0}

      # whether to use `sudo` for changing the brightness (requires a NOPASSWD rule)
      if [[ "$USE_SUDO" == "0" ]] ; then
          XBACKLIGHT_SET="xbacklight"
      else
          XBACKLIGHT_SET="sudo xbacklight"
      fi

      case $BLOCK_BUTTON in
        3) xset dpms force off ;; # right click
        4) $XBACKLIGHT_SET -inc "$STEP_SIZE" ;; # scroll up
        5) $XBACKLIGHT_SET -dec "$STEP_SIZE" ;; # scroll down, decrease
      esac


      BRIGHTNESS=$(xbacklight -get | cut -f1 -d'.')
      echo "''${BRIGHTNESS}%"
    '';
    ".local/libexec/i3blocks/backlight-status".executable = true;
    ".local/libexec/i3blocks/backlight-status".text = ''
      # Change this according to your devices
      # Screen Brightness (for laptop)
      if [ -e ''${I3SOCK}.wob ]; then
          brightness_level=$(cat ''${I3SOCK}.wob)
      else
          brightness_level="null"
      fi
      echo "$brightness_level"

      exit 0
    '';
    ".local/libexec/i3blocks/bandwidth".executable = true;
    ".local/libexec/i3blocks/bandwidth".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2012 Stefan Breunig <stefan+measure-net-speed@mathphys.fsk.uni-heidelberg.de>
      # Copyright (C) 2014 kaueraal
      # Copyright (C) 2015 Thiago Perrotta <perrotta dot thiago at poli dot ufrj dot br>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      # Get custom IN and OUT labels if provided by command line arguments
      while [[ $# -gt 1 ]]; do
          key="$1"
          case "$key" in
              -i|--inlabel)
                  INLABEL="$2"
                  shift;;
              -o|--outlabel)
                  OUTLABEL="$2"
                  shift;;
          esac
          shift
      done

      [[ -z "$INLABEL" ]] && INLABEL="IN "
      [[ -z "$OUTLABEL" ]] && OUTLABEL="OUT "

      # Use the provided interface, otherwise the device used for the default route.
      if [[ -z $INTERFACE ]] && [[ -n $BLOCK_INSTANCE ]]; then
        INTERFACE=$BLOCK_INSTANCE
      elif [[ -z $INTERFACE ]]; then
        INTERFACE=$(ip route | awk '/^default/ { print $5 ; exit }')
      fi

      # Exit if there is no default route
      [[ -z "$INTERFACE" ]] && exit

      # Issue #36 compliant.
      if ! [ -e "/sys/class/net/''${INTERFACE}/operstate" ] || \
          (! [ "$TREAT_UNKNOWN_AS_UP" = "1" ] &&
          ! [ "`cat /sys/class/net/''${INTERFACE}/operstate`" = "up" ])
      then
          echo "$INTERFACE down"
          echo "$INTERFACE down"
          echo "#FF0000"
          exit 0
      fi

      # path to store the old results in
      path="/tmp/$(basename $0)-''${INTERFACE}"

      # grabbing data for each adapter.
      read rx < "/sys/class/net/''${INTERFACE}/statistics/rx_bytes"
      read tx < "/sys/class/net/''${INTERFACE}/statistics/tx_bytes"

      # get time
      time="$(date +%s)"

      # write current data if file does not exist. Do not exit, this will cause
      # problems if this file is sourced instead of executed as another process.
      if ! [[ -f "''${path}" ]]; then
        echo "''${time} ''${rx} ''${tx}" > "''${path}"
        chmod 0666 "''${path}"
      fi


      # read previous state and update data storage
      read old < "''${path}"
      echo "''${time} ''${rx} ''${tx}" > "''${path}"

      # parse old data and calc time passed
      old=(''${old//;/ })
      time_diff=$(( $time - ''${old[0]} ))

      # sanity check: has a positive amount of time passed
      [[ "''${time_diff}" -gt 0 ]] || exit

      # calc bytes transferred, and their rate in byte/s
      rx_diff=$(( $rx - ''${old[1]} ))
      tx_diff=$(( $tx - ''${old[2]} ))
      rx_rate=$(( $rx_diff / $time_diff ))
      tx_rate=$(( $tx_diff / $time_diff ))

      # shift by 10 bytes to get KiB/s. If the value is larger than
      # 1024^2 = 1048576, then display MiB/s instead

      # incoming
      echo -n "$INLABEL"
      rx_kib=$(( $rx_rate >> 10 ))
      if hash bc 2>/dev/null && [[ "$rx_rate" -gt 1048576 ]]; then
        printf '%sM' "`echo "scale=1; $rx_kib / 1024" | bc`"
      else
        echo -n "''${rx_kib}K"
      fi

      echo -n " "

      # outgoing
      echo -n "$OUTLABEL"
      tx_kib=$(( $tx_rate >> 10 ))
      if hash bc 2>/dev/null && [[ "$tx_rate" -gt 1048576 ]]; then
        printf '%sM\n' "`echo "scale=1; $tx_kib / 1024" | bc`"
      else
        echo "''${tx_kib}K"
      fi

    '';
    ".local/libexec/i3blocks/bandwidth3".executable = true;
    ".local/libexec/i3blocks/bandwidth3".text = ''
      #!/usr/bin/env bash
      #
      # Copyright (C) 2015 James Murphy
      # Licensed under the terms of the GNU GPL v2 only.
      #
      # i3blocks blocklet script to monitor bandwidth usage

      iface="''${BLOCK_INSTANCE}"
      iface="''${IFACE:-$iface}"
      dt="''${DT:-3}"
      unit="''${UNIT:-Mb}"
      LABEL="''${LABEL:-<span font='FontAwesome'>  </span>}" # down arrow up arrow
      printf_command="''${PRINTF_COMMAND:-"printf \"''${LABEL}%-5.1f/%5.1f %s/s\\n\", rx, wx, unit;"}"

      function default_interface {
          ip route | awk '/^default via/ {print $5; exit}'
      }

      function check_proc_net_dev {
          if [ ! -f "/proc/net/dev" ]; then
              echo "/proc/net/dev not found"
              exit 1
          fi
      }

      function list_interfaces {
          check_proc_net_dev
          echo "Interfaces in /proc/net/dev:"
          grep -o "^[^:]\\+:" /proc/net/dev | tr -d " :"
      }

      while getopts i:t:u:p:lh opt; do
          case "$opt" in
              i) iface="$OPTARG" ;;
              t) dt="$OPTARG" ;;
              u) unit="$OPTARG" ;;
              p) printf_command="$OPTARG" ;;
              l) list_interfaces && exit 0 ;;
              h) printf \
      "Usage: bandwidth3 [-i interface] [-t time] [-u unit] [-p printf_command] [-l] [-h]
      Options:
      -i\tNetwork interface to measure. Default determined using \`ip route\`.
      -t\tTime interval in seconds between measurements. Default: 3
      -u\tUnits to measure bytes in. Default: Mb
      \tAllowed units: Kb, KB, Mb, MB, Gb, GB, Tb, TB
      \tUnits may have optional it/its/yte/ytes on the end, e.g. Mbits, KByte
      -p\tAwk command to be called after a measurement is made. 
      \tDefault: printf \"<span font='FontAwesome'>  </span>%%-5.1f/%%5.1f %%s/s\\\\n\", rx, wx, unit;
      \tExposed variables: rx, wx, tx, unit, iface
      -l\tList available interfaces in /proc/net/dev
      -h\tShow this help text
      " && exit 0;;
          esac
      done

      check_proc_net_dev

      iface="''${iface:-$(default_interface)}"
      while [ -z "$iface" ]; do
          echo No default interface
          sleep "$dt"
          iface=$(default_interface)
      done

      case "$unit" in
          Kb|Kbit|Kbits)   bytes_per_unit=$((1024 / 8));;
          KB|KByte|KBytes) bytes_per_unit=$((1024));;
          Mb|Mbit|Mbits)   bytes_per_unit=$((1024 * 1024 / 8));;
          MB|MByte|MBytes) bytes_per_unit=$((1024 * 1024));;
          Gb|Gbit|Gbits)   bytes_per_unit=$((1024 * 1024 * 1024 / 8));;
          GB|GByte|GBytes) bytes_per_unit=$((1024 * 1024 * 1024));;
          Tb|Tbit|Tbits)   bytes_per_unit=$((1024 * 1024 * 1024 * 1024 / 8));;
          TB|TByte|TBytes) bytes_per_unit=$((1024 * 1024 * 1024 * 1024));;
          *) echo Bad unit "$unit" && exit 1;;
      esac

      scalar=$((bytes_per_unit * dt))
      init_line=$(cat /proc/net/dev | grep "^[ ]*$iface:")
      if [ -z "$init_line" ]; then
          echo Interface not found in /proc/net/dev: "$iface"
          exit 1
      fi

      init_received=$(awk '{print $2}' <<< $init_line)
      init_sent=$(awk '{print $10}' <<< $init_line)

      (while true; do cat /proc/net/dev; sleep "$dt"; done) |\
          stdbuf -oL grep "^[ ]*$iface:" |\
          awk -v scalar="$scalar" -v unit="$unit" -v iface="$iface" '
      BEGIN{old_received='"$init_received"';old_sent='"$init_sent"'}
      {
          received=$2
          sent=$10
          rx=(received-old_received)/scalar;
          wx=(sent-old_sent)/scalar;
          tx=rx+wr;
          old_received=received;
          old_sent=sent;
          if(rx >= 0 && wx >= 0){
              '"$printf_command"';
              fflush(stdout);
          }
      }
      '
    '';
    ".local/libexec/i3blocks/battery".executable = true;
    ".local/libexec/i3blocks/battery".text = ''
      #!/usr/bin/env perl
      #
      # Copyright 2014 Pierre Mavro <deimos@deimos.fr>
      # Copyright 2014 Vivien Didelot <vivien@didelot.org>
      #
      # Licensed under the terms of the GNU GPL v3, or any later version.
      #
      # This script is meant to use with i3blocks. It parses the output of the "acpi"
      # command (often provided by a package of the same name) to read the status of
      # the battery, and eventually its remaining time (to full charge or discharge).
      #
      # The color will gradually change for a percentage below 85%, and the urgency
      # (exit code 33) is set if there is less that 5% remaining.

      use strict;
      use warnings;
      use utf8;

      my $acpi;
      my $status;
      my $percent;
      my $ac_adapt;
      my $full_text;
      my $short_text;
      my $bat_number = $ENV{BAT_NUMBER} || 0;
      my $label = $ENV{LABEL} || "";

      # read the first line of the "acpi" command output
      open (ACPI, "acpi -b 2>/dev/null| grep 'Battery $bat_number' |") or die;
      $acpi = <ACPI>;
      close(ACPI);

      # fail on unexpected output
      if (not defined($acpi)) {
          # don't print anything to stderr if there is no battery
          exit(0);
      }
      elsif ($acpi !~ /: ([\w\s]+), (\d+)%/) {
          die "$acpi\n";
      }

      $status = $1;
      $percent = $2;
      $full_text = "$label$percent%";

      if ($status eq 'Discharging') {
          $full_text .= ' DIS';
      } elsif ($status eq 'Charging') {
          $full_text .= ' CHR';
      } elsif ($status eq 'Unknown') {
          open (AC_ADAPTER, "acpi -a |") or die;
          $ac_adapt = <AC_ADAPTER>;
          close(AC_ADAPTER);

          if ($ac_adapt =~ /: ([\w-]+)/) {
              $ac_adapt = $1;

              if ($ac_adapt eq 'on-line') {
                  $full_text .= ' CHR';
              } elsif ($ac_adapt eq 'off-line') {
                  $full_text .= ' DIS';
              }
          }
      }

      $short_text = $full_text;

      if ($acpi =~ /(\d\d:\d\d):/) {
          $full_text .= " ($1)";
      }

      # print text
      print "$full_text\n";
      print "$short_text\n";

      # consider color and urgent flag only on discharge
      if ($status eq 'Discharging') {

          if ($percent < 20) {
              print "#FF0000\n";
          } elsif ($percent < 40) {
              print "#FFAE00\n";
          } elsif ($percent < 60) {
              print "#FFF600\n";
          } elsif ($percent < 85) {
              print "#A8FF00\n";
          }

          if ($percent < 5) {
              exit(33);
          }
      }

      exit(0);
    '';
    ".local/libexec/i3blocks/battery2".executable = true;
    ".local/libexec/i3blocks/battery2".text = ''
      #!/usr/bin/env python3
      #
      # Copyright (C) 2016 James Murphy
      # Licensed under the GPL version 2 only
      #
      # A battery indicator blocklet script for i3blocks

      from subprocess import check_output
      import os
      import re

      config = dict(os.environ)
      status = check_output(['acpi'], universal_newlines=True)

      if not status:
          # stands for no battery found
          color = config.get("color_10", "red")
          fulltext = "<span color='{}'><span font='FontAwesome'>\uf00d \uf240</span></span>".format(color)
          percentleft = 100
      else:
          # if there is more than one battery in one laptop, the percentage left is
          # available for each battery separately, although state and remaining
          # time for overall block is shown in the status of the first battery
          batteries = status.split("\n")
          state_batteries=[]
          commasplitstatus_batteries=[]
          percentleft_batteries=[]
          time = ""
          for battery in batteries:
              if battery!=''':
                  state_batteries.append(battery.split(": ")[1].split(", ")[0])
                  commasplitstatus = battery.split(", ")
                  if not time:
                      time = commasplitstatus[-1].strip()
                      # check if it matches a time
                      time = re.match(r"(\d+):(\d+)", time)
                      if time:
                          time = ":".join(time.groups())
                          timeleft = " ({})".format(time)
                      else:
                          timeleft = ""

                  p = int(commasplitstatus[1].rstrip("%\n"))
                  if p>0:
                      percentleft_batteries.append(p)
                  commasplitstatus_batteries.append(commasplitstatus)
          state = state_batteries[0]
          commasplitstatus = commasplitstatus_batteries[0]
          if percentleft_batteries:
              percentleft = int(sum(percentleft_batteries)/len(percentleft_batteries))
          else:
              percentleft = 0

          # stands for charging
          color = config.get("color_charging", "yellow")
          FA_LIGHTNING = "<span color='{}'><span font='FontAwesome'>\uf0e7</span></span>".format(color)

          # stands for plugged in
          FA_PLUG = "<span font='FontAwesome'>\uf1e6</span>"

          # stands for using battery
          FA_BATTERY = "<span font='FontAwesome'>\uf240</span>"

          # stands for unknown status of battery
          FA_QUESTION = "<span font='FontAwesome'>\uf128</span>"


          if state == "Discharging":
              fulltext = FA_BATTERY + " "
          elif state == "Full":
              fulltext = FA_PLUG + " "
              timeleft = ""
          elif state == "Unknown":
              fulltext = FA_QUESTION + " " + FA_BATTERY + " "
              timeleft = ""
          else:
              fulltext = FA_LIGHTNING + " " + FA_PLUG + " "

          def color(percent):
              if percent < 10:
                  # exit code 33 will turn background red
                  return config.get("color_10", "#FFFFFF")
              if percent < 20:
                  return config.get("color_20", "#FF3300")
              if percent < 30:
                  return config.get("color_30", "#FF6600")
              if percent < 40:
                  return config.get("color_40", "#FF9900")
              if percent < 50:
                  return config.get("color_50", "#FFCC00")
              if percent < 60:
                  return config.get("color_60", "#FFFF00")
              if percent < 70:
                  return config.get("color_70", "#FFFF33")
              if percent < 80:
                  return config.get("color_80", "#FFFF66")
              return config.get("color_full", "#FFFFFF")

          form =  '<span color="{}">{}%</span>'
          fulltext += form.format(color(percentleft), percentleft)
          fulltext += timeleft

      print(fulltext)
      print(fulltext)
      if percentleft < 10:
          exit(33)
    '';
    ".local/libexec/i3blocks/batterybar".executable = true;
    ".local/libexec/i3blocks/batterybar".text = ''
      #!/usr/bin/env bash
      #  batterybar; displays battery percentage as a bar on i3blocks
      #  
      #  Copyright 2015 Keftaa <adnan.37h@gmail.com>
      #  
      #  This program is free software; you can redistribute it and/or modify
      #  it under the terms of the GNU General Public License as published by
      #  the Free Software Foundation; either version 2 of the License, or
      #  (at your option) any later version.
      #  
      #  This program is distributed in the hope that it will be useful,
      #  but WITHOUT ANY WARRANTY; without even the implied warranty of
      #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      #  GNU General Public License for more details.
      #  
      #  You should have received a copy of the GNU General Public License
      #  along with this program; if not, write to the Free Software
      #  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
      #  MA 02110-1301, USA.
      #  
      #  
      readarray -t output <<< $(acpi battery)
      battery_count=''${#output[@]}

      for line in "''${output[@]}";
      do
          percentages+=($(echo "$line" | grep -o -m1 '[0-9]\{1,3\}%' | tr -d '%'))
          statuses+=($(echo "$line" | egrep -o -m1 'Discharging|Charging|AC|Full|Unknown'))
          remaining=$(echo "$line" | egrep -o -m1 '[0-9][0-9]:[0-9][0-9]')
          if [[ -n $remaining ]]; then
              remainings+=(" ($remaining)")
          else 
              remainings+=("")
          fi
      done

      squares="■"

      #There are 8 colors that reflect the current battery percentage when 
      #discharging
      dis_colors=("''${C1:-#FF0027}" "''${C2:-#FF3B05}" "''${C3:-#FFB923}" 
                  "''${C4:-#FFD000}" "''${C5:-#E4FF00}" "''${C6:-#ADFF00}"
                  "''${C7:-#6DFF00}" "''${C8:-#10BA00}") 
      charging_color="''${CHARGING_COLOR:-#00AFE3}"
      full_color="''${FULL_COLOR:-#FFFFFF}"
      ac_color="''${AC_COLOR:-#535353}"


      while getopts 1:2:3:4:5:6:7:8:c:f:a:h opt; do
          case "$opt" in
              1) dis_colors[0]="$OPTARG";;
              2) dis_colors[1]="$OPTARG";;
              3) dis_colors[2]="$OPTARG";;
              4) dis_colors[3]="$OPTARG";;
              5) dis_colors[4]="$OPTARG";;
              6) dis_colors[5]="$OPTARG";;
              7) dis_colors[6]="$OPTARG";;
              8) dis_colors[7]="$OPTARG";;
              c) charging_color="$OPTARG";;
              f) full_color="$OPTARG";;
              a) ac_color="$OPTARG";;
              h) printf "Usage: batterybar [OPTION] color
              When discharging, there are 8 [1-8] levels colors.
              You can specify custom colors, for example:
              
              batterybar -1 red -2 \"#F6F6F6\" -8 green
              
              You can also specify the colors for the charging, AC and
              charged states:
              
              batterybar -c green -f white -a \"#EEEEEE\"\n";
              exit 0;
          esac
      done

      end=$(($battery_count - 1))
      for i in $(seq 0 $end);
      do
          if (( percentages[$i] > 0 && percentages[$i] < 20  )); then
              squares="■"
          elif (( percentages[$i] >= 20 && percentages[$i] < 40 )); then
              squares="■■"
          elif (( percentages[$i] >= 40 && percentages[$i] < 60 )); then
              squares="■■■"
          elif (( percentages[$i] >= 60 && percentages[$i] < 80 )); then
              squares="■■■■"
          elif (( percentages[$i] >=80 )); then
              squares="■■■■■"
          fi

          if [[ "''${statuses[$i]}" = "Unknown" ]]; then
              squares="<sup>?</sup>$squares"
          fi

          case "''${statuses[$i]}" in
          "Charging")
              color="$charging_color"
          ;;
          "Full")
              color="$full_color"
          ;;
          "AC")
              color="$ac_color"
          ;;
          "Discharging"|"Unknown")
              if (( percentages[$i] >= 0 && percentages[$i] < 10 )); then
                  color="''${dis_colors[0]}"
              elif (( percentages[$i] >= 10 && percentages[$i] < 20 )); then
                  color="''${dis_colors[1]}"
              elif (( percentages[$i] >= 20 && percentages[$i] < 30 )); then
                  color="''${dis_colors[2]}"
              elif (( percentages[$i] >= 30 && percentages[$i] < 40 )); then
                  color="''${dis_colors[3]}"
              elif (( percentages[$i] >= 40 && percentages[$i] < 60 )); then
                  color="''${dis_colors[4]}"
              elif (( percentages[$i] >= 60 && percentages[$i] < 70 )); then
                  color="''${dis_colors[5]}"
              elif (( percentages[$i] >= 70 && percentages[$i] < 80 )); then
                  color="''${dis_colors[6]}"
              elif (( percentages[$i] >= 80 )); then
                  color="''${dis_colors[7]}"
              fi
          ;;
          esac

          # Print Battery number if there is more than one
          if (( $end > 0 )) ; then 
              message="$message $(($i + 1)):" 
          fi

          if [[ "$BLOCK_BUTTON" -eq 1 ]]; then 
              message="$message ''${statuses[$i]} <span foreground=\"$color\">''${percentages[$i]}%''${remainings[i]}</span>"
          fi
              message="$message <span foreground=\"$color\">$squares</span>" 
      done

      echo $message

    '';
    ".local/libexec/i3blocks/battery-poly".executable = true;
    ".local/libexec/i3blocks/battery-poly".text = ''
      #!/usr/bin/env python3
      """
      poly-battery-status-py: Generates a pretty status-bar string for multi-battery systems on Linux.
      Copyright (C) 2020  Falke Carlsen

      This program is free software: you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
      the Free Software Foundation, either version 3 of the License, or
      (at your option) any later version.

      This program is distributed in the hope that it will be useful,
      but WITHOUT ANY WARRANTY; without even the implied warranty of
      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      GNU General Public License for more details.

      You should have received a copy of the GNU General Public License
      along with this program.  If not, see <https://www.gnu.org/licenses/>.
      """

      import re
      import sys
      from enum import Enum
      from pathlib import Path

      PSEUDO_FS_PATH = "/sys/class/power_supply/"
      CURRENT_CHARGE_FILENAME = "energy_now"
      MAX_CHARGE_FILENAME = "energy_full"
      POWER_DRAW_FILENAME = "power_now"
      TLP_THRESHOLD_PERCENTAGE = 1.0
      PERCENTAGE_FORMAT = ".2%"

      if len(sys.argv) > 1:
          # parsing threshold
          try:
              TLP_THRESHOLD_PERCENTAGE = float(sys.argv[1])
          except ValueError:
              print(f"[ERROR]: Could not convert '{sys.argv[1]}' into a float.")
          if len(sys.argv) > 2:
              # parsing formatting
              PERCENTAGE_FORMAT = sys.argv[2]


      class Status(Enum):
          CHARGING = 1
          DISCHARGING = 2
          PASSIVE = 3


      class Configuration:
          time_to_completion: int
          percentage: float
          status: Status

          def __init__(self, time_to_completion, percentage, status):
              self.time_to_completion = time_to_completion
              self.percentage = percentage
              self.status = status


      class Battery:
          status: Status
          current_charge: int
          max_charge: int
          power_draw: int

          def __init__(self, status, current_charge, max_charge, power_draw):
              self.Status = status
              self.current_charge = current_charge
              self.max_charge = max_charge
              self.power_draw = power_draw


      def get_configuration() -> Configuration:
          # get all batteries on system
          batteries = []
          for x in Path(PSEUDO_FS_PATH).iterdir():
              bat_name = str(x.parts[len(x.parts) - 1])
              if re.match("^BAT\d+$", bat_name):
                  batteries.append(Battery(
                      get_status(bat_name),
                      get_current_charge(bat_name),
                      get_max_charge(bat_name),
                      get_power_draw(bat_name)))

          # calculate global status, assumes that if a battery is not passive, it will be discharging or charging
          config_status = Status.PASSIVE
          for bat in batteries:
              if bat.Status == Status.CHARGING:
                  config_status = Status.CHARGING
                  break
              elif bat.Status == Status.DISCHARGING:
                  config_status = Status.DISCHARGING
                  break

          # construct and return configuration
          return Configuration(calc_time(batteries, config_status), calc_percentage(batteries), config_status)


      def get_status(bat_name: str) -> Status:
          raw_status = Path(f"{PSEUDO_FS_PATH}{bat_name}/status").open().read().strip()
          if raw_status == "Unknown" or raw_status == "Full":
              return Status.PASSIVE
          elif raw_status == "Charging":
              return Status.CHARGING
          elif raw_status == "Discharging":
              return Status.DISCHARGING
          else:
              raise ValueError


      def get_current_charge(bat_name: str) -> int:
          return int(Path(f"{PSEUDO_FS_PATH}{bat_name}/{CURRENT_CHARGE_FILENAME}").open().read().strip())


      def get_max_charge(bat_name: str) -> int:
          return int(Path(f"{PSEUDO_FS_PATH}{bat_name}/{MAX_CHARGE_FILENAME}").open().read().strip())


      def get_power_draw(bat_name: str) -> int:
          return int(Path(f"{PSEUDO_FS_PATH}{bat_name}/{POWER_DRAW_FILENAME}").open().read().strip())


      def calc_time(batteries: list, status: Status) -> int:
          if status == Status.PASSIVE:
              return 0
          # get total metrics on configuration
          total_current_charge = sum([bat.current_charge for bat in batteries])
          total_max_charge = sum([bat.max_charge for bat in batteries])
          total_power_draw = sum([bat.power_draw for bat in batteries])
          if total_power_draw == 0:
              return 0
          if status == Status.DISCHARGING:
              # return number of seconds until empty
              return (total_current_charge / total_power_draw) * 3600
          elif status == Status.CHARGING:
              # return number of seconds until (optionally relatively) charged
              return (((total_max_charge * TLP_THRESHOLD_PERCENTAGE) - total_current_charge) / total_power_draw) * 3600


      def calc_percentage(batteries: list) -> float:
          total_max_charge = sum([bat.max_charge for bat in batteries])
          total_current_charge = sum([bat.current_charge for bat in batteries])
          return total_current_charge / total_max_charge


      def calc_display_time(status: Status, seconds: int) -> str:
          hours = int(seconds // 3600)
          minutes = int((seconds % 3600) / 60)
          if status == Status.PASSIVE:
              return ""

          # assume charging initially if not passive
          direction = "+"
          if status == Status.DISCHARGING:
              direction = "-"

          # format output digitally, e.g. (+0:09)
          return f" ({direction}{hours}:{minutes:02})"


      def print_status(config: Configuration):
          print(f"{config.percentage:{PERCENTAGE_FORMAT}}{calc_display_time(config.status, config.time_to_completion)}")


      def main():
          print_status(get_configuration())


      if __name__ == '__main__':
          main()
    '';
    ".local/libexec/i3blocks/battery-status".executable = true;
    ".local/libexec/i3blocks/battery-status".text = ''
      # Change this according to your devices
      # Battery or charger
      battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
      battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')
      if [ $battery_status = "discharging" ];
      then
          battery_pluggedin="<span font='icon'>🔋</span>" # battery symbol
      #    battery_pluggedin=$'\U0001F50B' # battery symbol
      else
          battery_pluggedin="<span font='icon'>🔌</span>" # electric plug (charging)
      #    battery_pluggedin=$'\U0001F50C' # electric plug (charging)
      #    battery_pluggedin="<span font='icon'>🗲</span>" # lightning bolt (charging)
      #    battery_pluggedin=$'\U0001F5F2' # lightning bolt (charging)
      fi
      echo "$battery_pluggedin $battery_charge"

      exit 0
    '';
    ".local/libexec/i3blocks/calendar".executable = true;
    ".local/libexec/i3blocks/calendar".text = ''
      #!/usr/bin/env sh

      WIDTH=''${WIDTH:-200}
      HEIGHT=''${HEIGHT:-200}
      DATEFMT=''${DATEFMT:-"+%a %d.%m.%Y %H:%M:%S"}
      SHORTFMT=''${SHORTFMT:-"+%H:%M:%S"}

      OPTIND=1
      while getopts ":f:W:H:" opt; do
          case $opt in
              f) DATEFMT="$OPTARG" ;;
              W) WIDTH="$OPTARG" ;;
              H) HEIGHT="$OPTARG" ;;
              \?)
                  echo "Invalid option: -$OPTARG" >&2
                  exit 1
                  ;;
              :)
                  echo "Option -$OPTARG requires an argument." >&2
                  exit 1
                  ;;
          esac
      done

      case "$BLOCK_BUTTON" in
        1|2|3) 

          # the position of the upper left corner of the popup
          posX=$(($BLOCK_X - $WIDTH / 2))
          posY=$(($BLOCK_Y - $HEIGHT))

          i3-msg -q "exec yad --calendar \
              --width=$WIDTH --height=$HEIGHT \
              --undecorated --fixed \
              --close-on-unfocus --no-buttons \
              --posx=$posX --posy=$posY \
              > /dev/null"
      esac
      echo "$LABEL$(date "$DATEFMT")"
      echo "$LABEL$(date "$SHORTFMT")"
    '';
    ".local/libexec/i3blocks/colorpicker".executable = true;
    ".local/libexec/i3blocks/colorpicker".text = ''
      #!/usr/bin/env bash
      ###### Default environment variables ######
      IDLE_TEXT=''${IDLE_TEXT:-CPICK}
      IDLE_TEXT_COLOR=''${IDLE_TEXT_COLOR:-#FFFFFF}

      ###### Verify dependencies ######
      if ! command -v xdotool &> /dev/null || ! command -v grabc &> /dev/null; then
        error 'xdotool and/or grabc is not available'
        exit 1
      fi

      ###### Functions ######
      error() {
        echo Error: "$@" 1>&2
      }

      play_pause() {
        $running && pause || play
      }

      play() {
        running=true
        pickcolor
      }

      pause() {
        running=false
        fgcolor="$IDLE_TEXT_COLOR"
      }

      hash2hex() {
        echo "''${1/\#/0x}"
      }

      subtract_colors() {
        col1=$(hash2hex "$1")
        col2=$(hash2hex "$2")
        b1=$(( col1 % 0x000100 ))
        g1=$(( (col1 % 0x010000 - b1) / 0x100 ))
        r1=$(( (col1 % 0x1000000 - 0x100*g1 - b1) / 0x10000 ))
        b2=$(( col2 % 0x000100 ))
        g2=$(( (col2 % 0x010000 - b2) / 0x100 ))
        r2=$(( (col2 % 0x1000000 - 0x100*g2 - b2) / 0x10000 ))
        dr=$(( r2 - r1 ))
        dg=$(( g2 - g1 ))
        db=$(( b2 - b1 ))
        echo $(( ''${dr#-} + ''${dg#-} + ''${db#-} ))
      }

      rgbcmybw=(
        [0]='#ff0000'
        [1]='#00ff00'
        [2]='#0000ff'
        [3]='#ffff00'
        [4]='#ff00ff'
        [5]='#00ffff'
        [6]='#000000'
        [7]='#ffffff')

      pickcolor() {
        > /dev/null 2>&1 xdotool sleep 0.01 click 1 &
        bgcolor=$(grabc 2> /dev/null)
        col_diff_max=0
        col_diff=0
        for col in "''${rgbcmybw[@]}"; do
          col_diff=$(subtract_colors "$col" "$bgcolor")
          if (( ''${col_diff#-} > "$col_diff_max" )); then
            fgcolor=$col
            col_diff_max=''${col_diff#-}
          fi
        done
      }

      ###### Initialize ######
      [[ ! -v running ]] && pause

      ###### Click processing ######
      case $BLOCK_BUTTON in
        1 )
          play_pause
          ;;
      esac

      ###### Update color ######
      if $running; then
        pickcolor
        bgcolorstring='"background":"'"$bgcolor"'"'
      else
        bgcolor="$IDLE_TEXT"
        bgcolorstring=
      fi

      ###### Output ######
      cat << EOF
      {"full_text":"$bgcolor",\
      "running":"$running",\
      "bgcolor":"$bgcolor",\
      "fgcolor":"$fgcolor",\
      "color":"$fgcolor",\
      $bgcolorstring\
      }
      EOF
    '';
    ".local/libexec/i3blocks/cpu_usage".executable = true;
    ".local/libexec/i3blocks/cpu_usage".text = ''
      #!/usr/bin/env perl
      #
      # Copyright 2014 Pierre Mavro <deimos@deimos.fr>
      # Copyright 2014 Vivien Didelot <vivien@didelot.org>
      # Copyright 2014 Andreas Guldstrand <andreas.guldstrand@gmail.com>
      #
      # Licensed under the terms of the GNU GPL v3, or any later version.

      use strict;
      use warnings;
      use utf8;
      use Getopt::Long;

      # default values
      my $t_warn = $ENV{T_WARN} // 50;
      my $t_crit = $ENV{T_CRIT} // 80;
      my $cpu_usage = -1;
      my $decimals = $ENV{DECIMALS} // 2;
      my $label = $ENV{LABEL} // "";
      my $color_normal = $ENV{COLOR_NORMAL} // "#EBDBB2";
      my $color_warn = $ENV{COLOR_WARN} // "#FFFC00";
      my $color_crit = $ENV{COLOR_CRIT} // "#FF0000";

      sub help {
          print "Usage: cpu_usage [-w <warning>] [-c <critical>] [-d <decimals>]\n";
          print "-w <percent>: warning threshold to become yellow\n";
          print "-c <percent>: critical threshold to become red\n";
          print "-d <decimals>:  Use <decimals> decimals for percentage (default is $decimals) \n"; 
          exit 0;
      }

      GetOptions("help|h" => \&help,
                 "w=i"    => \$t_warn,
                 "c=i"    => \$t_crit,
                 "d=i"    => \$decimals,
      );

      # Get CPU usage
      $ENV{LC_ALL}="en_US"; # if mpstat is not run under en_US locale, things may break, so make sure it is
      open (MPSTAT, 'mpstat 1 1 |') or die;
      while (<MPSTAT>) {
          if (/^.*\s+(\d+\.\d+)[\s\x00]?$/) {
              $cpu_usage = 100 - $1; # 100% - %idle
              last;
          }
      }
      close(MPSTAT);

      $cpu_usage eq -1 and die 'Can\'t find CPU information';

      # Print short_text, full_text
      print "''${label}";
      printf "%.''${decimals}f%%\n", $cpu_usage;
      print "''${label}";
      printf "%.''${decimals}f%%\n", $cpu_usage;

      # Print color, if needed
      if ($cpu_usage >= $t_crit) {
          print "''${color_crit}\n";
      } elsif ($cpu_usage >= $t_warn) {
          print "''${color_warn}\n";
      } else {
          print "''${color_normal}\n";
      }

      exit 0;
    '';
    ".local/libexec/i3blocks/cpu_util_detailed".executable = true;
    ".local/libexec/i3blocks/cpu_util_detailed".text = ''
      #!/usr/bin/env bash
      # cpu_util_detailed
      # Meant for usage as an i3blocks blocklet.
      # It reports detailed CPU utilization in colors using pango markup.
      # Written by skidnik <skidnik@gmail.com>
      # Licensed under GPLv3 https://www.gnu.org/licenses/gpl-3.0.txt
      #
      # Defaults if not set
      interval=''${interval:-0} # just in case it's started not by i3blocks
      stats=''${stats:-usr nice sys iowait}
      format=''${format:-%6.2f}
      warn=''${warn:-80}
      declare -A colormap=(
                          [usr]=''${usr_color:-green}
                          [nice]=''${nice_color:-yellow}
                          [sys]=''${sys_color:-red}
                          [iowait]=''${iowait_color:-grey}
                          [irq]=''${irq_color:-purple}
                          [soft]=''${soft_color:-violet}
                          [steal]=''${steal_color:-orange}
                          [guest]=''${guest_color:-cyan}
                          [gnice]=''${gnice_color:-blue}
                          [idle]=''${idle_color:-white}
                          [total]=''${total_color:-white}
                          )
      # If $report_time not set:
      # Set it to $interval - 1, but not less than 1.
      # If $interval is 'repeat' or -2 set report_time to 5.
      if [[ -z $report_time ]]; then
          if [[ "$interval" =~ ^-?[0-9]+$ ]];
          then
              if [[ $interval -gt 2 ]]; then
                  report_time=$(( interval - 1 ))
              elif [[ $interval == -2 ]]; then
                  report_time=5
              else
                  report_time=1
              fi
          elif [[ $interval == repeat ]]; then
              report_time=5
          fi
      fi
      # 'idle' is hardcoded as it's always required, no need to ask for it two times.
      getstats=''${stats//idle /}
      # Get detailed CPU load as a set of variables with same names:
      if _mpstat="$(command -v mpstat)"
      then
          declare $( ''${_mpstat} -u "$report_time" 1 | sed -n '3,4p' | awk -v stats="$getstats idle" '
          BEGIN{
          split(stats, fields)
          }
          {
          split($0, headers)
          getline
          split($0, values)
          for (i in fields) {
              for (j in headers)
              if ( headers[j] ~ "^%" fields[i] ) {
                  printf "%s=%s\n", fields[i], values[j]
              }
          }
          }
          ')
          total=$( bc <<<"scale=2; 100 - $idle" )
      else
          # This is a fallback way for the case `mpstat` is not available
          start_uptime=($(cat /proc/uptime))
          start=($(sed -n '1p' /proc/stat))
          sleep ''${report_time}
          end_uptime=($(cat /proc/uptime))
          end=($(sed -n '1p' /proc/stat))
          user_hz=$(getconf CLK_TCK)
          num_cpus=$(nproc --all)
          delta_time=$( bc <<<"scale=2; ''${end_uptime[0]}-''${start_uptime[0]}" )
          user_hz_time=$( bc <<<"$delta_time * $user_hz" )
          usr=$( bc <<<"scale=4; (''${end[1]}-''${start[1]})/$num_cpus/$user_hz_time*100" )
          nice=$( bc <<<"scale=4; (''${end[2]}-''${start[2]})/$num_cpus/$user_hz_time*100" )
          sys=$( bc <<<"scale=4; (''${end[3]}-''${start[3]})/$num_cpus/$user_hz_time*100" )
          idle=$( bc <<<"scale=4; (''${end[4]}-''${start[4]})/$num_cpus/$user_hz_time*100" )
          iowait=$( bc <<<"scale=4; (''${end[5]}-''${start[5]})/$num_cpus/$user_hz_time*100" )
          irq=$( bc <<<"scale=4; (''${end[6]}-''${start[6]})/$num_cpus/$user_hz_time*100" )
          soft=$( bc <<<"scale=4; (''${end[7]}-''${start[7]})/$num_cpus/$user_hz_time*100" )
          steal=$( bc <<<"scale=4; (''${end[8]}-''${start[8]})/$num_cpus/$user_hz_time*100" )
          guest=$( bc <<<"scale=4; (''${end[9]}-''${start[9]})/$num_cpus/$user_hz_time*100" )
          gnice=$( bc <<<"scale=4; (''${end[10]}-''${start[10]})/$num_cpus/$user_hz_time*100" )
          total=$( bc <<<"scale=4; ''${end_uptime[1]}-''${start_uptime[1]}" )
      fi
      # Output stats with pango formatting in a defined order
      for stat in $stats
      do
          # No other way to make format adjustable
          # shellcheck disable=SC2059
          printf "<span color='%s'>$format</span>" "''${colormap[$stat]}" "''${!stat}"
      done
      echo # trailing newline
      # Short text
      # shellcheck disable=SC2059
      printf "$format\n" "$total"
      # Set urgent flag if over warn threshold
      (( $( bc <<<"$total >= $warn" ) )) && exit 33 || :
    '';
    ".local/libexec/i3blocks/dimmer".executable = true;
    ".local/libexec/i3blocks/dimmer".text = ''
      #!/usr/bin/env bash

      #  dimmer is a script that changes hex color codes to reduce brightness
      #  Copyright (C) 2016 Anton Karmanov <starcom24@gmail.com>
      #
      #  This program is free software: you can redistribute it and/or modify
      #  it under the terms of the GNU General Public License as published by
      #  the Free Software Foundation, either version 3 of the License, or any
      #  later version.
      #
      #  This program is distributed in the hope that it will be useful,
      #  but WITHOUT ANY WARRANTY; without even the implied warranty of
      #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      #  GNU General Public License for more details.
      #
      #  You should have received a copy of the GNU General Public License
      #  along with this program.  If not, see <http://www.gnu.org/licenses/>.

      brightness=50

      if [ -n "$1" ] ; then
        brightness=$1
      fi

      shopt -s nocasematch

      while read -r line
      do

        if
          ! [[ $brightness =~ ^[0-9]+$ ]] || \
            [ "$brightness" -lt 0 ] || \
            [ "$brightness" -gt 100 ]
        then
          >&2 echo "dimmer: Invalid brightness value"
          exit 1
        fi

        if [ ''${#line} -eq 7 ] && [ "''${line:0:1}" = "#" ] &&\
          [[ ''${line:1:6} =~ ^[0-9A-F]{6}$ ]]
        then
          if [ "''${brightness}" -eq 0 ]
          then
            # shellcheck disable=SC2016
            line='$000000'
          else
            colors=("0x''${line:1:2}" "0x''${line:3:2}" "0x''${line:5:2}")
            line='#'
            for color in "''${colors[@]}"; do
              value=$(((color + (100 / brightness - 1)) * brightness / 100))
              color=$(echo "obase=16; ''${value}" | bc)

            # If <= 9 supplement with 0.
            if [ ''${#color} -lt 2 ] ; then
              color="0''${color}"
            fi

            line="$line$color"
          done
          fi
        fi

        echo "$line"
      done
    '';
    ".local/libexec/i3blocks/disk".executable = true;
    ".local/libexec/i3blocks/disk".text = ''
      #!/usr/bin/env sh
      # Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      DIR="''${DIR:-$BLOCK_INSTANCE}"
      DIR="''${DIR:-$HOME}"
      ALERT_LOW="''${ALERT_LOW:-$1}"
      ALERT_LOW="''${ALERT_LOW:-10}" # color will turn red under this value (default: 10%)

      LOCAL_FLAG="-l"
      if [ "$1" = "-n" ] || [ "$2" = "-n" ]; then
          LOCAL_FLAG=""
      fi

      df -h -P $LOCAL_FLAG "$DIR" | awk -v label="$LABEL" -v alert_low=$ALERT_LOW '
      /\/.*/ {
          # full text
          print label $4

          # short text
          print label $4

          use=$5

          # no need to continue parsing
          exit 0
      }

      END {
          gsub(/%$/,"",use)
          if (100 - use < alert_low) {
              # color
              print "#FF0000"
          }
      }
      '
    '';
    ".local/libexec/i3blocks/disk-io".executable = true;
    ".local/libexec/i3blocks/disk-io".text = ''
      #!/usr/bin/env bash
      #
      # Copyright (C) 2016 James Murphy
      # Licensed under the terms of the GNU GPL v2 only.
      #
      # i3blocks blocklet script to monitor disk io

      label="''${LABEL:-""}"
      dt="''${DT:-5}"
      MB_only="''${MB_ONLY:-0}"
      kB_only="''${KB_ONLY:-0}"
      width="''${WIDTH:-4}"
      MB_precision="''${MB_PRECISION:-1}"
      kB_precision="''${KB_PRECISION:-0}"
      regex="''${REGEX:-$BLOCK_INSTANCE}"
      regex="''${regex:-/^(s|h)d[a-zA-Z]+/}"
      threshold="''${THRESHOLD:-0}"
      warn_color="''${WARN_COLOR:-#FF0000}"
      sep="''${SEPARATOR:-/}"
      unit_suffix="''${SUFFIX:-B/s}"
      align="''${ALIGN--}"

      function list_devices {
          echo "Devices iostat reports that match our regex:"
          iostat | awk '$1~/^(s|h)d[a-zA-Z]+/{print $1}'
      }

      while getopts L:t:w:p:P:R:s:ST:C:lLMmKkh opt; do
          case "$opt" in
              L) label="$OPTARG" ;;
              t) dt="$OPTARG" ;;
              w) width="$OPTARG" ;;
              p) kB_precision="$OPTARG" ;;
              P) MB_precision="$OPTARG" ;;
              R) regex="$OPTARG" ;;
              s) sep="$OPTARG" ;;
              S) unit_suffix="" ;;
              T) threshold="$OPTARG" ;;
              C) warn_color="$OPTARG" ;;
              l) list_devices; exit 0 ;;
              M|m) MB_only=1 ;;
              K|k) kB_only=1 ;;
              h) printf \
      "Usage: disk-io [-t time] [-w width] [-p kB_precision] [-P MB_precision] [-R regex] [-s separator] [-S] [-T threshold [-C warn_color]] [-k|-M] [-l] [-h]
      Options:
      -L\tLabel to put in front of the text. Default: $label
      -t\tTime interval in seconds between measurements. Default: $dt
      -w\tThe width of printed floats. Default: $width 
      -p\tThe precision of kB/s floats. Default: $kB_precision 
      -P\tThe precision of MB/s floats. Default: $MB_precision
      -R\tRegex that devices must match. Default: $regex
      -s\tSeparator to put between rates. Default: $sep
      -S\tShort units, omit B/s in kB/s and MB/s.
      -T\tRate in kB/s to exceed to trigger a warning. Default: not enabled
      -C\tColor to change the blocklet to warn the user. Default: $warn_color
      -l\tList devices that iostat reports
      -M\tDo not switch between MB/s and kB/s, use only MB/s
      -k\tDo not switch between MB/s and kB/s, use only kB/s
      -h\tShow this help text
      " && exit 0;;
          esac
      done

      iostat -dyz "$dt" | awk -v sep="$sep" "
          BEGIN {
              rx = wx = 0;
          }
          {
              if(\$0 == \"\") {
                  if ($threshold > 0 && (rx >= $threshold || wx >= $threshold)) {
                      printf \"<span color='$warn_color'>\";
                  }
                  printf \"$label\";
                  if(!$kB_only && ($MB_only || rx >= 1024 || wx >= 1024)) {
                      printf \"%$align$width.''${MB_precision}f%s%$width.''${MB_precision}f M$unit_suffix\", rx/1024, sep, wx/1024;
                  }
                  else {
                      printf \"%$align$width.''${kB_precision}f%s%$width.''${kB_precision}f k$unit_suffix\", rx, sep, wx;
                  }
                  if ($threshold > 0 && (rx >= $threshold || wx >= $threshold)) {
                      printf \"</span>\";
                  }
                  printf \"\n\";
                  fflush(stdout);
              }
              else if(\$1~/^Device:?/) {
                  rx = wx = 0;
              }
              else if(\$1~$regex) {
                  rx += \$3;
                  wx += \$4;
              }
          }"
    '';
    ".local/libexec/i3blocks/disk_usage".executable = true;
    ".local/libexec/i3blocks/disk_usage".text = ''
      #!/usr/bin/env python
      # -*- coding: utf-8 -*-

      # MIT License

      # Copyright (c) 2017 Christian Schläppi

      # Permission is hereby granted, free of charge, to any person obtaining a copy
      # of this software and associated documentation files (the "Software"), to deal
      # in the Software without restriction, including without limitation the rights
      # to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      # copies of the Software, and to permit persons to whom the Software is
      # furnished to do so, subject to the following conditions:

      # The above copyright notice and this permission notice shall be included in all
      # copies or substantial portions of the Software.

      # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      # IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      # FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      # AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      # LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      # OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      # SOFTWARE.

      import os
      import sys
      import subprocess


      def get_disk_stats(mp):
          stat = os.statvfs(mp)

          total = stat.f_blocks * stat.f_frsize / 1024 ** 3
          avail = stat.f_bavail * stat.f_frsize / 1024 ** 3
          used = total - avail

          return {
              'avail': avail,
              'total': total,
              'used': used,
              'perc_used': 100 * used / total
          }


      def launch_ncdu(mp):
          cmd = [
              'sakura',
              '-t',
              'pop-up',
              '-e',
              'ncdu %s' % mp,
              '-x',
          ]

          subprocess.Popen(
              cmd,
              stdout=open(os.devnull, 'w'),
              stderr=subprocess.STDOUT
          )


      def parse_args():
          args = {
              'warn_threshold': 80,
              'crit_threshold': 90,
              'warn_color': '#d6af4e',
              'crit_color': '#d64e4e',
              'format': '{used:.1f}G/{total:.1f}G ({perc_used:.1f}%) -  {avail:.1f}G'
          }

          try:
              for arg in sys.argv[1:]:
                  key, value = arg.split('=')
                  args[key] = int(value) if value.isdigit() else value
          except (KeyError, ValueError):
              # ValuError in case user does something weird
              pass

          return args


      def get_instance():
          p = os.getenv('BLOCK_INSTANCE')
          if p and os.path.exists(p):
              return p

          return os.getenv('HOME')


      def main():

          output_color = '''
          args = parse_args()
          m_point = get_instance()
          stats = get_disk_stats(m_point)

          # get some more info when not called by i3blocks
          if not os.getenv('BLOCK_NAME'):
              print('Args: %s' % args)
              print('Stats: %s' % stats)
              print('Mount Point: %s' % m_point)

          # print stats with format if given
          print(args['format'].format(**stats))
          print()

          # determine color
          if args['crit_threshold'] > int(stats['perc_used']) >= args['warn_threshold']:
              output_color = args['warn_color']
          elif stats['perc_used'] >= args['crit_threshold']:
              output_color = args['crit_color']

          print(output_color)

          # handle click-event
          _button = os.getenv('BLOCK_BUTTON')
          if _button and int(_button) == 1:
              launch_ncdu(m_point)


      if __name__ == '__main__':
          main()
    '';
    ".local/libexec/i3blocks/docker".executable = true;
    ".local/libexec/i3blocks/docker".text = ''
      #!/usr/bin/env bash

      # Number of docker containers running
      count=$(docker ps -q | wc -l | sed -r 's/^0$//g')
      # Recent docker container IP
      recent_ip=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $(docker ps -ql))

      echo "$LABEL$count: $recent_ip"
    '';
    ".local/libexec/i3blocks/dunst".executable = true;
    ".local/libexec/i3blocks/dunst".text = ''
      #!/usr/bin/env python3
      """
      A do-not-disturb button for muting Dunst notifications in i3 using i3blocks

      Mute is handled using the `dunstctl` command.
      """

      __author__ = "Jessey White-Cinis <j@cin.is>"
      __copyright__ = "Copyright (c) 2019 Jessey White-Cinis"
      __license__ = "MIT"
      __version__ = "1.1.0"

      import os
      import subprocess as sp
      import json

      def mute_toggle():
          '''Toggle dunst notifications'''
          sp.run(["dunstctl", "set-paused", "toggle"], check=True)

      def clicked():
          '''Returns True if the button was clicked'''
          button = os.environ.get("BLOCK_BUTTON", None)
          return bool(button)

      def muted():
          '''Returns True if Dunst is muted'''
          output = sp.check_output(('dunstctl', 'is-paused'))
          return u'true' ==  output.strip().decode("UTF-8")

      if clicked():
          # toggle button click to turn mute on and off
          mute_toggle()

      if muted():
          RTN = {"full_text":"<span font='Font Awesome 5 Free Solid' color='#BE616E'>\uf1f6</span>"}
      else:
          RTN = {"full_text":"<span font='Font Awesome 5 Free Solid' color='#A4B98E'>\uf0f3</span>"}

      print(json.dumps(RTN))
    '';
    ".local/libexec/i3blocks/email".executable = true;
    ".local/libexec/i3blocks/email".text = ''
      #!/usr/bin/env python3
      # -*- coding: utf-8 -*-

      # Copyright © 2016 Anton Karmanov <bergentroll@openmailbox.org>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      import configparser
      import subprocess
      import argparse
      import imaplib
      from getpass import getpass
      import os
      try:
          import keyring
          keyring_loaded = True
      except ImportError:
          keyring_loaded = False

      # _Settings____________________________________________________________________

      config = {
          'HOST': 'imap.mail_server.com',
          'PORT': 993,
          'USER': 'my_mailbox@mail_server.com',
          'PASS': ''',
          'URL': 'https://www.mail_server.com'
      }
      # _____________________________________________________________________________


      def get_args():
          parser = argparse.ArgumentParser(
              description='In interactive mode you able to manage your keys.'
          )
          parser.add_argument(
              '-a', '--add', type=str, help='add key to keyring'
          )
          parser.add_argument(
              '-r', '--remove', type=str, help='remove key from keyring'
          )
          args = parser.parse_args()
          if args.add:
              match = False
              while not match:
                  pass_1 = getpass('Type password : ')
                  pass_2 = getpass('Type password again: ')
                  if pass_1 == pass_2:
                      match = True
                      keyring.set_password('i3blocks-email', args.add, pass_1)
                  else:
                      print('\nPasswords do not match!\n')
              return(True)
          elif args.remove:
              ack = input(
                  'Are you sure want to delete key for {}? '.format(args.remove)
              )
              if ack.lower() in ('y', 'yes'):
                  keyring.delete_password('i3blocks-email', args.remove)
              else:
                  print('Cancel.')
              return(True)
          return(False)


      def parse_instance():
          INSTANCE = '''
          try:
              INSTANCE = os.environ['BLOCK_INSTANCE']
          except KeyError:
              pass
          finally:
              if len(INSTANCE):
                  parse_config(INSTANCE)


      def parse_config(INSTANCE):
          global config
          HOME = os.environ['HOME']
          config_file = configparser.ConfigParser()
          CONFIG_PATH = HOME + '/.config/i3blocks-email/' + INSTANCE
          config_file.read(CONFIG_PATH)
          for ITEM in config_file['MAIL']:
              ITEM = ITEM.upper()
              config[ITEM] = config_file['MAIL'][ITEM]


      def get_PASS():
          return(keyring.get_password('i3blocks-email', config['USER']))


      def block_event():
          try:
              event = os.environ['BLOCK_BUTTON']
          except KeyError:
              event = '0'
          if event == '1':
              NULL = open(os.devnull, 'w')
              subprocess.Popen(['xdg-open', config['URL']], stdout=NULL)


      def serf():
          box = imaplib.IMAP4_SSL(host=config['HOST'], port=config['PORT'])
          box.login(config['USER'], config['PASS'])
          box.select()
          result, ids = box.search(None, 'UNSEEN')
          box.logout()
          return(len(ids[0].split()))


      def printer(new_count):
          print(new_count)
          print(new_count)
          if new_count > 0:
              print('#00ff00')
          else:
              print('#ededed')

      if (keyring_loaded and not get_args()) or not keyring_loaded:
          parse_instance()
          block_event()
          if not config['PASS']:
              config['PASS'] = get_PASS()
          printer(serf())
    '';
    ".local/libexec/i3blocks/essid".executable = true;
    ".local/libexec/i3blocks/essid".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2018 borgified <borgified@gmail.com>
      # Copyright (C) 2014 Alexander Keller <github@nycroth.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #------------------------------------------------------------------------

      INTERFACE="''${INTERFACE:-wlan0}"

      #------------------------------------------------------------------------

      # As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
      # connection (think desktop), the corresponding block should not be displayed.
      [[ ! -d /sys/class/net/''${INTERFACE}/wireless ]] ||
          [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]] && exit

      #------------------------------------------------------------------------

      ESSID=$(/sbin/iwconfig $INTERFACE | perl -n -e'/ESSID:"(.*?)"/ && print $1')

      #------------------------------------------------------------------------

      echo $ESSID # full text
      echo $ESSID # short text
    '';
    ".local/libexec/i3blocks/eyedropper".executable = true;
    ".local/libexec/i3blocks/eyedropper".text = ''
      #!/usr/bin/env bash
       
      # Copyright (C) 2021  Max Z. Tan

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      color=$BLOCK_INSTANCE

      if [ -z "''${SWAY}" ]; then
        # sleep to cater to grabc startup time
        sleep 0.5
        value=$(grabc 2>/dev/null)
        if [ "''${CLIPBOARD}" ]; then
          i3-msg -q exec "xclip -sel clip < <(echo -n \\$value)"
        fi
      else
        value=$(grim -g "$(slurp -p -b '#00000000')" -t ppm - \
          | convert - -format '%[pixel:s]' info:- \
          | awk -F '[(,)]' '{printf("#%02x%02x%02x",$2,$3,$4)}')
        if [ "''${CLIPBOARD}" ]; then
          swaymsg -q exec wl-copy "\\$value"
        fi
      fi
      full_text="<span foreground=\"$value\"></span><span foreground=\"$color\">$value</span>"

      echo $full_text
    '';
    ".local/libexec/i3blocks/github".executable = true;
    ".local/libexec/i3blocks/github".text = ''
      #!/usr/bin/env python3
      """
      A Github block for displaying notifications in i3 using i3blocks
      """

      __author__ = "Adin Hodovic <hodovicadin@gmail.com>"
      __copyright__ = "Copyright (c) 2020 Adin Hodovic"
      __license__ = "MIT"
      __version__ = "1.0.0"

      import json
      import os
      import webbrowser


      def get_notifications():
          notifications = len(json.loads(os.popen("gh api notifications").read()))

          if notifications > 0:
              return {
                  "full_text": f"<span font='Font Awesome 5 Free Solid'>&#xf09b; {notifications}</span>"
              }
          return {"full_text": "<span font='Font Awesome 5 Free Solid'>&#xf09b;</span>"}


      def clicked():
          """Returns True if the button was clicked"""
          button = "BLOCK_BUTTON" in os.environ and os.environ["BLOCK_BUTTON"]
          return bool(button)


      if clicked():
          webbrowser.open("https://github.com/notifications")

      print(json.dumps(get_notifications()))
    '';
    ".local/libexec/i3blocks/go".executable = true;
    ".local/libexec/i3blocks/go".text = ''
      #!/usr/bin/env bash

      go version 2>/dev/null | awk '{ gsub("go", ""); print $2 }'
    '';
    ".local/libexec/i3blocks/gpu-load".executable = true;
    ".local/libexec/i3blocks/gpu-load".text = ''
      #!/usr/bin/env perl

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      use strict;
      use warnings;
      use utf8;
      use Getopt::Long;

      # default values
      my $t_warn = $ENV{T_WARN} || 70;
      my $t_crit = $ENV{T_CRIT} || 90;
      my $gpu_brand = $ENV{GPU_BRAND} || "NVIDIA";
      my $gpu_usage = -1;
      my $gpu_mem = -1;
      my $gpu_video = -1;
      my $gpu_pcie = -1;

      my $full_text = "";

      sub help {
          print "Usage: gpu-load [-w <warning>] [-c <critical>]\n";
          print "-w <percent>: warning threshold to become amber\n";
          print "-c <percent>: critical threshold to become red\n";
          exit 0;
      }

      GetOptions("help|h" => \&help,
                 "w=i"    => \$t_warn,
                 "c=i"    => \$t_crit);

      # Get GPU usage from nvidia-settings
      if ($gpu_brand eq "NVIDIA") {
          open (NVS, 'nvidia-settings -q GPUUtilization -t |') or die;
          while (<NVS>) {
              if (/^[a-zA-Z]*=(\d+), [a-zA-Z]*=(\d+), [a-zA-Z]*=(\d+), [a-zA-Z]*=(\d+)$/) {
                  $gpu_usage = $1;
                  $gpu_mem = $2;
                  $gpu_video = $3;
                  $gpu_pcie = $4;
                  last;
              }
          }
          close(NVS);
          $full_text = sprintf "%.0f%% %.0f%% %.0f%% %.0f%%\n", $gpu_usage, $gpu_mem, $gpu_video, $gpu_pcie;
      } 

      # For AMD, get from radeontop
      elsif ($gpu_brand eq "AMD") {
          open (AMD, 'radeontop -d - -l 1 |') or die;
          while (<AMD>) {
              if (/^.*[gpu] (\d+)\.\d+%.*.*[vram] (\d+)\.\d+%.*$/) {
                  $gpu_usage = $1;
                  $gpu_mem = $2;
                  last;
              }
          }
          close(AMD);
          $full_text = sprintf "%.0f%% %.0f%%\n", $gpu_usage, $gpu_mem;
      }

      $gpu_usage eq -1 and die 'Can\'t find GPU information';

      # Print full_text, short_text
      print $full_text;
      printf "%.0f%%\n", $gpu_usage;

      # Print color, if needed
      if ($gpu_usage >= $t_crit || $gpu_mem >= $t_crit || $gpu_video >= $t_crit || $gpu_pcie >= $t_crit) {
          print "#FF0000\n";
          exit 33;
      } elsif ($gpu_usage >= $t_warn || $gpu_mem >= $t_warn || $gpu_video >= $t_warn || $gpu_pcie >= $t_warn) {
          print "#FFBF00\n";
      }

      exit 0;
    '';
    ".local/libexec/i3blocks/i3-focusedwindow".executable = true;
    ".local/libexec/i3blocks/i3-focusedwindow".text = ''
      #!/usr/bin/env bash
      # Author: Kn

      while :
      do
        ID=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
        if [[ $1 ]] 
        then
          TITLE=$(xprop -id $ID -len $1 | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
          echo "$TITLE"
        else
          TITLE=$(xprop -id $ID | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
          echo "$TITLE"
        fi
      done
    '';
    ".local/libexec/i3blocks/iface".executable = true;
    ".local/libexec/i3blocks/iface".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
      # Copyright (C) 2014 Alexander Keller <github@nycroth.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #------------------------------------------------------------------------

      # Use the provided interface, otherwise the device used for the default route.
      IF="''${IFACE:-$BLOCK_INSTANCE}"
      IF="''${IF:-$(ip route | awk '/^default/ { print $5 ; exit }')}"

      # Exit if there is no default route
      [[ -z "$IF" ]] && exit

      #------------------------------------------------------------------------

      # As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
      # connection (think desktop), the corresponding block should not be displayed.
      [[ ! -d /sys/class/net/''${IF} ]] && exit

      #------------------------------------------------------------------------

      AF=''${ADDRESS_FAMILY:-inet6?}
      LABEL="''${LABEL:-}"

      for flag in "$1" "$2"; do
        case "$flag" in
          -4)
            AF=inet ;;
          -6)
            AF=inet6 ;;
          -L)
            if [[ "$IF" = "" ]]; then
              LABEL="iface"
            else
              LABEL="$IF:"
            fi ;;
        esac
      done

      if [[ "$IF" = "" ]] || [[ "$(cat /sys/class/net/$IF/operstate)" = 'down' ]]; then
        echo "''${LABEL} down" # full text
        echo "''${LABEL} down" # short text
        echo \#FF0000 # color
        exit
      fi

      # if no interface is found, use the first device with a global scope
      IPADDR=$(ip addr show $IF | perl -n -e "/$AF ([^ \/]+).* scope global/ && print \$1 and exit")

      case $BLOCK_BUTTON in
        3) echo -n "$IPADDR" | xclip -q -se c ;;
      esac

      if [[ "''${display_wifi_name}" == "1" ]];
      then
        # try to guess the wifi name
        if command -v iw > /dev/null && iw $IF info > /dev/null 2>&1;
        then
          WIFI_NAME=$(iw $IF info | grep -Po '(?<=ssid ).*' | tr -d " \t\n\r")

          if [[ $BLOCK_BUTTON -eq 1 ]];
          then
            message="$LABEL $WIFI_NAME ($IPADDR)"
          else
            message="$LABEL $WIFI_NAME"
          fi
        else
          message="$LABEL $IPADDR"
        fi
      else
        message="$LABEL $IPADDR"
      fi

      #------------------------------------------------------------------------

      echo "$message"
    '';
    ".local/libexec/i3blocks/kbdd_layout".executable = true;
    ".local/libexec/i3blocks/kbdd_layout".text = ''
      #!/usr/bin/env bash
      #
      # kbdd_layout is a script that parse layout with kbdd in real time
      # Copyright (C) 2016,2019 Anton Karmanov <bergentroll@insiberia.net>
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or any
      # later version.
      #
      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.
      #
      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      # Matches first 3 letters of layout name.
      MATCH='\w{3}'

      # Matches short layout name.
      #MATCH='\w*'

      # Matches full layout name.
      #MATCH='\w*(\s\(.*\))?'

      # Restart kbdd to apply layout changes on block reload.
      killall kbdd 2>/dev/null
      kbdd >/dev/null || exit 1

      # Get initial state of layout
      N=$( dbus-send --print-reply=literal --dest=ru.gentoo.KbddService\
          /ru/gentoo/KbddService ru.gentoo.kbdd.getCurrentLayout 2>/dev/null |\
          sed -un 's/^.*uint32 //p' )

      # In case dbus service wasn't available yet, poll until service is ready.
      while [[ -z "$N" ]]; do
          sleep .1
          N=$( dbus-send --print-reply=literal --dest=ru.gentoo.KbddService\
              /ru/gentoo/KbddService ru.gentoo.kbdd.getCurrentLayout 2>/dev/null |\
              sed -un 's/^.*uint32 //p' )
      done
      dbus-send --print-reply=literal --dest=ru.gentoo.KbddService \
        /ru/gentoo/KbddService ru.gentoo.kbdd.getLayoutName uint32:"$N" |\
        grep -Po "''${MATCH}" | head -n1

      # Parse dbus output.
      dbus-monitor "interface='ru.gentoo.kbdd',member='layoutNameChanged'" |\
        grep -Po --line-buffered "(?<=string \")''${MATCH}"
    '';
    ".local/libexec/i3blocks/keyindicator".executable = true;
    ".local/libexec/i3blocks/keyindicator".text = ''
      #!/usr/bin/env perl
      #
      # Copyright 2014 Marcelo Cerri <mhcerri at gmail dot com>
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.
      #
      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.
      #
      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      use strict;
      use warnings;
      use utf8;
      use Getopt::Long;
      use File::Basename;

      # Default values
      my $indicator = $ENV{BLOCK_INSTANCE} || $ENV{KEY} || "CAPS";
      my $text_on = $ENV{TEXT_ON} || $indicator;
      my $text_off = $ENV{TEXT_OFF} || $indicator;
      my $color_on  = $ENV{COLOR_ON} || "#00FF00";
      my $color_off = $ENV{COLOR_OFF} || "#222222";
      my $bg_color_on = $ENV{BG_COLOR_ON};
      my $bg_color_off = $ENV{BG_COLOR_OFF};
      my $hide      = $ENV{HIDE_WHEN_OFF} || 0;

      sub help {
          my $program = basename($0);
          printf "Usage: %s [-c <color on>] [-C <color off>] [-b <bg color on>] [-B <bg color off>] [--hide]\n", $program;
          printf "  -c <color on>: hex color to use when indicator is on\n";
          printf "  -C <color off>: hex color to use when indicator is off\n";
          printf "  -b <background color on>: hex color to use when indicator is on\n";
          printf "  -B <background color off>: hex color to use when indicator is off\n";
          printf "  --hide: don't output anything when indicator is off\n";
          printf "\n";
          printf "Note: environment variable \$BLOCK_INSTANCE should be one of:\n";
          printf "  CAPS, NUM (default is CAPS).\n";
          exit 0;
      }

      Getopt::Long::config qw(no_ignore_case);
      GetOptions("help|h" => \&help,
                 "c=s"    => \$color_on,
                 "C=s"    => \$color_off,
                 "b=s"    => \$bg_color_on,
                 "B=s"    => \$bg_color_off,
                 "hide"   => \$hide) or exit 1;

      # Key mapping
      my %indicators = (
          CAPS => 0x00000001,
          NUM  => 0x00000002,
      );

      # Retrieve key flags
      my $mask = 0;
      open(XSET, "xset -q |") or die;
      while (<XSET>) {
          if (/LED mask:\s*([0-9a-f]+)/) {
              $mask = hex $1;
              last;
          }
      }
      close(XSET);

      # Determine if indicator is on or off
      my $indicator_status = ($indicators{$indicator} || 0) & $mask;

      # Exit if --hide and indicator is off
      if ($hide and !$indicator_status) {
          exit 0
      }

      # Output
      $indicator = $indicator_status ? $text_on : $text_off;
      my $fg_color = $indicator_status ? $color_on : $color_off;
      my $bg_color = $indicator_status ? $bg_color_on : $bg_color_off;

      if (defined $bg_color) {
          printf "<span color='%s' bgcolor='%s'>%s</span>\n", $fg_color, $bg_color, $indicator;
      } else {
          printf "<span color='%s'>%s</span>\n", $fg_color, $indicator;
      }

      exit 0
    '';
    ".local/libexec/i3blocks/key_layout".executable = true;
    ".local/libexec/i3blocks/key_layout".text = ''
      #!/usr/bin/env bash

      # Copyright 2016 Patrick Haun
      # Edited: Denis Kadyshev
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      setxkbmap -query | awk '
          BEGIN{layout="";variant=""}
          /^layout/{layout=$2}
          /^variant/{variant=" ("$2")"}
          END{printf("%s%s",layout,variant)}'
    '';
    ".local/libexec/i3blocks/key_light".executable = true;
    ".local/libexec/i3blocks/key_light".text = ''
      #!/usr/bin/env bash

      # Copyright 2019 Matej Čamaj <camaj at protonmail dot com>
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      # See https://upower.freedesktop.org/docs/KbdBacklight.html
      function get_brightness {
          dbus-send --system --type=method_call --print-reply\
              --dest="org.freedesktop.UPower" \
              "/org/freedesktop/UPower/KbdBacklight" \
              "org.freedesktop.UPower.KbdBacklight.$1" \
              |  awk 'FNR==2{print $2}'
      }

      brightness=$(get_brightness "GetBrightness")
      max_brightness=$(get_brightness "GetMaxBrightness")

      if [ "$brightness" -eq "$max_brightness" ]; then
         new_brightness=0
      else
         new_brightness=$((brightness + 1))
      fi

      dbus-send --system --type=method_call \
          --dest="org.freedesktop.UPower" \
          "/org/freedesktop/UPower/KbdBacklight" \
          "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$new_brightness
    '';
    ".local/libexec/i3blocks/kubernetes".executable = true;
    ".local/libexec/i3blocks/kubernetes".text = ''
      #!/usr/bin/env bash
      KCONTEXT=$(kubectl config current-context 2>/dev/null)
      if [[ $?=="0" ]]; then
          CC=$(kubectl config view -ojsonpath='{..current-context}')
          KNAMESPACE=$(kubectl config view -ojsonpath="{.Contexts[?(@.Name==\"$CC\")]..namespace}")
          echo "☸ $KCONTEXT/$KNAMESPACE ☸"
          echo "☸ $KCONTEXT/$KNAMESPACE ☸"
          echo \#4040FF # color
      fi
    '';
    ".local/libexec/i3blocks/load_average".executable = true;
    ".local/libexec/i3blocks/load_average".text = ''
      #!/usr/bin/env sh
      # Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      load="$(cut -d ' ' -f1 /proc/loadavg)"
      cpus="$(nproc)"

      # full text
      echo "$load"

      # short text
      echo "$load"

      # color if load is too high
      awk -v cpus=$cpus -v cpuload=$load '
          BEGIN {
              if (cpus <= cpuload) {
                  print "#FF0000";
                  exit 33;
              }
          }
      '
    '';
    ".local/libexec/i3blocks/load-status".executable = true;
    ".local/libexec/i3blocks/load-status".text = ''
      #!/usr/bin/env bash

      # Change this according to your devices
      loadavg_1min=$(cat /proc/loadavg | awk -F ' ' '{print $1}')
      loadavg_5min=$(cat /proc/loadavg | awk -F ' ' '{print $2}')
      loadavg_15min=$(cat /proc/loadavg | awk -F ' ' '{print $3}')
      #load_icon="<span font='icon'>🏋</span>" # work icon (weightlifter)
      #load_icon=$'\U0001F3CB' # work icon (weightlifter)
      load_icon="<span font='icon'></span>" # microchip icon
      #load_icon=$'\uF2DB' # microchip icon

      echo "$load_icon $loadavg_1min $loadavg_5min $loadavg_15min"
      echo "$load_icon $loadavg_1min"

      exit 0
    '';
    ".local/libexec/i3blocks/mediaplayer".executable = true;
    ".local/libexec/i3blocks/mediaplayer".text = ''
      #!/usr/bin/env perl
      # Copyright (C) 2014 Tony Crisci <tony@dubstepdish.com>
      # Copyright (C) 2015 Thiago Perrotta <perrotta dot thiago at poli dot ufrj dot br>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      # For all media players except mpd/cmus/rhythmbox, MPRIS support should be
      # enabled and the playerctl binary should be in your path.
      # See https://github.com/acrisci/playerctl

      # Set instance=NAME in the i3blocks configuration to specify a music player
      # (playerctl will attempt to connect to org.mpris.MediaPlayer2.[NAME] on your
      # DBus session). If instance is empty, playerctl will connect to the first
      # supported media player it finds.

      use Time::HiRes qw(usleep);
      use Env qw(BLOCK_INSTANCE);

      use constant DELAY => 50; # Delay in ms to let network-based players (spotify) reflect new data.
      use constant SPOTIFY_STR => 'spotify';

      my @metadata = ();
      my $player_arg = "";

      if ($BLOCK_INSTANCE) {
          $player_arg = "--player='$BLOCK_INSTANCE'";
      }

      sub buttons {
          my $method = shift;

          if($method eq 'mpd') {
              if ($ENV{'BLOCK_BUTTON'} == 1) {
                  system("mpc prev &>/dev/null");
              } elsif ($ENV{'BLOCK_BUTTON'} == 2) {
                  system("mpc toggle &>/dev/null");
              } elsif ($ENV{'BLOCK_BUTTON'} == 3) {
                  system("mpc next &>/dev/null");
              } elsif ($ENV{'BLOCK_BUTTON'} == 4) {
                  system("mpc volume +10 &>/dev/null");
              } elsif ($ENV{'BLOCK_BUTTON'} == 5) {
                  system("mpc volume -10 &>/dev/null");
              }
          } elsif ($method eq 'cmus') {
              if ($ENV{'BLOCK_BUTTON'} == 1) {
                  system("cmus-remote --prev");
              } elsif ($ENV{'BLOCK_BUTTON'} == 2) {
                  system("cmus-remote --pause");
              } elsif ($ENV{'BLOCK_BUTTON'} == 3) {
                  system("cmus-remote --next");
              }
          } elsif ($method eq 'playerctl') {
              if ($ENV{'BLOCK_BUTTON'} == 1) {
                  system("playerctl $player_arg previous");
                  usleep(DELAY * 1000) if $BLOCK_INSTANCE eq SPOTIFY_STR;
              } elsif ($ENV{'BLOCK_BUTTON'} == 2) {
                  system("playerctl $player_arg play-pause");
              } elsif ($ENV{'BLOCK_BUTTON'} == 3) {
                  system("playerctl $player_arg next");
                  usleep(DELAY * 1000) if $BLOCK_INSTANCE eq SPOTIFY_STR;
              } elsif ($ENV{'BLOCK_BUTTON'} == 4) {
                  system("playerctl $player_arg volume 0.01+");
              } elsif ($ENV{'BLOCK_BUTTON'} == 5) {
                  system("playerctl $player_arg volume 0.01-");
              }
          } elsif ($method eq 'rhythmbox') {
              if ($ENV{'BLOCK_BUTTON'} == 1) {
                  system("rhythmbox-client --previous");
              } elsif ($ENV{'BLOCK_BUTTON'} == 2) {
                  system("rhythmbox-client --play-pause");
              } elsif ($ENV{'BLOCK_BUTTON'} == 3) {
                  system("rhythmbox-client --next");
              }
          }
      }

      sub cmus {
          my @cmus = split /^/, qx(cmus-remote -Q);
          if ($? == 0) {
              foreach my $line (@cmus) {
                  my @data = split /\s/, $line;
                  if (shift @data eq 'tag') {
                      my $key = shift @data;
                      my $value = join ' ', @data;

                      @metadata[0] = $value if $key eq 'artist';
                      @metadata[1] = $value if $key eq 'title';
                  }
              }

              if (@metadata) {
                  buttons('cmus');

                  # metadata found so we are done
                  print(join ' - ', @metadata);
                  print("\n");
                  exit 0;
              }
          }
      }

      sub mpd {
          my $data = qx(mpc current);
          if (not $data eq ''') {
              buttons("mpd");
              print($data);
              exit 0;
          }
      }

      sub playerctl {
          buttons('playerctl');

          my $artist = qx(playerctl $player_arg metadata artist 2>/dev/null);
          chomp $artist;
          # exit status will be nonzero when playerctl cannot find your player
          exit(0) if $? || $artist eq '(null)';

          push(@metadata, $artist) if $artist;

          my $title = qx(playerctl $player_arg metadata title);
          exit(0) if $? || $title eq '(null)';

          push(@metadata, $title) if $title;

          print(join(" - ", @metadata)) if @metadata;
      }

      sub rhythmbox {
          buttons('rhythmbox');

          my $data = qx(rhythmbox-client --print-playing --no-start);
          print($data);
      }

      if ($player_arg =~ /mpd/) {
          mpd;
      }
      elsif ($player_arg =~ /cmus/) {
          cmus;
      }
      elsif ($player_arg =~ /rhythmbox/) {
          rhythmbox;
      }
      else {
          playerctl;
      }
      print("\n");

    '';
    ".local/libexec/i3blocks/mediaplayer-status".executable = true;
    ".local/libexec/i3blocks/mediaplayer-status".text = ''
      #!/usr/bin/env bash
      #
      ## Change this according to your devices

      playing_symbol="⏵" # black triangle pointing right (play)
      paused_symbol="⏸" # double bar (paused)
      stopped_symbol="⏹" # black square
      audio_symbol="🎧" # headphones

      media_artist=$(sed -e 's/\&/and/' <<<$(playerctl metadata artist))
      media_song=$(sed -e 's/\&/and/' <<<$(playerctl metadata title))
      position=$(playerctl position --format "{{ duration(position) }}")
      duration=$(playerctl metadata --format "{{ duration(mpris:length) }}")
      player_status=$(playerctl status)
      if [ "$player_status" = "Playing" ]; then
          song_status="$playing_symbol" # black triangle pointing right (play)
      elif [ "$player_status" = "Paused" ]; then
          song_status="$paused_symbol"
      else
          song_status="$stopped_symbol" # black square (stopped)
      fi
      audio_icon="$audio_symbol" # headphone

      echo "$audio_icon $song_status $media_artist - $media_song ($position/$duration)"
      echo "$media_artist - $media_song"

      exit 0
    '';
    ".local/libexec/i3blocks/memory".executable = true;
    ".local/libexec/i3blocks/memory".text = ''
      #!/usr/bin/env sh
      # Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      TYPE="''${BLOCK_INSTANCE:-mem}"
      PERCENT="''${PERCENT:-true}"

      awk -v type=$TYPE -v percent=$PERCENT '
      /^MemTotal:/ {
          mem_total=$2
      }
      /^MemFree:/ {
          mem_free=$2
      }
      /^Buffers:/ {
          mem_free+=$2
      }
      /^Cached:/ {
          mem_free+=$2
      }
      /^SwapTotal:/ {
          swap_total=$2
      }
      /^SwapFree:/ {
          swap_free=$2
      }
      END {
          if (type == "swap") {
              free=swap_free/1024/1024
              used=(swap_total-swap_free)/1024/1024
              total=swap_total/1024/1024
          } else {
              free=mem_free/1024/1024
              used=(mem_total-mem_free)/1024/1024
              total=mem_total/1024/1024
          }

          pct=0
          if (total > 0) {
              pct=used/total*100
          }

          # full text
          if (percent == "true" ) {
              printf("%.1fG/%.1fG (%.f%%)\n", used, total, pct)
          } else {
              printf("%.1fG/%.1fG\n", used, total)
          }
          # short text
          printf("%.f%%\n", pct)

          # color
          if (pct > 90) {
              print("#FF0000")
          } else if (pct > 80) {
              print("#FFAE00")
          } else if (pct > 70) {
              print("#FFF600")
          }
      }
      ' /proc/meminfo
    '';
    ".local/libexec/i3blocks/memory-status".executable = true;
    ".local/libexec/i3blocks/memory-status".text = ''
      #!/usr/bin/env bash

      # Change this according to your devices

      # Memory
      total_memory_kb=$(grep -i "memtotal" /proc/meminfo |  grep -o '[[:digit:]]*')
      total_memory_gb=$(printf "%.2f\n" $(echo "$total_memory_kb/1048576" | bc -l))
      available_memory_kb=$(grep -i "memavailable" /proc/meminfo |  grep -o '[[:digit:]]*')
      available_memory_gb=$(printf "%.2f\n" $(echo "$available_memory_kb/1048576" | bc -l))
      used_memory_kb=$(echo "$total_memory_kb-$available_memory_kb" | bc -l)
      used_memory_gb=$(printf "%.2f\n" $(echo "$used_memory_kb/1048576" | bc -l))
      used_memory_percentage=$(printf "%.2f\n" $(echo "($used_memory_kb/$total_memory_kb)*100" | bc -l))
      memory_icon="<span font='icon'></span>" # DIMM icon
      #memory_icon=$'\uF538' # DIMM icon

      echo "$memory_icon $used_memory_gb"'GiB'"/$total_memory_gb"'GiB'" ($used_memory_percentage%)"
      echo "$memory_icon $used_memory_percentage%"

      exit 0
    '';
    ".local/libexec/i3blocks/metars".executable = true;
    ".local/libexec/i3blocks/metars".text = ''
      #!/usr/bin/env python3

      # Required steps before running this scripts:
      # > sudo pip install python-metar
      # > sudo pacman -S libnotify
      # Possibly also:
      # > sudo pacman -S dunst

      import os
      import sys
      # Let's use json here for performance reasons:
      # https://stackoverflow.com/questions/988228/convert-a-string-representation-of-a-dictionary-to-a-dictionary
      import json
      import datetime
      import subprocess
      import urllib.request
      from metar import Metar

      class MetarsSettingsEnvironment:
          def isConfigured(self):
              # return True
              if not 'METARSSTATION' in os.environ:
                  return False
              if not 'METARSURL' in os.environ:
                  return False
              if not 'METARSENABLEMENTS' in os.environ:
                  return False
              if not 'METARSCONFIGS' in os.environ:
                  return False
              return True
          def extractAndUnpack(self, settings):
              try:
                  extracted = json.loads(settings)
              except Exception as e:
                  print('METARS extract 1: {}'.format(e))
                  sys.exit(1)
              for k, v in extracted.items():
                  try:
                      setattr(self, k, v)
                  except Exception as e:
                      print('METARS extract 2: {}'.format(e))
                      sys.exit(1)
          def extract(self):
              self.station = os.environ['METARSSTATION']
              self.metarurl = os.environ['METARSURL']
              enablements = os.environ['METARSENABLEMENTS']
              configs = os.environ['METARSCONFIGS']
              # self.station = 'EFHK'
              # self.metarurl = 'https://tgftp.nws.noaa.gov/data/observations/metar/stations/{}.TXT'
              # enablements = '{ "temperature": true, "dewpoint" : false, "feelsLike" : true, "wind" : true, "pressure" : false, "visibility" : false, "windDirType" : "icon", "useInverseWind" : false }'
              # configs = '{ "temperatureUnit" : "C", "temperatureSym" : "°C", "pressureUnit" : "HPA", "pressureSym" : "hPa", "speedUnit" : "MPS", "speedSym" : "m/s", "distanceUnit" : "KM", "distanceSym" : "km", "precipitationUnit" : "CM", "precipitationSym" : "cm"}'
              self.extractAndUnpack(enablements)
              self.extractAndUnpack(configs)

      class Metars:
          obs = {}
          settings = None
          metarurl = 'https://tgftp.nws.noaa.gov/data/observations/metar/stations/{}.TXT'
          def __init__(self, settings):
              self.settings = settings
          def runCommand(self, command):
              retCode = 0
              retText = '''
              try:
                  retText = subprocess.check_output(command, shell=True).decode('UTF-8')
              except subprocess.CalledProcessError as e:
                  retCode = e.returncode
                  retText = e.output.decode('UTF-8')
              except:
                  retCode = -999
                  retText = 'ERROR: Unknown exception.'
              return retCode, retText
          def getChillMetric(self, temp, velocity):  # temp = C, velocity = km/h
              if temp > 10.0 or velocity <= 4.8:
                  return None
              expt = velocity ** 0.16
              twc = 13.12 + (0.6215 * temp) - (11.37 * expt) + (0.3965 * temp * expt)
              return twc
          def convertCelciusTo(self, temp):
              if self.settings.temperatureUnit == 'C':
                  return temp
              elif self.settings.temperatureUnit == 'F':
                  return (temp * 1.8) + 32
              elif self.settings.temperatureUnit == 'K':
                  return temp + 273.15
              print('METARS: Unknown unit "{}"'.format(self.settings.temperatureUnit))
              sys.exit(1)
          def createIconWindDirection(self, obs):
              angle = obs.wind_dir.value()
              if angle >= 337.5 and angle < 22.5:     # N
                  if self.settings.useInverseWind:
                      return '↓'
                  else:
                      return '↑'
              elif angle >= 22.5 and angle < 67.5:    # NE
                  if self.settings.useInverseWind:
                      return '↙'
                  else:
                      return '↗'
              elif angle >= 67.5 and angle < 112.5:   # E
                  if self.settings.useInverseWind:
                      return '←'
                  else:
                      return '→'
              elif angle >= 112.5 and angle < 157.5:  # SE
                  if self.settings.useInverseWind:
                      return '↖'
                  else:
                      return '↘'
              elif angle >= 157.5 and angle < 202.5:  # S
                  if self.settings.useInverseWind:
                      return '↑'
                  else:
                      return '↓'
              elif angle >= 202.5 and angle < 247.5:  # SW
                  if self.settings.useInverseWind:
                      return '↗'
                  else:
                      return '↙'
              elif angle >= 247.5 and angle < 292.5:  # W
                  if self.settings.useInverseWind:
                      return '→'
                  else:
                      return '←'
              else:  # angle >= 292.5 and angle < 337.5  # NW
                  if self.settings.useInverseWind:
                      return '↘'
                  else:
                      return '↖'
              print('METARS: This should not happen')
              sys.exit(1)
          def createTextWindDirection(self, obs):
              compass = obs.wind_dir.compass()
              if not self.settings.useInverseWind:
                  return compass
              if compass == 'N':
                  return 'S'
              elif compass == 'NNE':
                  return 'SSW'
              elif compass == 'NE':
                  return 'SW'
              elif compass == 'ENE':
                  return 'WSW'
              elif compass == 'E':
                  return 'W'
              elif compass == 'ESE':
                  return 'WNW'
              elif compass == 'SE':
                  return 'NW'
              elif compass == 'SSE':
                  return 'NNW'
              elif compass == 'S':
                  return 'N'
              elif compass == 'SSW':
                  return 'NNE'
              elif compass == 'SW':
                  return 'NE'
              elif compass == 'WSW':
                  return 'ENE'
              elif compass == 'W':
                  return 'E'
              elif compass == 'WNW':
                  return 'ESE'
              elif compass == 'NW':
                  return 'SE'
              elif compass == 'NNW':
                  return 'SSE'
              print('METARS: This should not happen')
              sys.exit(1)
          def createAngleWindDirection(self, obs):
              angle = obs.wind_dir.value()
              if self.settings.useInverseWind:
                  angle += 180
                  if angle >= 360:
                      angle -= 360
              return '{}°'.format(angle)
          def createWindDirection(self, obs):
              # https://www.wpc.ncep.noaa.gov/dailywxmap/plottedwx.html
              # "The wind direction is plotted as the shaft of an arrow extending from the
              # station circle toward the direction from which the wind is blowing"
              # Here "inverse" may be more natural for modern users, showing the wind
              # as "from-to" arrow
              if self.settings.windDirType == 'angle':
                  direction = self.createAngleWindDirection(obs)
              elif self.settings.windDirType == 'text':
                  direction = self.createTextWindDirection(obs)
              elif self.settings.windDirType == 'icon':
                  direction = self.createIconWindDirection(obs)
              else:
                  print('METARS: Unknown wind direction type "{}"'.format(self.settings.windDirType))
                  sys.exit(1)
              return direction
          def extractObservations(self, obs):
              if obs.station_id:
                  self.obs['station_id'] = obs.station_id
              if obs.time:
                  self.obs['time'] = obs.time.isoformat()
              if obs.cycle:
                  self.obs['cycle'] = obs.cycle
              if obs.wind_dir:
                  self.obs['wind_dir'] = self.createWindDirection(obs)
              if obs.wind_speed:
                  speed = obs.wind_speed.value(self.settings.speedUnit)
                  self.obs['wind_speed'] = '{} {}'.format(round(speed), self.settings.speedSym)
              if obs.wind_gust:
                  speedgust = obs.wind_gust.value(self.settings.speedUnit)
                  self.obs['wind_gust'] = '{} {}'.format(round(speedgust), self.settings.speedSym)
              if obs.vis:
                  distance = obs.vis.value(self.settings.distanceUnit)
                  self.obs['vis'] = '{} {}'.format(round(distance), self.settings.distanceSym)
              if obs.temp:
                  temp = obs.temp.value(self.settings.temperatureUnit)
                  self.obs['temp'] = '{} {}'.format(round(temp,1), self.settings.temperatureSym)
              if obs.dewpt:
                  dewpt = obs.dewpt.value(self.settings.temperatureUnit)
                  self.obs['dewpt'] = '{} {}'.format(round(dewpt,1), self.settings.temperatureSym)
              if obs.press:
                  pressure = obs.press.value(self.settings.pressureUnit)
                  self.obs['press'] = '{} {}'.format(round(pressure), self.settings.pressureSym)
              if 'temp' in self.obs:
                  tempInCelsius = obs.temp.value('C')
                  if 'wind_speed' in self.obs:
                      speedInKmh = obs.wind_speed.value('KMH')
                      metricChill = self.getChillMetric(tempInCelsius, speedInKmh)
                      if metricChill != None:
                          twc = self.convertCelciusTo(metricChill)
                          self.obs['twc'] = '{} {}'.format(round(twc,1), self.settings.temperatureSym)
                  if 'wind_gust' in self.obs:
                      speedInKmh = obs.wind_gust.value('KMH')
                      metricChill = self.getChillMetric(tempInCelsius, speedInKmh)
                      if metricChill != None:
                          twc = self.convertCelciusTo(metricChill)
                          self.obs['twcgust'] = '{} {}'.format(round(twc,1), self.settings.temperatureSym)
              # print(self.obs)
          def getStationData(self, station):
              metarurl = self.metarurl.format(station)
              try:
                  page = urllib.request.urlopen(metarurl)
                  readPage = page.read()
              except Exception as e:
                  print('METARS url fetch: {}.'.format(e))
                  sys.exit(1)
              stationData = str(readPage).split('\\n')
              return stationData
          def processMetars(self, blockSelect):
              metars = self.getStationData(self.settings.station)
              for metar in metars:
                  self.obs.clear()
                  # metar = 'METAR KEWR 111851Z VRB03G19KT 2SM R04R/3000VP6000FT TSRA BR FEW015 BKN040CB BKN065 OVC200 22/22 A2987 RMK AO2 PK WND 29028/1817 WSHFT 1812 TSB05RAB22 SLP114 FRQ LTGICCCCG TS OHD AND NW -N-E MOV NE P0013 T02270215'
                  try:
                      obs = Metar.Metar(metar)
                      if blockSelect:
                          cmd = '${pkgs.libnotify}/bin/notify-send -t 0 "{}"'.format(obs)
                          self.runCommand(cmd)
                      self.extractObservations(obs)
                      weather = self.createWeatherString(obs)
                      print(weather)
                  except Metar.ParserError as e:
                      pass
          def createWeatherString(self, obs):
              weather = '''
              if 'station_id' in self.obs:
                  weather += self.obs['station_id'] + ':'
              else:
                  weather += '?:'
              if self.settings.temperature:
                  if 'temp' in self.obs:
                      weather += ' ' + self.obs['temp']
              if self.settings.dewpoint:
                  if 'dewpt' in self.obs:
                      weather += ' dewpt ' + self.obs['dewpt']
              if self.settings.feelsLike:
                  if 'twc' in self.obs:
                      weather += ' feels ' + self.obs['twc']
                  if 'twcgust' in self.obs:
                      weather += ' gustfeels ' + self.obs['twcgust']
              if self.settings.wind:
                  if 'wind_dir' in self.obs or 'wind_speed' in self.obs:
                      weather += ' wind'
                  if 'wind_dir' in self.obs:
                      weather += ' ' + self.obs['wind_dir']
                  if 'wind_dir' in self.obs and 'wind_speed' in self.obs:
                      weather += ' at'
                  if 'wind_speed' in self.obs:
                      weather += ' ' + self.obs['wind_speed']
                  if 'wind_gust' in self.obs:
                      weather += ' gusts ' + self.obs['wind_gust']
              if self.settings.pressure:
                  if 'press'  in self.obs:
                      weather += ' press ' + self.obs['press']
              if self.settings.visibility:
                  if 'vis' in self.obs:
                      weather += ' vis ' + self.obs['vis']
              return weather
          def run(self, blockSelect):
              self.processMetars(blockSelect)

      if __name__ == '__main__':
          settings = MetarsSettingsEnvironment()
          if not settings.isConfigured():
              print('METARS: Not configured.')
              sys.exit(1)
          settings.extract()
          metars = Metars(settings)
          if 'BLOCK_BUTTON' in os.environ:
              buttonType = os.environ['BLOCK_BUTTON']
              if buttonType == '1' or buttonType == '2' or buttonType == '3':
                  metars.run(True)
              else:
                  metars.run(False)
          else:
              metars.run(False)
    '';
    ".local/libexec/i3blocks/miccontrol".executable = true;
    ".local/libexec/i3blocks/miccontrol".text = ''
      #!/usr/bin/env bash
      #
      # Copyright © 2020 Filip Paskali
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      case $BLOCK_BUTTON in
          1|3) pactl set-source-mute  $SOURCE toggle ;;
      esac

      case $(pacmd list-sources | grep -A 11 "$SOURCE" | awk '/muted/ {print $2; exit}') in
          yes)
            echo ""
            ;;
          no)
            echo ""
            ;;
      esac
    '';
    ".local/libexec/i3blocks/monitor_manager".executable = true;
    ".local/libexec/i3blocks/monitor_manager".text = ''
      #!/usr/bin/env python3
      #
      #   Copyright (c) 2016 James Murphy
      #   Licensed under the GPL version 2 only
      #
      # monitor_manager is an i3blocks blocklet script to quickly manage your
      # connected output devices

      from tkinter import * 
      from tkinter import messagebox
      from shutil import which
      import tkinter.font as font
      from subprocess import call, check_output, CalledProcessError
      import re
      import os

      DESKTOP_SYMBOL = "\uf108"

      UP_ARROW = "\uf062"
      DOWN_ARROW = "\uf063"
      UNBLANKED_SYMBOL = "\uf06e"
      BLANKED_SYMBOL = "\uf070"
      NOT_CLONED_SYMBOL = "\uf096"
      PRIMARY_SYMBOL = "\uf005"
      SECONDARY_SYMBOL = "\uf006"
      CLONED_SYMBOL = "\uf24d"
      ROTATION_NORMAL = "\uf151"
      ROTATION_LEFT = "\uf191"
      ROTATION_RIGHT = "\uf152"
      ROTATION_INVERTED = "\uf150"
      REFLECTION_NORMAL = "\uf176"
      REFLECTION_X = "\uf07e"
      REFLECTION_Y = "\uf07d"
      REFLECTION_XY = "\uf047"
      TOGGLE_ON = "\uf205"
      TOGGLE_OFF = "\uf204"
      APPLY_SYMBOL = "\uf00c"
      CANCEL_SYMBOL = "\uf00d"
      ARANDR_SYMBOL = "\uf085"
      REFRESH_SYMBOL = "\uf021"

      strbool = lambda s: s.lower() in ['t', 'true', '1']
      def _default(name, default=''', arg_type=strbool):
          val = default
          if name in os.environ:
              val = os.environ[name]
          return arg_type(val)

      SHOW_ON_OFF = _default("SHOW_ON_OFF","1") 
      SHOW_NAMES = _default("SHOW_NAMES", "1")
      SHOW_PRIMARY = _default("SHOW_PRIMARY", "1")
      SHOW_MODE = _default("SHOW_MODE", "1")
      SHOW_BLANKED = _default("SHOW_BLANKED", "1")
      SHOW_DUPLICATE = _default("SHOW_DUPLICATE", "1")
      SHOW_ROTATION = _default("SHOW_ROTATION", "1")
      SHOW_REFLECTION = _default("SHOW_REFLECTION", "1") 
      SHOW_BRIGHTNESS = _default("SHOW_BRIGHTNESS", "1")
      SHOW_BRIGHTNESS_VALUE = _default("SHOW_BRIGHTNESS_VALUE", "0")
      SHOW_UP_DOWN = _default("SHOW_UP_DOWN", "1")

      FONTAWESOME_FONT_FAMILY = "FontAwesome"
      FONTAWESOME_FONT_SIZE = 11
      FONTAWESOME_FONT = (FONTAWESOME_FONT_FAMILY, FONTAWESOME_FONT_SIZE)
      DEFAULT_FONT_FAMILY = _default("FONT_FAMILY","DejaVu Sans Mono", str)
      DEFAULT_FONT_SIZE = _default("FONT_SIZE", 11, int)
      DEFAULT_FONT = (DEFAULT_FONT_FAMILY, DEFAULT_FONT_SIZE)

      BRIGHTNESS_SLIDER_HANDLE_LENGTH = 20
      BRIGHTNESS_SLIDER_WIDTH = 15
      BRIGHTNESS_SLIDER_LENGTH = 50

      WINDOW_CLOSE_TO_BOUNDARY_BUFFER = _default("CLOSE_TO_BOUNDARY_BUFFER", 20, int)

      class Output:
          def __init__(self, name=None, w=None, h=None, x=None, y=None, rate=None,
                  active=False, primary=False, sameAs=None, blanked=False, rotation="normal",
                  reflection="normal", brightness=1.0):
              self.name = name
              self.w = w
              self.h = h
              self.x = x
              self.y = y
              self.rate = rate
              self.active = active
              self.primary = primary
              self.sameAs = sameAs
              self.blanked = blanked
              self.modes = []
              self.currentModeIndex = None
              self.preferredModeIndex = None
              self.row = None
              self.rotation = rotation
              self.reflection = reflection
              self.brightness = brightness

          def setPreferredMode(self):
              if self.preferredModeIndex != None:
                  self.setMode(self.preferredModeIndex)
              elif self.modes != None:
                  self.setMode(0)

          def setMode(self, index):
              self.w, self.h, self.rate = self.modes[index]
              self.currentModeIndex = index

          def realOutputs():
              outputs = []
              xrandrText = check_output(["xrandr","--verbose"],universal_newlines=True)
              outputBlocks = re.split(r'\n(?=\S)', xrandrText, re.MULTILINE)
              infoPattern = re.compile(
                      r'^(\S+)'                        # output name
                      ' connected '                    # must be connected
                      '(primary )?'                    # check if primary output
                      '((\d+)x(\d+)\+(\d+)\+(\d+) )?'  # width x height + xoffset + yoffset
                      '(\(\S+\) )?'                    # mode code (0x4a)
                      '(normal|left|inverted|right)? ?'  # rotation
                      '(X axis|Y axis|X and Y axis)?') # reflection
              brightnessPattern = re.compile(r'^\tBrightness: ([\d.]+)', re.MULTILINE)
              modePattern = re.compile(r'^  (\d+)x(\d+)[^\n]*?\n +h:[^\n]*?\n +v:[^\n]*?([\d.]+)Hz$', re.MULTILINE)
              for outputBlock in outputBlocks:
                  output = Output()
                  infoMatch = infoPattern.match(outputBlock)
                  if infoMatch:
                      output.name = infoMatch.group(1)
                      if infoMatch.group(2):
                          output.primary = True
                      if infoMatch.group(3):
                          output.active = True
                          output.w, output.h, output.x, output.y = map(int,infoMatch.group(4, 5, 6, 7))
                      if infoMatch.group(9):
                          output.rotation = infoMatch.group(9)
                          if output.rotation in ["left", "right"]:
                              output.w, output.h = output.h, output.w
                      if infoMatch.group(10):
                          if infoMatch.group(10) == "X axis":
                              output.reflection = "x"
                          elif infoMatch.group(10) == "Y axis":
                              output.reflection = "y"
                          elif infoMatch.group(10) == "X and Y axis":
                              output.reflection = "xy"
                          else:
                              output.reflection = "normal"
                      else:
                          output.reflection = "normal"
                      brightnessMatch = brightnessPattern.search(outputBlock)
                      if brightnessMatch:
                          try:
                              brightness = float(brightnessMatch.group(1))
                              output.brightness = brightness
                              if abs(brightness) < 1e-09:
                                  output.blanked = True
                          except ValueError:
                              pass
                      modeMatches = modePattern.finditer(outputBlock)
                      for i, modeMatch in enumerate(modeMatches):
                          if "*current" in modeMatch.group(0):
                              output.currentModeIndex = i
                              output.rate = modeMatch.group(3)
                          if "+preferred" in modeMatch.group(0):
                              output.preferredModeIndex = i
                          output.modes.append(modeMatch.group(1,2,3))
                      outputs.append(output)
              outputs.sort(key=lambda m: m.x if m.x != None else -1)
              prev = None
              for output in outputs:
                  if prev != None and output.active and prev.active and output.x == prev.x:
                      output.sameAs = prev.name
                  else:
                      prev = output
                  
              return outputs

          def modestr(mode):
              return "{}x{}@{}".format(*mode)

          def status(self):
              if self.active:
                  if self.sameAs == None or self.sameAs == self.name:
                      if self.w and self.h and self.rate:
                          return "{}x{}@{}".format(self.w, self.h, self.rate)
                      else:
                          return "auto"
                  else:
                      return "duplicate {}".format(self.sameAs)
              else:
                  return "Inactive"


          def __str__(self):
              return "{} {}x{}+{}+{} active:{}, primary:{}\nmodes:{}\ncurrentIndex:{} preferredIndex:{}".format(
                      self.name, self.w, self.h, self.x, self.y, self.active, self.primary, self.modes, self.currentModeIndex, self.preferredModeIndex)

      class MonitorManager():
          def __init__(self, root):
              self.root = root
              self.root.withdraw()
              self.root.resizable(0,0)
              self.root.wm_title("Monitor Manager")
              self.frame = None
              self.outputs = []
              self.hardRefreshList()
              style = {'relief':FLAT, 'padx':1, 'pady':1, 'anchor':'w', 'font':FONTAWESOME_FONT}
              
              self.infoLabel = Label(self.root, text="", **style)
              self.infoLabel.config(font=DEFAULT_FONT)

              self.bottomRow = []

              self.applyButton = Button(self.root, text=APPLY_SYMBOL, **style)
              self.bottomRow.append(self.applyButton)
              
              self.refreshButton = Button(self.root, text=REFRESH_SYMBOL, **style)
              self.bottomRow.append(self.refreshButton)
              
              if which("arandr"):
                  self.arandrButton = Button(self.root, text=ARANDR_SYMBOL, **style)
                  self.bottomRow.append(self.arandrButton)
              else:
                  self.arandrButton = None
                  
              self.cancelButton = Button(self.root, text=CANCEL_SYMBOL, **style)
              self.bottomRow.append(self.cancelButton)

              self.infoLabel.grid(row=1,column=0, columnspan=len(self.bottomRow))
              self.gridRow(2, self.bottomRow)
              
              self.moveToMouse()
              self.root.deiconify()

          def registerBindings(self):
              self.root.bind("<Return>", self.handleApply)
              self.root.bind("<Escape>", self.handleCancel)
              
              self.applyButton.bind("<Button-1>", self.handleApply)
              self.setInfo(self.applyButton, "Apply changes")

              self.refreshButton.bind("<Button-1>", self.hardRefreshList)
              self.setInfo(self.refreshButton, "Refresh list")

              if self.arandrButton:
                  self.arandrButton.bind("<Button-1>", self.handleArandr)
                  self.setInfo(self.arandrButton, "Launch aRandR")

              self.cancelButton.bind("<Button-1>", self.handleCancel)
              self.setInfo(self.cancelButton, "Cancel")

              for toggleButton in self.toggleButtons:
                  toggleButton.bind("<Button-1>", self.toggleActive)
                  toggleButton.bind("<Button-4>", self.handleUp)
                  toggleButton.bind("<Button-5>", self.handleDown)
                  self.setInfo(toggleButton, "Turn output on/off")
              
              for primaryButton in self.primaryButtons:
                  primaryButton.bind("<Button-1>", self.setPrimary)
                  self.setInfo(primaryButton, "Set primary output")
              
              for blankedButton in self.blankedButtons:
                  blankedButton.bind("<Button-1>", self.toggleBlanked)
                  self.setInfo(blankedButton, "Show/hide output")
              
              for duplicateButton in self.duplicateButtons:
                  duplicateButton.bind("<Button-1>", self.toggleDuplicate)
                  self.setInfo(duplicateButton, "Duplicate another output")

              for rotateButton in self.rotateButtons:
                  rotateButton.bind("<Button-1>", self.cycleRotation)
                  self.setInfo(rotateButton, "Rotate output")

              for reflectButton in self.reflectButtons:
                  reflectButton.bind("<Button-1>", self.cycleReflection)
                  self.setInfo(reflectButton, "Reflect output")

              for brightnessSlider in self.brightnessSliders:
                  brightnessSlider.bind("<ButtonRelease-1>", self.updateBrightness)
                  self.setInfo(brightnessSlider, "Adjust brightness")
              
              for upButton in self.upButtons:
                  upButton.bind("<Button-1>", self.handleUp)
                  upButton.bind("<Button-4>", self.handleUp)
                  upButton.bind("<Button-5>", self.handleDown)
                  self.setInfo(upButton, "Move up")

              for downButton in self.downButtons:
                  downButton.bind("<Button-1>", self.handleDown)
                  downButton.bind("<Button-4>", self.handleUp)
                  downButton.bind("<Button-5>", self.handleDown)
                  self.setInfo(downButton, "Move down")
                  
          def gridRow(self, row, widgets):
              column = 0
              for w in widgets:
                  w.grid(row=row, column=column)
                  column += 1

          def moveToMouse(self):
              root = self.root 
              root.update_idletasks()
              width = root.winfo_reqwidth()
              height = root.winfo_reqheight()
              x = root.winfo_pointerx() - width//2
              y = root.winfo_pointery() - height//2
              screen_width = root.winfo_screenwidth()
              screen_height = root.winfo_screenheight()
              if x+width > screen_width - WINDOW_CLOSE_TO_BOUNDARY_BUFFER:
                  x =  screen_width - WINDOW_CLOSE_TO_BOUNDARY_BUFFER - width
              elif x < WINDOW_CLOSE_TO_BOUNDARY_BUFFER:
                  x = WINDOW_CLOSE_TO_BOUNDARY_BUFFER
              if y+height > screen_height - WINDOW_CLOSE_TO_BOUNDARY_BUFFER:
                  y = screen_height - WINDOW_CLOSE_TO_BOUNDARY_BUFFER - height
              elif y < WINDOW_CLOSE_TO_BOUNDARY_BUFFER:
                  y = WINDOW_CLOSE_TO_BOUNDARY_BUFFER

              root.geometry('+{}+{}'.format(x, y))

          def setInfo(self, widget, info):
              widget.bind("<Enter>", lambda e: self.infoLabel.config(text=info, fg="black"))
              widget.bind("<Leave>", lambda e: self.infoLabel.config(text=""))

          def handleApply(self, e=None):
              self.root.after_idle(self.doHandleApply)

          def doHandleApply(self):
              if not self.getUserConfirmationIfDangerousConfiguration():
                  return
              command = ["xrandr"]
              if not self.existsPrimary():
                  command += ["--noprimary"]
              partition = self.sameAsPartition()
              prevFirstActive = None
              for p in partition:
                  firstActive = None
                  for output in p:
                      command += ["--output", output.name]
                      if output.active:
                          if firstActive == None:
                              firstActive = output
                          else:
                              command += ["--same-as", firstActive.name]
                          if output.primary:
                              command += ["--primary"]
                          if prevFirstActive != None:
                              command += ["--right-of", prevFirstActive.name]
                          if output.w != None and output.h != None and output.rate != None:
                              command += ["--mode", "{}x{}".format(output.w,output.h)]
                              command += ["--rate", output.rate ]
                          else:
                                  command += ["--auto"]
                          command += ["--brightness", str(output.brightness)]
                          command += ["--rotate", output.rotation]
                          command += ["--reflect", output.reflection]
                      else:
                          command += ["--off"]
                  if firstActive:
                      prevFirstActive = firstActive
              self.root.after_idle(lambda: self.executeXrandrCommand(command))

          def executeXrandrCommand(self, command):
              try:
                  check_output(command, universal_newlines=True)
              except CalledProcessError as err:
                  self.infoLabel.config(text="xrandr returned nonzero exit status {}".format(err.returncode), fg="red")

          def getUserConfirmationIfDangerousConfiguration(self):
              result = "yes"
              if all(map(lambda o: o.blanked or not o.active, self.outputs)):
                  result = messagebox.askquestion("All blanked or off",
                          "All ouputs are set to be turned off or blanked, continue?",
                          icon="warning")
              return result == "yes"

          def sameAsPartition(self):
              partition = []
              for output in self.outputs:
                  place = None
                  for p in partition:
                      if place != None:
                          break;
                      for o in p:
                          if place == None and (output.sameAs == o.name or o.sameAs == output.name):
                              place = p
                              break;
                  if place:
                      place.append(output)
                  else:
                      partition.append([output])
              return partition

          def handleCancel(self, e=None):
              self.root.destroy()

          def handleArandr(self, e=None):
              call(["i3-msg", "-q", "exec", "arandr"])
              self.root.destroy()

          def handleUp(self, e):
              row = e.widget.output.row
              if row > 0:
                  self.swapOutputRows(row-1, row)
              self.softRefreshList()

          def handleDown(self, e):
              row = e.widget.output.row
              n = len(self.outputs)
              if row + 1 < n:
                  self.swapOutputRows(row, row+1)
              self.softRefreshList()

          def swapOutputRows(self, row1, row2):
              outputs = self.outputs
              outputs[row1],outputs[row2] = outputs[row2],outputs[row1]
              outputs[row1].row = row1
              outputs[row2].row = row2
              for widget in self.frame.grid_slaves(row=row2):
                  widget.output = outputs[row2]
              for widget in self.frame.grid_slaves(row=row1):
                  widget.output = outputs[row1]

          def setPrimary(self, e):
              output = e.widget.output
              output.primary = not output.primary
              for otherOutput in self.outputs:
                  if otherOutput != output:
                      otherOutput.primary = False
              self.softRefreshList() 

          def existsPrimary(self):
              for output in self.outputs:
                  if output.primary:
                      return True
              return False

          def toggleActive(self, e):
              output = e.widget.output
              output.active = not output.active
              if output.active:
                  output.setPreferredMode()
              else:
                  for otherOutput in self.outputs:
                      if otherOutput.sameAs == output.name:
                          otherOutput.sameAs = None
              self.softRefreshList()

          def toggleBlanked(self, e):
              output = e.widget.output
              if output.blanked:
                  output.blanked = False
                  output.brightness = 1.0
              else:
                  output.blanked = True
                  output.brightness = 0.0
              self.softRefreshList()

          def updateBrightness(self, e):
              output = e.widget.output
              output.brightness = .01 * e.widget.get()
              output.blanked = False
              if abs(output.brightness) < 1e-09:
                  output.blanked = True
              self.softRefreshList()

          def cycleRotation(self, e):
              output = e.widget.output
              if output.rotation == "normal":
                  output.rotation = "right"
              elif output.rotation == "right":
                  output.rotation = "inverted"
              elif output.rotation == "inverted":
                  output.rotation = "left"
              else:
                  output.rotation = "normal"
              self.softRefreshList()

          def rotationSymbol(self, rotation):
              return {
                  "normal": ROTATION_NORMAL,
                  "left": ROTATION_LEFT,
                  "right": ROTATION_RIGHT,
                  "inverted": ROTATION_INVERTED,
                      }[rotation]

          def cycleReflection(self, e):
              output = e.widget.output
              if output.reflection == "normal":
                  output.reflection = "x"
              elif output.reflection == "x":
                  output.reflection = "y"
              elif output.reflection == "y":
                  output.reflection = "xy"
              else:
                  output.reflection = "normal"
              self.softRefreshList()

          def reflectionSymbol(self, reflection):
              return {
                  "normal": REFLECTION_NORMAL,
                  "x": REFLECTION_X,
                  "y": REFLECTION_Y,
                  "xy": REFLECTION_XY,
                      }[reflection]

          def toggleDuplicate(self, e):
              duplicateButton = e.widget
              optionMenu = duplicateButton.statusOptionMenu
              output = optionMenu.output
              if output.sameAs != None:
                  output.sameAs = None
                  self.setMenuToOutput(optionMenu, output)
              else:
                  self.setMenuToDuplicate(optionMenu)
              self.softRefreshList()

          def getDuplicableOutputsFor(self, output):
              return [o for o in self.outputs if o != output and o.sameAs == None]

          def softRefreshList(self, e=None):
              for widget in set().union(self.nameLabels, self.primaryButtons, 
                      self.statusOptionMenus, self.blankedButtons, 
                      self.duplicateButtons, self.rotateButtons, self.reflectButtons,
                      self.brightnessSliders, self.upButtons, self.downButtons):
                  widget.config(fg="gray" if not widget.output.active else "black")

              for widget in self.toggleButtons:
                  widget.config(text=TOGGLE_ON if widget.output.active else TOGGLE_OFF)

              for widget in self.nameLabels:
                  widget.config(text=widget.output.name)

              for widget in self.primaryButtons:
                  widget.config(text=PRIMARY_SYMBOL if widget.output.primary else SECONDARY_SYMBOL)
                  if not widget.output.primary:
                      widget.config(fg="gray")

              for widget in self.statusOptionMenus:
                  widget.config(text=widget.output.status())
                  if widget.output.sameAs != None:
                      self.setMenuToDuplicate(widget)
                      self.setInfo(widget, "Select output to duplicate")
                  else:
                      self.setMenuToOutput(widget, widget.output)
                      self.setInfo(widget, "Select output mode")

              for widget in self.blankedButtons: 
                  widget.config(text=BLANKED_SYMBOL if widget.output.blanked else UNBLANKED_SYMBOL)

              for widget in self.duplicateButtons:
                  widget.config(text=CLONED_SYMBOL if widget.output.sameAs else NOT_CLONED_SYMBOL)

              for widget in self.rotateButtons:
                  widget.config(text=self.rotationSymbol(widget.output.rotation))

              for widget in self.reflectButtons:
                  widget.config(text=self.reflectionSymbol(widget.output.reflection))

              for widget in self.brightnessSliders:
                  widget.set(int(100*widget.output.brightness))

          def hardRefreshList(self, e=None):
              self.outputs = Output.realOutputs()
              self.root.after_idle(self.populateGrid)

          def populateGrid(self):
              oldFrame = self.frame
              self.frame = Frame(self.root)
              self.frame.grid(row=0, column=0, columnspan=len(self.bottomRow))
              self.toggleButtons = []
              self.nameLabels = []
              self.primaryButtons = []
              self.statusOptionMenus = []
              self.blankedButtons = []
              self.duplicateButtons = []
              self.rotateButtons = []
              self.reflectButtons = []
              self.brightnessSliders = []
              self.upButtons = []
              self.downButtons = []
              for row, output in enumerate(self.outputs):
                  self.makeLabelRow(output, row)
              self.registerBindings()
              if oldFrame:
                  oldFrame.destroy()

          def makeLabelRow(self, output, row):
              output.row = row
              style = {'relief':FLAT, 'padx':1, 'pady':1, 'anchor':'w'}
              widgets = []

              toggleButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
              toggleButton.output = output
              self.toggleButtons.append(toggleButton)
              if SHOW_ON_OFF: 
                  widgets.append(toggleButton)

              nameLabel = Label(self.frame, font=DEFAULT_FONT)
              nameLabel.output = output
              self.nameLabels.append(nameLabel)
              if SHOW_NAMES:
                  widgets.append(nameLabel)

              primaryButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
              primaryButton.output = output
              self.primaryButtons.append(primaryButton)
              if not output.primary:
                  primaryButton.config(fg="gray")
              if SHOW_PRIMARY:
                  widgets.append(primaryButton)

              var = StringVar(self.frame)
              statusOptionMenu = OptionMenu(self.frame, var, None)
              statusOptionMenu.output = output
              statusOptionMenu.var = var
              statusOptionMenu.config(relief=FLAT)
              self.statusOptionMenus.append(statusOptionMenu)
              if SHOW_MODE or SHOW_DUPLICATE:
                  widgets.append(statusOptionMenu)

              blankedButton = Button(self.frame, font=FONTAWESOME_FONT,  **style)
              blankedButton.output = output
              self.blankedButtons.append(blankedButton)
              if SHOW_BLANKED:
                  widgets.append(blankedButton)

              duplicateButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
              duplicateButton.statusOptionMenu = statusOptionMenu
              duplicateButton.output = output
              self.duplicateButtons.append(duplicateButton)
              if SHOW_DUPLICATE:
                  widgets.append(duplicateButton)

              rotateButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
              rotateButton.output = output
              self.rotateButtons.append(rotateButton)
              if SHOW_ROTATION:
                  widgets.append(rotateButton)

              reflectButton = Button(self.frame, font=FONTAWESOME_FONT, **style)
              reflectButton.output = output
              self.reflectButtons.append(reflectButton)
              if SHOW_REFLECTION:
                  widgets.append(reflectButton)

              brightnessSlider = Scale(self.frame, orient="horizontal", from_=0, to=100,
                      length=BRIGHTNESS_SLIDER_LENGTH, showvalue=SHOW_BRIGHTNESS_VALUE, 
                      sliderlength=BRIGHTNESS_SLIDER_HANDLE_LENGTH,
                      width=BRIGHTNESS_SLIDER_WIDTH, font=FONTAWESOME_FONT)
              brightnessSlider.output = output
              self.brightnessSliders.append(brightnessSlider)
              if SHOW_BRIGHTNESS:
                  widgets.append(brightnessSlider)

              upButton = Button(self.frame, text=UP_ARROW, font=FONTAWESOME_FONT, **style)
              upButton.output = output
              self.upButtons.append(upButton)
              if SHOW_UP_DOWN:
                  widgets.append(upButton)

              downButton = Button(self.frame, text=DOWN_ARROW, font=FONTAWESOME_FONT, **style)
              downButton.output = output
              self.downButtons.append(downButton)
              if SHOW_UP_DOWN:
                  widgets.append(downButton)
             
              for widget in widgets:
                  widget.output = output
              self.gridRow(row, widgets) 
              self.softRefreshList()

          def setMenuToOutput(self, optionMenu, output):
              menu = optionMenu["menu"]
              var = optionMenu.var
              modes = output.modes
              menu.delete(0, END)
              for i, mode in enumerate(modes):
                  label = Output.modestr(mode)
                  menu.add_command(label=label, command=setLabelAndOutputModeFunc(var,label,output,i))
              if output.currentModeIndex != None:
                  var.set(Output.modestr(modes[output.currentModeIndex]))
              elif output.preferredModeIndex != None:
                  var.set(Output.modestr(modes[output.preferredModeIndex]))
              elif len(modes) > 0:
                  var.set(Output.modestr(modes[0]))

          def setMenuToDuplicate(self, optionMenu):
              menu = optionMenu["menu"]
              var = optionMenu.var
              output = optionMenu.output
              menu.delete(0, END)
              duplicables = self.getDuplicableOutputsFor(output)
              defaultIndex = 0
              for i,otherOutput in enumerate(duplicables):
                      label = otherOutput.name
                      menu.add_command(label=label, command=setLabelAndSameAsFunc(var,label,output))
                      if label == output.sameAs:
                          defaultIndex = i
              if len(duplicables) > 0:
                  var.set(menu.entrycget(defaultIndex, "label"))
                  output.sameAs = menu.entrycget(defaultIndex, "label")
              else:
                  var.set("None")

          def handleFocusOut(self, event):
              self.root.destroy()

      def setLabelAndOutputModeFunc(var, label, output, i):
          def func():
              var.set(label)
              output.setMode(i)
          return func

      def setLabelAndSameAsFunc(var, sameAs, output):
          def func():
              var.set(sameAs)
              output.sameAs = sameAs
          return func

      if os.environ.get('BLOCK_BUTTON') == "1":
          if os.fork() != 0:
              root = Tk()
              if DEFAULT_FONT_FAMILY and DEFAULT_FONT_SIZE:
                  font.nametofont("TkDefaultFont").config(family=DEFAULT_FONT_FAMILY, size=DEFAULT_FONT_SIZE)
              manager = MonitorManager(root)
              root.mainloop()
          else:
              print(DESKTOP_SYMBOL)
      else:
          print(DESKTOP_SYMBOL)
    '';
    ".local/libexec/i3blocks/nm-vpn".executable = true;
    ".local/libexec/i3blocks/nm-vpn".text = ''
      #!/usr/bin/env sh
      init_color=''${init_color:-#FFFF00}
      on_color=''${on_color:-#00FF00}
      export init_color on_color
      nmcli -t connection show --active | awk -F ':' '
      BEGIN {
          init_color=ENVIRON["init_color"]
          on_color=ENVIRON["on_color"]
      }
      $3=="vpn" {
          name=$1
          status="INIT"
          color=init_color
      }
      $3=="tun" || ($4~/^tap/ || $3~/^tap/) {
          if(!name) name=$1
          status="ON"
          color=on_color
      }
      END {if(status) printf("%s\n%s\n%s\n", name, status, color)}'
    '';
    ".local/libexec/i3blocks/openvpn".executable = true;
    ".local/libexec/i3blocks/openvpn".text = ''
      #!/usr/bin/env perl
      # Made by Pierre Mavro/Deimosfr <deimos@deimos.fr>
      # Minor contribution by Thor K. H. <thor@roht.no>
      # Licensed under the terms of the GNU GPL v3, or any later version.
      # Version: 0.3

      # Usage:
      # 1. The configuration name of OpenVPN should be familiar for you (home,work...)
      # 2. The device name in your configuration file should be fully named (tun0,tap1...not only tun or tap)
      # 3. When you launch one or multiple OpenVPN connexion, be sure the PID file is written in the correct folder (ex: --writepid /run/openvpn/home.pid)

      use strict;
      use warnings;
      use utf8;
      use Getopt::Long;

      my $openvpn_enabled='/dev/shm/openvpn_i3blocks_enabled';
      my $openvpn_disabled='/dev/shm/openvpn_i3blocks_disabled';

      # Print output
      sub print_output {
          my $ref_pid_files = shift;
          my @pid_files = @$ref_pid_files;
          my $change=0;

          # Total pid files
          my $total_pid = @pid_files;
          if ($total_pid == 0) {
              print "down\n"x2;
              # Delete OpenVPN i3blocks temp files
              if (-f $openvpn_enabled) {
                  unlink $openvpn_enabled or die "Can't delete $openvpn_enabled\n";
                  # Colorize if VPN has just went down
                  print '#FF0000\n';
              }
              unless (-f $openvpn_disabled) {
                  open(my $shm, '>', $openvpn_disabled) or die "Can't write $openvpn_disabled\n";
              }
              exit(0);
          }

          # Check if interface device is present
          my $vpn_found=0;
          my $pid;
          my $cmd_line;
          my @config_name;
          my @config_path;
          my $interface;
          my $config_prefix;
          my $current_config_path;
          my $current_config_name;
          foreach (@pid_files) {
              # Get current PID
              $pid=0;
              open(PID, '<', $_);
              while(<PID>) {
                  chomp $_;
                  $pid = $_;
              }
              close(PID);
              # Check if PID has been found
              if ($pid ==0) {
                  print "Can't get PID $_: $!\n";
              }

              # Check if PID is still alive
              $cmd_line='/proc/'.$pid.'/cmdline';
              if (-f $cmd_line) {
                  # Get config name
                  open(CMD_LINE, '<', $cmd_line);
                  while(<CMD_LINE>) {
                      chomp $_;
                      $config_prefix = "";
                      if ($_ =~ /--cd\x{00}(.*?)\x{00}/) {
                          $config_prefix = $1;
                      }
                      if ($_ =~ /--config\x{00}(.*?\.conf)\x{00}/) {
                          # Get interface from config file
                          $current_config_path = $1;
                          # Remove unwanted escape chars
                          $interface = 'null';
                          # Get configuration name
                          if ($current_config_path =~ /(\w+).conf/) {
                              $current_config_name=$1;
                          } else {
                              $current_config_name='unknown';
                          }

                          $current_config_path = "$config_prefix/$current_config_path";

                          # Get OpenVPN interface device name
                          open(CONFIG, '<', $current_config_path) or die "Can't read config file '$current_config_path': $!\n";
                          while(<CONFIG>) {
                              chomp $_;
                              if ($_ =~ /dev\s+(\w+)/) {
                                  $interface=$1;
                                  last;
                              }
                          }
                          close(CONFIG);
                          # check if interface exist
                          unless ($interface eq 'null') {
                              if (-d "/sys/class/net/$interface") {
                                  push @config_name, $current_config_name;
                                  $vpn_found=1;
                                  # Write enabled file
                                  unless (-f $openvpn_enabled) {
                                      open(my $shm, '>', $openvpn_enabled) or die "Can't write $openvpn_enabled\n";
                                      $change=1;
                                  }
                              }
                          }
                      }
                  }
                  close(CMD_LINE);
              }
          }

          # Check if PID found
          my $names;
          my $short_status;
          if ($vpn_found == 1) {
              $names = join('/', @config_name);
              $short_status='up';
          } else {
              $short_status='down';
              $names = $short_status;
          }

          print "$names\n";
          print "$short_status\n";

          # Print color if there were changes
          print "#00FF00\n" if ($change == 1);

          exit(0);
      }

      sub check_opts {
          # Vars
          my $pid_file_format=$ENV{PID_FILE_FORMAT} || '/run/openvpn/*.pid';

          # Set options
          GetOptions( "help|h" => \&help,
              "p=s"    => \$pid_file_format);

          my @pid_file=glob $pid_file_format;
          print_output(\@pid_file);
      }

      sub help {
          print "Usage: openvpn [-p pid_file_format]\n";
          print "-p : format string to glob all pid files (default '/run/openvpn/*.pid)'\n";
          print "Note: devices in configuration file should be named with their number (ex: tun0, tap1)\n";
          exit(1);
      }

      &check_opts;
    '';
    ".local/libexec/i3blocks/openvpn-systemd".executable = true;
    ".local/libexec/i3blocks/openvpn-systemd".text = ''
      #!/usr/bin/env perl

      use strict;
      use warnings;
      use utf8;

      use JSON::Parse 'parse_json';

      my $units = parse_json(`systemctl list-units --output=json --state=active 'openvpn-client@*'`);

      if (@$units) {
          my @names = sort map {
              $_->{unit} =~ /^openvpn-client@(.*)\.service$/;
              $1;
          } @$units;
          print join(' ', @names) . "\n";
          print "up\n";
          print "#00FF00\n";
      } else {
          print "down\n";
          print "down\n";
          print "#FF0000\n";
      }
    '';
    ".local/libexec/i3blocks/os-type".executable = true;
    ".local/libexec/i3blocks/os-type".text = ''
      #!/usr/bin/env bash

      kernel_version=$(uname -a | cut -d ' ' -f 3)

      if [[ -f /etc/os-release ]]; then
          source /etc/os-release;
      else
          NAME="Unknown"
      fi

      echo "$NAME - $kernel_version"
      echo "$NAME"
    '';
    ".local/libexec/i3blocks/purpleair".executable = true;
    ".local/libexec/i3blocks/purpleair".text = ''
      #!/usr/bin/env perl
      # For temperature: subtract 8 from the F value for the actual temperature

      # Get PurpleAir sensor ID
      if ($ENV{'SENSOR_ID'} == "") {
        print STDERR "Missing required environment variable 'SENSOR_ID'.\n";
        exit 1;
      }
      $sensor_id = $ENV{'SENSOR_ID'};

      # Get measurement type. Default: US_AQI
      @valid_types = ("US_AQI", "EU_AQI", "CA_AQHI", "IMECA", "IAS");
      $type = 'US_AQI';
      if (grep(/^$ENV{'TYPE'}$/, @valid_types)) {
        $type = $ENV{'TYPE'};
      } elsif ($ENV{'TYPE'}) {
        print STDERR "Unrecognized TYPE: $ENV{'TYPE'}. Valid values are: [@valid_types]";
        exit 1;
      }

      # Read pm2.5 10-minute average from the PurpleAir sensor
      $pm2_5 = `curl "http://purpleair.com/json?show=$sensor_id" 2>/dev/null \\
          | jq -r '.results | map(select(has("Stats")) | .Stats | fromjson | .v1) | add / length'`;

      ###################
      # IMPLEMENTATIONS #
      ###################

      sub UsAqi {
        # See https://forum.airnowtech.org/t/the-aqi-equation/169
        #
        # PM2.5               | ConcLo | ConcHi | AQILo | AQIHi
        # Good                | 0.0    | 12.0   | 0     | 50
        # Moderate            | 12.1   | 35.4   | 51    | 100
        # Unhealthy Sensitive | 35.5   | 55.4   | 101   | 150
        # Unhealthy           | 55.5   | 150.4  | 151   | 200
        # Very Unhealthy      | 150.5  | 250.4  | 201   | 300
        # Hazardous           | 250.5  | 500.4  | 301   | 500
        #
        # |------------Multiplier-----------|             Threshold  Addition
        # (AQIHi - AQILo) / (ConcHi - ConcLo) * (ConcNow - ConcLo) + AQILo

        @colors = ("#00e400", "#ffff00", "#ff7e00", "#ff0000", "#8f3f97", "#7e0023");
        $pm2_5 = $_[0];

        # Table of values: Threshold, Multiplier, Addition
        @t = (
          [0.0, 4.1667, 0.0],
          [12.1, 2.1030, 51],
          [35.5, 2.4623, 101],
          [55.5, 0.5163, 151],
          [150.5, 0.9910, 201],
          [250.5, 0.7963, 301]
        );

        # Find relevant row for computation based on pm2.5 threshold
        for ($i = 5; $i >= 0; $i--) {
          if ($pm2_5 >= $t[$i][0]) {
            $r = $i;
            last;
          }
        }

        # Compute AQI from raw pm2.5 concentration
        $aqi = $t[$r][1] * ($pm2_5 - $t[$r][0]) + $t[$r][2];

        return (
          'val' => sprintf("%.0f", $aqi),
          'colors' => [@colors],
          'color_idx' => $r
        );
      }

      sub EuAqi {
        # See https://airindex.eea.europa.eu/Map/AQI/Viewer/
        # European Air Quality Index uses the pm2.5 concentration directly.

        @colors = ("#50f0e6", "#50ccaa", "#f0e641", "#ff5050", "#960032", "#7d2181");
        $pm2_5 = $_[0];

        # Thresholds for color indices
        @t = (0.0, 10.0, 20.0, 25.0, 50.0, 75.0);

        # Find relevant row for computation based on pm2.5 threshold
        for ($i = 5; $i >= 0; $i--) {
          if ($pm2_5 >= $t[$i]) {
            $r = $i;
            last;
          }
        }

        return (
          'val' => sprintf("%.0f", $pm2_5),
          'colors' => [@colors],
          'color_idx' => $r
        );
      }

      sub CaAqhi {
        # See https://en.wikipedia.org/wiki/Air_Quality_Health_Index_(Canada)#Calculation
        # Note: AQHI should also incorporate O3 and NO2, but PurpleAir only has PM2.5
        #       The pm2.5 calculation is used alone and multiplied by 3.
        # 1-3: Low
        # 4-6: Moderate
        # 7-10: High
        # 11+: Very High

        @colors = (
          "#00ccff", "#0099cc", "#006699",
          "#ffff00", "#ffcc00", "#ff9933",
          "#ff6666", "#ff0000", "#cc0000",
          "#990000", "#660000");
        $pm2_5 = $_[0];

        $aqhi = 3 * 1000 / 10.4 * ((exp(0.000487 * $pm2_5) - 1));

        return (
          'val' => sprintf("%.0f", $aqhi >= 1 ? $aqhi : 1),
          'colors' => [@colors],
          'color_idx' => $r
        );
      }

      sub Imeca {
        # See http://rama.edomex.gob.mx/imeca
        #
        # PM2.5               | Threshold | Multiplier  | Addition
        # Buena               | 0.0       | 4.17        | 0
        # Regular             | 12.1      | 1.49        | 51
        # Mala                | 45.1      | 0.94        | 101
        # Muy Mala            | 97.5      | 0.93        | 151
        # Extremadamente Mala | 150.5     | 0.99        | 201
        # Extremadamente Mala | 250.5     | 0.99        | 301
        # Extremadamente Mala | 350.5     | 0.66        | 401
        #
        # Multiplier * (pm2.5 - Threshold) + Addition

        @colors = ("#00e400", "#ffff00", "#ff7e00", "#ff0000", "#99004c", "#99004c", "#99004c");
        $pm2_5 = $_[0];

        # Table of values: Threshold, Multiplier, Addition
        @t = (
          [0.0, 4.17, 0.0],
          [12.1, 1.49, 51.0],
          [45.1, 0.94, 101.0],
          [97.5, 0.93, 151.0],
          [150.5, 0.99, 201.0],
          [250.5, 0.99, 301.0],
          [350.5, 0.66, 401.0]
        );

        # Find relevant row for computation based on pm2.5 threshold
        for ($i = 6; $i >= 0; $i--) {
          if ($pm2_5 >= $t[$i][0]) {
            $r = $i;
            last;
          }
        }

        # Compute AQI from raw pm2.5 concentration
        $aqi = $t[$r][1] * ($pm2_5 - $t[$r][0]) + $t[$r][2];

        return (
          'val' => sprintf("%.0f", $aqi),
          'colors' => [@colors],
          'color_idx' => $r
        );
      }

      sub Ias {
        # See https://www.dof.gob.mx/nota_detalle_popup.php?codigo=5576807
        # Índice de aire y salud uses the pm2.5 concentration directly.

        @colors = ("#00e400", "#ffff00", "#ff7e00", "#ff0000", "#99004c");
        $pm2_5 = $_[0];

        # Thresholds for color indices
        @t = (0.0, 26.0, 46.0, 80.0, 148.0);

        # Find relevant row for computation based on pm2.5 threshold
        for ($i = 4; $i >= 0; $i--) {
          if ($pm2_5 >= $t[$i]) {
            $r = $i;
            last;
          }
        }

        return (
          'val' => sprintf("%.0f", $pm2_5),
          'colors' => [@colors],
          'color_idx' => $r
        );
      }

      ##################
      # OUTPUT RESULTS #
      ##################

      # Compute requested value
      # Expected return value is a hash of the form:
      # (
      #   'val' => <numeric measurement value>,
      #   'colors' => [<color hex codes>],
      #   'color_idx' => <0-based index of color array>,
      # )
      if ($type eq "US_AQI") {
        %result = UsAqi($pm2_5);
      } elsif ($type eq "EU_AQI") {
        %result = EuAqi($pm2_5);
      } elsif ($type eq "CA_AQHI") {
        %result = CaAqhi($pm2_5);
      } elsif ($type eq "IMECA") {
        %result = Imeca($pm2_5);
      } elsif ($type eq "IAS") {
        %result = Ias($pm2_5);
      } else {
        # It should not be possible to reach here.
        %result = (
          'val' => 'ERR',
          'colors' => ("#ff0000"),
          'color_idx' => 0,
          'num_colors' => 1
        );
      }

      # Get color overrides, if any.
      if ($ENV{'COLORS'}) {
        @colors = split(',', $ENV{'COLORS'});
        if (scalar(@colors) < scalar(@{ $result{'colors'} })) {
          print STDERR "Warning: number of color overrides is fewer than the number".
              " of buckets in type $type\n";
        }
      } else {
        @colors = @{ $result{'colors'} };
      }

      # Adjust color index if greater than colors length
      $color_idx = $result{'color_idx'};
      if ($color_idx >= scalar(@colors)) {
        $color_idx = scalar(@colors) - 1;
      }

      # Full text, short text, color
      print "$result{'val'}\n";
      print "$result{'val'}\n";

      if (!$ENV{'NO_COLOR'}) {
        print "$colors[$color_idx]\n";
      }

    '';
    ".local/libexec/i3blocks/pw-volume-monitor".executable = true;
    ".local/libexec/i3blocks/pw-volume-monitor".text = ''
      #!/usr/bin/env bash

      #
      # A script to display the pipewire/wireplumber volume in Waybar
      # 
      # This is an optimised bash script. wpctl is called once every $DELAY seconds 
      # to obtain the default sink volume. No other process is started. 
      #
      # The waybar configuration should look like that 
      # 
      # "custom/pipewire": {
      #    "tooltip": false,
      #    "max-length": 6,
      #    "restart-interval": 10,
      #    "exec": "exec $HOME/path-to/pw-volume-monitor"
      # },
      #

      # The script is not properly terminated when waybar is restarted.
      # This is probably because it is started via '/bin/sh -c "..."' and
      # /bin/sh does not always terminate its children processes when it dies.

      # A trick is to declare the waybar custom module with
      #     "exec": "exec path-to-this-script"
      # The second 'exec' is the builtin command that tells /bin/sh to terminate
      # and replace itself by the script. Consequently, waybar will send the
      # termination signal directly to the script.
      # That trick also save a bit of resources (one less process in the background)
      #

      # Another simple trick is to make the shell script terminate as soon as
      # a command fails. In that case, that the 'echo' commands will fail 
      # when STDOUT ceases to be valid.
      # Anyway, this is always a good idea to stop a script when something
      # goes wrong (e.g. wpctl or pipewire not working as expected)
      set -e

      # Snore is a pure bash implementation of 'sleep' that does not start any subprocess
      # https://blog.dhampir.no/content/sleeping-without-a-subprocess-in-bash-and-how-to-sleep-forever
      #snore()
      #{
      #    local IFS
      #    [[ -n "''${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
      #    read ''${1:+-t "$1"} -u $_snore_fd || :
      #}

      # Delay in seconds between updates
      #DELAY=0.5

      # ICON will be set to an array containing the speaker icons for mute, low, medium, high   
      # Multiple sets of text icons are possible: 

      # no icons
      SET0=("" "" "" "") 

      # From the Unicode subset 'Miscellaneous Symbols And Pictographs' (aka emojis).
      # On Linux, a few fonts such as Noto Emoji are providing them in full color. 
      # VS15 AND VS16 are variation selectors for emoji. If multiple fonts are providing
      # emojis, they could be used to select either a monochrome or a color version.
      VS15=$'\uFE0E'
      VS16=$'\uFE0F'
      VS=""  # replace by $VS15 or $VS16 if needed
      SET1=(
          $'\U0001F507'"$VS"
          $'\U0001F508'"$VS"
          $'\U0001F509'"$VS"
          $'\U0001F50A'"$VS"
      )

      # Those are FontAwesome icons. They use the Unicode private plane and so are non standard. 
      # See also the Nerd Fonts project:
      #    https://github.com/ryanoasis/nerd-fonts
      #    https://github.com/ryanoasis/nerd-fonts/releases/
      # Those can be a bit wider than other characters so a space can be needed 
      SET2=(
          $'''
          $'\uf026 '
          $'\uf027 ' 
          $'\uf028 ' 
      )

      # Choose here your favorite icon set.
      ICON=("''${SET1[@]}")

      #while snore $DELAY ; do
       
          # Is it possible to get multiple lines with wpctl?
          # Not sure but lets assume that this is possible. 
          OUT="" 
          INPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
          while read LINE ; do
              #
              # The output of wpctl is of the form
              #   Volume: AAAAA.BB
              # or
              #   Volume: AAAAA.BB [MUTED]
              #
              # Where A and B are sequences of digits.
              #  --> B is always of length 2 and A is often of length 1.
              #      However, Pipewire can set the volume to more than 100%
              #      so A may be bigger. 
              #
              if [[ "$LINE" =~ ^Volume:.([0-9]+)\.([0-9]{2})(([[:blank:]]\[MUTED\])?)$ ]] ; then

                  if [[ -n "$OUT" ]] ; then
                      OUT+=" "
                  fi
                  # Bash stores the parts of the matched regular expression in BASH_REMATCH
                  # 
                  # [0] = the whole match
                  # [1] = the AAAAA part
                  # [2] = the BB part
                  # [3] = the MUTED part when found 
                  #            
                  if [[ -n "''${BASH_REMATCH[3]}" ]] ; then
                      OUT+="''${ICON[0]}MUTE"
                  else
                      # Numbers starting with 0 are interpeted in octal.
                      # That can be prevented by specifying a decimal base as in 10#033
                      # Remark: Do not use 'let' to do the math because the script will
                      #         terminate (because of 'set -e') when the value is 0
                      volume=$(( 10#''${BASH_REMATCH[1]}''${BASH_REMATCH[2]} ))
                      if [[ $volume -gt 50 ]]; then
                          OUT+="''${ICON[3]}$volume%%"
                      elif [[ $volume -gt 25 ]]; then
                          OUT+="''${ICON[2]}$volume%%"
                      elif [[ $volume -gt 0 ]]; then
                          OUT+="''${ICON[1]}$volume%%"
                      else
                          OUT+="''${ICON[1]}---"
                      fi
                  fi
              else
                  echo "Warning: Failed to match output of wpctl: '$LINE'" >&2
                  exit 1
              fi
          done <<<"$INPUT"

          if [[ -n "$OUT" ]] ; then
             printf "$OUT\n"
          fi
      #done

      exit 0
    '';
    ".local/libexec/i3blocks/README.md".text = ''
      # Before using this block

      This is a fork of the block volume-pulseaudio, that supports pipewire,
      pulseaudio, and alsa. This is achieved by using the tool pactl instead of pacmd.
      So hopefuly this should be the future of this block.

      # volume-pipewire

      Display the system volume and
      optionally the default playback device and index.
      Offers controls for these via clicks/scrolling.
      Supports changing audiostreams that are already playing.

      ![](volume-pipewire-high.png)
      ![](volume-pipewire-med.png)
      ![](volume-pipewire-low.png)
      ![](volume-pipewire-mute.png)

      # Dependencies

      pipewire-pulse, pipewire-alsa, pipewire-jack, alsa-utils, fontawesome (fonts-font-awesome package) for the speaker symbols

      # Usage

      Left/right clicks change default playback device, middle click mutes, scrolling
      adjusts volume. If your keyboard has audio buttons, it is suggested to add the
      the following to your i3 config

      ```
      # Pipewire-pulse
      bindsym XF86AudioMute exec pactl set-sink-mute 0 toggle
      bindsym XF86AudioMute --release exec pkill -RTMIN+1 i3blocks
      bindsym XF86AudioLowerVolume exec pactl set-sink-volume 0 -5%
      bindsym XF86AudioLowerVolume --release exec pkill -RTMIN+1 i3blocks
      bindsym XF86AudioRaiseVolume exec pactl set-sink-volume 0 +5%
      bindsym XF86AudioRaiseVolume --release exec pkill -RTMIN+1 i3blocks

      # Media player controls
      bindsym XF86AudioPlay exec playerctl play-pause
      bindsym XF86AudioPause exec playerctl play-pause
      bindsym XF86AudioNext exec playerctl next
      bindsym XF86AudioPrev exec playerctl previous
      ```

      where the number `1` in `-RTMIN+1` can be replaced to another signal number,
      as long as it agrees what you put for `signal=` in your i3blocks config.
      The previous lines also assume your mixer is "pulse" and your scontrol is "Master".
      If yours are different, change them appropriately.

      Alternatively to using signals, you may use the `SUBSCRIBE=1` option in your config in order to have the block
      automatically respond to audio change events. This option requires `interval=persist`
      and always uses the `LONG_FORMAT`.

      # Config

      ```INI
      [volume-pipewire]
      command=$SCRIPT_DIR/volume-pipewire
      interval=once
      signal=1
      #MIXER=[determined automatically]
      #SCONTROL=[determined automatically]
      ##exposed format variables: ''${SYMB}, ''${VOL}, ''${INDEX}, ''${NAME}
      #LONG_FORMAT="''${SYMB} ''${VOL}% [''${INDEX}:''${NAME}]"
      #SHORT_FORMAT="''${SYMB} ''${VOL}% [''${INDEX}]"
      #AUDIO_HIGH_SYMBOL='  '
      #AUDIO_MED_THRESH=50
      #AUDIO_MED_SYMBOL='  '
      #AUDIO_LOW_THRESH=0
      #AUDIO_LOW_SYMBOL='  '
      #AUDIO_DELTA=5
      #DEFAULT_COLOR="#ffffff"
      #MUTED_COLOR="#a0a0a0"
      #USE_ALSA_NAME=0
      #USE_DESCRIPTION=0
      ## SUBSCRIBE=1 requires interval=persist and always uses LONG_FORMAT
      #SUBSCRIBE=0
      ```
    '';
    ".local/libexec/i3blocks/rofi-calendar".executable = true;
    ".local/libexec/i3blocks/rofi-calendar".text = ''
      #!/usr/bin/env bash

      ###### Variables ######
      DATEFTM="''${DATEFTM:-+%a %d %b %Y}"
      SHORTFMT="''${SHORTFMT:-+%d/%m/%Y}"
      LABEL="''${LABEL:- }"
      FONT="''${FONT:-Monospace 10}"
      LEFTCLICK_PREV_MONTH=''${LEFTCLICK_PREV_MONTH:-false}
      PREV_MONTH_TEXT="''${PREV_MONTH_TEXT:-« previous month «}"
      NEXT_MONTH_TEXT="''${NEXT_MONTH_TEXT:-» next month »}"
      ROFI_CONFIG_FILE="''${ROFI_CONFIG_FILE:-/dev/null}"
      BAR_POSITION="''${BAR_POSITION:-bottom}"
      WEEK_START="''${WEEK_START:-monday}"
      ###### Variables ######

      ###### Functions ######
      # get current date and set today header
      get_current_date() {
        year=$(date '+%Y')
        month=$(date '+%m')
        day=$(date '+%d')
      }
      # print the selected month
      print_month() {
        mnt=$1
        yr=$2
        cal --color=always --$WEEK_START $mnt $yr \
          | sed -e 's/\x1b\[[7;]*m/\<b\>\<u\>/g' \
                -e 's/\x1b\[[27;]*m/\<\/u\>\<\/b\>/g' \
                -e '/^ *$/d' \
          | tail -n +2
        echo $PREV_MONTH_TEXT$'\n'$NEXT_MONTH_TEXT
      }
      # increment year and/or month appropriately based on month increment
      increment_month() {
        # pick increment and define/update delta
        incr=$1
        (( delta += incr ))
        # for non-current month
        if (( incr != 0 )); then
          # add the increment
          month=$(( 10#$month + incr ))
          # normalize month and compute year
          if (( month > 0 )); then
            (( month -= 1 ))
            (( year += month/12 ))
            (( month %= 12 ))
            (( month += 1 ))
          else
            (( year += month/12 - 1 ))
            (( month %= 12 ))
            (( month += 12 ))
          fi
        fi
        # adjust header
        if (( delta == 0 )); then
          # today's month => show dd/mm/yyyy
          header=$(date "$DATEFTM")
        else
          # not today's month => show mm/yyyy
          header=$(cal $month $year | sed -n '1s/^ *\(.*[^ ]\) *$/\1/p')
        fi
      }
      ###### Functions ######

      ###### Main body ######
      get_current_date

      # handle the click
      # variables:
      #   current_row: set means today row is highlighted
      #   current_row: not set means...
      #     bias_row ==  0: `next month` row is highlighted
      #     bias_row == -1: `prev month` row is highlighted
      #   selected: contains the selected row (next or prev month)
      #   month_page: the month to be printed
      case "$BLOCK_BUTTON" in
        1)
          if [[ $LEFTCLICK_PREV_MONTH == true ]]; then
            increment_month -1
            bias_row=-1
          else
            increment_month 0
            current_row=
          fi
          ;;
        2)
          increment_month 0
          current_row=
          ;;
        3)
          increment_month +1
          bias_row=0
          ;;
      esac

      # rofi pop up
      case "$BLOCK_BUTTON" in
        1|2|3)
          # as long as prev/next is selected (and the first time also)
          while [[ "''${selected+xxx}" != "xxx" ]] || [[ $selected =~ ($PREV_MONTH_TEXT|$NEXT_MONTH_TEXT) ]]; do
            IFS=
            month_page=$(print_month $month $year)
            if [[ "''${current_row+xxx}" = "xxx" ]]; then
              current_row=$(( $(echo $month_page | grep -n ''${day#0} | head -n 1 | cut -d: -f1) - 1 ))
            else
              current_row=$(( $(echo $month_page | wc -l) - 1))
            fi

            # check bar position and adjust anchor accordingly
            if [[ $BAR_POSITION = "top" ]]; then
              anchor="northeast"
            else
              anchor="southeast"
            fi

            # open rofi and read the selected row
            # (add the following option to rofi command with proper config file, if needed)
            selected="$(echo $month_page \
              | rofi \
                  -dmenu \
                  -markup-rows \
                  -font $FONT \
                  -m -3 \
                  -theme-str 'window {width: 10%; anchor: '"$anchor"'; location: northwest;}' \
                  -theme-str 'listview {lines: '"$(echo $month_page | wc -l)"' ;scrollbar: false;}' \
                  -theme $ROFI_CONFIG_FILE \
                  -selected-row $(( current_row + bias_row )) \
                  -p "$header")"
            # select next/prev month if necessary and prepare row to be highlighted
            [[ $selected =~ $PREV_MONTH_TEXT ]] && { increment_month -1; bias_row=-1; }
            [[ $selected =~ $NEXT_MONTH_TEXT ]] && { increment_month +1; bias_row=0; }
            # get ready for successive next/prev month hits
            unset current_row
          done
      esac

      # print blocklet text
      echo $LABEL$(date "$DATEFTM")
      echo $LABEL$(date "$SHORTFMT")
      ###### Main body ######
    '';
    ".local/libexec/i3blocks/rofi-wttr".executable = true;
    ".local/libexec/i3blocks/rofi-wttr".text = ''
      #!/usr/bin/env bash

      ###### Variables ######
      LABEL="''${LABEL:- }"
      LOCATION="''${LOCATION:- }"
      FONT="''${FONT:-Monospace 10}"
      ROFI_CONFIG_FILE="''${ROFI_CONFIG_FILE:-/dev/null}"
      BAR_POSITION="''${BAR_POSITION:-bottom}"
      ###### Variables ######

      ###### Functions ######
      # print the full weather
      # see https://github.com/chubin/wttr.in#usage for full configuration options
      print_weather_report() {
        if [[ $LOCATION != " " ]]; then
          curl https://wttr.in/$LOCATION?T
        else
          curl https://wttr.in/?T
        fi
      }

      # print the one line weather
      # see https://github.com/chubin/wttr.in#one-line-output for formatting options
      print_weather_line() {
        if [[ $LOCATION != " " ]]; then
          curl -s https://wttr.in/''${LOCATION}?u\&format="%C+%c+%t+(%f)+%w" | tr -d \"
        else
          curl -s 'https://wttr.in/?u\&format="%C+%c+%t+(%f)+%w"' | tr -d \"
        fi
      }
      ###### Functions ######

      ###### Main body ######
      # handle any click
      # rofi pop up
      case "$BLOCK_BUTTON" in
        1|2|3)
            IFS=
            weather_report=$(print_weather_report)

            # check bar position and adjust anchor accordingly
            if [[ $BAR_POSITION = "top" ]]; then
              anchor="northwest"
            else
              anchor="southwest"
            fi

            # open rofi
            # (add the following option to rofi command with proper config file, if needed)
            echo $weather_report \
              | rofi \
                  -dmenu \
                  -markup-rows \
                  -font $FONT \
                  -m -3 \
                  -theme-str 'window {width: 53%; anchor: '"$anchor"'; location: northwest;}' \
                  -theme-str 'listview {lines: '"$(echo $weather_report | wc -l)"' ;scrollbar: false;}' \
                  -theme $ROFI_CONFIG_FILE \
                  -p "Detailed weather report"
      esac

      # print blocklet text

      if [[ $LABEL != " " ]]; then
        echo $LABEL$(print_weather_line)
      else
        echo $(print_weather_line)
      fi
      ###### Main body ######
    '';
    ".local/libexec/i3blocks/shutdown_menu".executable = true;
    ".local/libexec/i3blocks/shutdown_menu".text = ''
      #!/usr/bin/env bash
      #
      # Use rofi/zenity to change system runstate thanks to systemd.
      #
      # Note: this currently relies on associative array support in the shell.
      #
      # Inspired from i3pystatus wiki:
      # https://github.com/enkore/i3pystatus/wiki/Shutdown-Menu
      #
      # Copyright 2015 Benjamin Chrétien <chretien at lirmm dot fr>
      #
      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #######################################################################
      #                            BEGIN CONFIG                             #
      #######################################################################

      # Use a custom lock script
      #LOCKSCRIPT="i3lock-extra -m pixelize"

      # Colors: FG (foreground), BG (background), HL (highlighted)
      FG_COLOR="''${FG_COLOR:-#bbbbbb}"
      BG_COLOR="''${BG_COLOR:-#111111}"
      HLFG_COLOR="''${HLFG_COLOR:-#111111}"
      HLBG_COLOR="''${HLBG_COLOR:-#bbbbbb}"
      BORDER_COLOR="''${BORDER_COLOR:-#222222}"

      # Options not related to colors
      ROFI_TEXT="''${ROFI_TEXT:-Menu:}"
      ROFI_OPTIONS=(''${ROFI_OPTIONS:--theme-str 'window {width: 11%; border: 2;} listview {scrollbar: false;}' -location 3})

      # Zenity options
      ZENITY_TITLE="''${ZENITY_TITLE:-Menu}"
      ZENITY_TEXT="''${ZENITY_TEXT:-Action:}"
      ZENITY_OPTIONS=(''${ZENITY_OPTIONS:---column= --hide-header})

      #######################################################################
      #                             END CONFIG                              #
      #######################################################################

      # Whether to ask for user's confirmation
      enable_confirmation=''${ENABLE_CONFIRMATIONS:-false}

      # Preferred launcher if both are available
      preferred_launcher="''${LAUNCHER:-rofi}"

      usage="$(basename "$0") [-h] [-c] [-p name] -- display a menu for shutdown, reboot, lock etc.

      where:
          -h  show this help text
          -c  ask for user confirmation
          -p  preferred launcher (rofi or zenity)

      This script depends on:
        - systemd,
        - i3,
        - rofi or zenity."

      # Check whether the user-defined launcher is valid
      launcher_list=(rofi zenity)
      function check_launcher() {
        if [[ ! "''${launcher_list[@]}" =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]; then
          echo "Supported launchers: ''${launcher_list[*]}"
          exit 1
        else
          # Get array with unique elements and preferred launcher first
          # Note: uniq expects a sorted list, so we cannot use it
          i=1
          launcher_list=($(for l in "$1" "''${launcher_list[@]}"; do printf "%i %s\n" "$i" "$l"; let i+=1; done \
            | sort -uk2 | sort -nk1 | cut -d' ' -f2- | tr '\n' ' '))
        fi
      }

      # Parse CLI arguments
      while getopts "hcp:" option; do
        case "''${option}" in
          h) echo "''${usage}"
             exit 0
             ;;
          c) enable_confirmation=true
             ;;
          p) preferred_launcher="''${OPTARG}"
             check_launcher "''${preferred_launcher}"
             ;;
          *) exit 1
             ;;
        esac
      done
      check_launcher "''${preferred_launcher}"

      # Check whether a command exists
      function command_exists() {
        command -v "$1" &> /dev/null 2>&1
      }

      # systemctl required
      if ! command_exists systemctl ; then
        exit 1
      fi

      # menu defined as an associative array
      typeset -A menu

      # Menu with keys/commands
      menu=(
        [Shutdown]="systemctl poweroff"
        [Reboot]="systemctl reboot"
        [Hibernate]="systemctl hibernate"
        [Suspend]="systemctl suspend"
        [Halt]="systemctl halt"
        [Lock]="''${LOCKSCRIPT:-i3lock --color=''${BG_COLOR#"#"}}"
        [Logout]="i3-msg exit"
        [Cancel]=""
      )
      menu_nrows=''${#menu[@]}

      # Menu entries that may trigger a confirmation message
      menu_confirm="Shutdown Reboot Hibernate Suspend Halt Logout"

      launcher_exe=""
      launcher_options=""
      rofi_colors=""

      function prepare_launcher() {
        if [[ "$1" == "rofi" ]]; then
          rofi_colors=(-bc "''${BORDER_COLOR}" -bg "''${BG_COLOR}" -fg "''${FG_COLOR}" \
              -hlfg "''${HLFG_COLOR}" -hlbg "''${HLBG_COLOR}")
          launcher_exe="rofi"
          launcher_options=(-dmenu -i -lines "''${menu_nrows}" -p "''${ROFI_TEXT}" \
              "''${rofi_colors[@]}" "''${ROFI_OPTIONS[@]}")
        elif [[ "$1" == "zenity" ]]; then
          launcher_exe="zenity"
          launcher_options=(--list --title="''${ZENITY_TITLE}" --text="''${ZENITY_TEXT}" \
              "''${ZENITY_OPTIONS[@]}")
        fi
      }

      for l in "''${launcher_list[@]}"; do
        if command_exists "''${l}" ; then
          prepare_launcher "''${l}"
          break
        fi
      done

      # No launcher available
      if [[ -z "''${launcher_exe}" ]]; then
        exit 1
      fi

      launcher=(''${launcher_exe} "''${launcher_options[@]}")
      selection="$(printf '%s\n' "''${!menu[@]}" | sort | "''${launcher[@]}")"

      function ask_confirmation() {
        if [ "''${launcher_exe}" == "rofi" ]; then
          confirmed=$(echo -e "Yes\nNo" | rofi -dmenu -i -lines 2 -p "''${selection}?" \
            "''${rofi_colors[@]}" "''${ROFI_OPTIONS[@]}")
          [ "''${confirmed}" == "Yes" ] && confirmed=0
        elif [ "''${launcher_exe}" == "zenity" ]; then
          zenity --question --text "Are you sure you want to ''${selection,,}?"
          confirmed=$?
        fi

        if [ "''${confirmed}" == 0 ]; then
          i3-msg -q "exec ''${menu[''${selection}]}"
        fi
      }

      if [[ $? -eq 0 && ! -z ''${selection} ]]; then
        if [[ "''${enable_confirmation}" = true && \
              ''${menu_confirm} =~ (^|[[:space:]])"''${selection}"($|[[:space:]]) ]]; then
          ask_confirmation
        else
          i3-msg -q "exec ''${menu[''${selection}]}"
        fi
      fi
    '';
    ".local/libexec/i3blocks/speedtest".executable = true;
    ".local/libexec/i3blocks/speedtest".text = ''
      #!/usr/bin/env bash

      # Copyright (C) 2018 Nikolas De Giorgis <nikolas.degiorgis@gmail.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      IFS=
      result=`speedtest-cli --bytes --simple`
      PING=`echo $result | sed -n 1p |cut -d ':' -f2 | cut -d ' ' -f2`

      DOWN=`echo $result | sed -n 2p |cut -d ':' -f2 | cut -d ' ' -f2`

      UP=`echo $result | sed -n 3p |cut -d ':' -f2 | cut -d ' ' -f2`

      echo  $PING" ms" $DOWN "MB/s" $UP "MB/s"
    '';
    ".local/libexec/i3blocks/spotifyd_dbus".executable = true;
    ".local/libexec/i3blocks/spotifyd_dbus".text = ''
      #!/usr/bin/env python3

      import dbus
      import sys

      def progressBar(perc : float):
          char = ["░", "▒", "█"]
          bar = char[2] * int(perc / 0.2)
          if perc >= 0.99:
              return bar + char[2]
          bar += char[1]
          while len(bar) != 5:
              bar += char[0]
          return bar

      def main():
          bus = dbus.SessionBus()
          proxy = bus.get_object('org.mpris.MediaPlayer2.spotifyd','/org/mpris/MediaPlayer2')

          properties_manager = dbus.Interface(proxy, 'org.freedesktop.DBus.Properties')

          if properties_manager:

              if len(sys.argv) > 1:
                  if sys.argv[1] == "1":
                      dbus.Interface(proxy, 'org.mpris.MediaPlayer2.Player').PlayPause()

              status = properties_manager.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')
              if status == "Playing" : status = " "
              else : status = " "

              current = properties_manager.Get('org.mpris.MediaPlayer2.Player', 'Position')

              data = properties_manager.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
              length = data["mpris:length"]
              title = data["xesam:title"]

              perc = current / length
              progress = progressBar(perc)
              bar = f" [ {title} ]  {status} {progress}"
              print(bar)

      if __name__ == "__main__":
          main()
    '';
    ".local/libexec/i3blocks/ssid".executable = true;
    ".local/libexec/i3blocks/ssid".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2020 hseg <gesh@gesh.uni.cx>
      # Copyright (C) 2014 Alexander Keller <github@nycroth.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #------------------------------------------------------------------------
      if [[ -z "$INTERFACE" ]] ; then
          INTERFACE="''${BLOCK_INSTANCE:-wlan0}"
      fi
      #------------------------------------------------------------------------

      # As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
      # connection (think desktop), the corresponding block should not be displayed.
      # Similarly, if the wifi interface exists but no connection is active, show
      # nothing
      [[ ! -d /sys/class/net/"''${INTERFACE}"/wireless || \
          "$(cat /sys/class/net/"$INTERFACE"/operstate)" = 'down' ]] && exit

      #------------------------------------------------------------------------

      SSID=$(iw "$INTERFACE" info | awk '/ssid/ {$1=""; print $0}')

      #------------------------------------------------------------------------

      echo "$SSID" # full text
      echo "$SSID" # short text
      echo "#00FF00" # color
    '';
    ".local/libexec/i3blocks/sway-focusedwindow".executable = true;
    ".local/libexec/i3blocks/sway-focusedwindow".text = ''
      #!/usr/bin/env bash

      maxlen=0
      if [[ $1 ]]; then
        maxlen=$1
      fi

      align="center"
      if [[ $2 ]]; then
        align=$2
      fi

      format() {
        if [[ $maxlen == 0 ]]; then
          echo "$1"
          return 0
        fi
        len=''${#1}
        if [[ $len -ge $maxlen ]]; then
          echo "''${1:0:''${maxlen}}"
        else
          pad=$(( maxlen - len ))
          case "$align" in
            "center" )
              pad=$(( pad / 2 ))
              printf "%*s%s%*s\n" $pad "" "$1" $pad ""
              ;;
            "left" )
              printf "%s%*s\n" "$1" $pad "" 
              ;;
            "right" )
              printf "%*s%s\n" $pad "" "$1"
              ;;
          esac
        fi
      }

      process() {
        while read -r LINE; do
          format "$LINE"
        done
      }

      swaymsg -t get_tree | jq --unbuffered -r '.. | select(.focused?) | .name' | process

      subscribe_query='select(.container.focused and (.change == "focus" or .change == "title")) | .container.name'
      swaymsg -m -t SUBSCRIBE "['window']" | jq --unbuffered -r "$subscribe_query" | process
    '';
    ".local/libexec/i3blocks/systemctl".executable = true;
    ".local/libexec/i3blocks/systemctl".text = ''
      #!/usr/bin/env bash

      # The service we want to check or toggle (according to systemctl)
      SERVICE=$BLOCK_INSTANCE
      # Colors to display
      INACTIVE_COLOR=#888888
      ACTIVE_COLOR=#22BB22
      # Exact string to display
      ACTIVE="<span foreground=\"$ACTIVE_COLOR\">$SERVICE</span>"
      INACTIVE="<span foreground=\"$INACTIVE_COLOR\"><s>$SERVICE</s></span>"

      if [ "$( systemctl is-active "$SERVICE" )" != "active" ]
      then
        if [ "$BLOCK_BUTTON" == '1' ]
        then
          if systemctl start "$SERVICE"
          then
            echo "$ACTIVE"
          fi
        fi
        echo "$INACTIVE"
      else
        if [ "$BLOCK_BUTTON" == '1' ]
        then
            if systemctl stop "$SERVICE"
          then
            echo "$INACTIVE"
          fi
        fi
        echo "$ACTIVE"
      fi
    '';
    ".local/libexec/i3blocks/systemd_unit".executable = true;
    ".local/libexec/i3blocks/systemd_unit".text = ''
      #!/usr/bin/env bash

      if [[ $USER_UNIT == "true" ]]
      then
          bus="--session"
      else
          bus="--system"
      fi

      if [[ -z $FAILED_COLOR ]]
      then
          FAILED_COLOR=red
      fi

      if [[ -z $INACTIVE_COLOR ]]
      then
          INACTIVE_COLOR=orange
      fi

      if [[ -n $ACTIVE_COLOR ]]
      then
          ACTIVE_COLOR=" color='$ACTIVE_COLOR'"
      fi
      # echo $FAILED_COLOR

      object_path=$(dbus-send $bus --print-reply --dest=org.freedesktop.systemd1 /org/freedesktop/systemd1 org.freedesktop.systemd1.Manager.GetUnit string:"''${UNIT_NAME}" | grep -Po '"\K[^"]+')
      status=$(dbus-send $bus --dest=org.freedesktop.systemd1 --print-reply "$object_path" org.freedesktop.DBus.Properties.Get string:'org.freedesktop.systemd1.Unit' string:'ActiveState' | grep -oP 'string "\K[^"]+')

      if [[ $status == "failed" ]]
      then
          echo "<span color='$FAILED_COLOR'>$status</span>"
      elif [[ $status == "inactive" ]]
      then
          echo "<span color='$INACTIVE_COLOR'>$status</span>"
      else
          echo "<span''${ACTIVE_COLOR}>$status</span>"
      fi
    '';
    ".local/libexec/i3blocks/tahoe-lafs".executable = true;
    ".local/libexec/i3blocks/tahoe-lafs".text = ''
      #!/usr/bin/env bash

      NODE_URL=''${BLOCK_INSTANCE%/}
      DISK_AVAIL=$(curl -s "$NODE_URL/statistics?t=json" 2>/dev/null| jq -r '.stats."storage_server.disk_avail"')

      if [[ -n "$DISK_AVAIL" ]] && [[ "$DISK_AVAIL" != "null" ]]; then
          DISK_AVAIL=$(echo "$DISK_AVAIL" | awk '
          {
              GB=$1/1024/1024/1024
              if(GB<1000){
                  printf "%.1fG\n", GB
              }
              else{
                  printf "%.1fT\n", GB/1024
              }
          }')
          echo "tahoe: $DISK_AVAIL"
      else
          echo "tahoe down"
          echo "tahoe down"
          echo "#FF0000"
      fi
    '';
    ".local/libexec/i3blocks/taskw".executable = true;
    ".local/libexec/i3blocks/taskw".text = ''
      #!/usr/bin/env python3

      """Extracts information from taskwarrior and timewarrior to display in i3block."""

      # This is taskw.py v0.3.1

      import subprocess
      import json
      import os
      import re

      # config options code

      def _default(name, default="", arg_type=str):
          """
          Set a parameter based on OS variable.

          Fix the argument type and fall back on given default.

          """
          val = default
          if name in os.environ:
              val = os.environ[name]
          return arg_type(val)


      def _strbool(s):
          """Return True if argument is t,T,true,TRUE etc."""
          return s.lower() in ["t", "true", "1"]

      # I don't know who originally wrote these functions,
      # but many of the python blocklets in i3blocks-contrib use it.

      # arch-update added this code on 25 March 2018 and as far as I can tell
      # this was the earliest use.

      maxlen = _default("TASKW_MAX_LENGTH", default=35, arg_type=int)
      notask_msg = _default("TASKW_NOTASK_MSG", default="No Task", arg_type=str)
      urgency_tf = _default("TASKW_SORT_URGENCY", default="f", arg_type=_strbool)
      taskw_tf = _default("TASKW_TF", default="t", arg_type=_strbool)
      timew_tf = _default("TIMEW_TF", default="f", arg_type=_strbool)
      pending_tasks_tf = _default("TASKW_PENDING_TF", default="f", arg_type=_strbool)
      timew_desc_override = _default("TIMEW_DESC_OVERRIDE", default="f", arg_type=_strbool)
      main_filter = _default("TASKW_MAIN_FILTER", default="+ACTIVE", arg_type=str)

      # Set timew_tf to true if the override is set.
      if timew_desc_override:
          timew_tf = True

      ##############################
      # TESTING TESTING TESTING

      # taskw_tf = False
      # timew_tf = True
      # timew_desc_override = True
      # pending_tasks_tf = True
      # notask_msg = "~No Task~"
      ##############################

      # text output helper functions

      def shorten(string, maxlen=maxlen):
          """Shorten a string to maxlen characters or fewer."""
          if len(string) <= maxlen:
              return string
          else:
              return string[: maxlen - 3] + "..."

      # taskw functions

      def get_taskw_json(filter_string):
          """Take a taskw filter and returns the json output for task export."""
          return json.loads(
              subprocess.check_output("task " + filter_string + " export", shell=True)
          )

      def sort_taskw_info(taskw_json):
          """
          Return task description to display plus number of tasks.

          Take json output from taskw and return the correct task description
          to display and also the number of tasks matching the filter.
          """
          max_urg = 0
          if len(taskw_json) > 0:
              if urgency_tf:
                  for i in range(len(taskw_json)):
                      if taskw_json[i]["urgency"] > taskw_json[max_urg]["urgency"]:
                          max_urg = i
              return taskw_json[max_urg]["description"], len(taskw_json)
          else:
              return notask_msg, 0

      def get_taskw_info(taskw_filter=main_filter):
          """Take a filter and return a task description and number of tasks."""
          j = get_taskw_json(taskw_filter)
          return sort_taskw_info(j)

      def export_pending():
          """Return number of taskw pending tasks."""
          return len(get_taskw_json("+PENDING"))

      # timew functions

      def get_timew_bytes(dom_string):
          """Return byte output from calling timew."""
          try:
              out = subprocess.check_output("timew get " + dom_string, shell=True)
          except subprocess.CalledProcessError:
              out = b""
          return out

      def decode_timew_bytes(in_bytes):
          """
          Take timew byte input and return string.

          This function also strips the trailing newline.
          """
          to_string = in_bytes.decode("utf-8")[:-1]
          return to_string

      def get_timew_string(dom_string):
          """Return string decoded output from calling timew with dom_string."""
          in_string = get_timew_bytes(dom_string)
          return decode_timew_bytes(in_string)

      def get_timew_active():
          """Return True if timew has active tracking."""
          return b"1" in get_timew_bytes("dom.active")

      def export_timew_description():
          """
          Extract description from timew output.

          Actually extracts first tag.

          """
          timew_txt = get_timew_string("dom.active.tag.1")
          return timew_txt if get_timew_active() else notask_msg

      def pad_time(s):
          """Add '0' to number if necessary."""
          return s if len(s) == 2 else "0" + s

      def extract_time(delimiter, input_string):
          """Extract number of hours|minutes|seconds from timew output."""
          match_list = re.findall(r"\d?\d" + delimiter, input_string)
          return pad_time(match_list[0][:-1]) if len(match_list) > 0 else "00"

      def translate_timew_string(timew_in_str):
          """Turn timew output time into duration in HH:MM format."""
          duration_hrs = extract_time("H", timew_in_str)
          duration_mins = extract_time("M", timew_in_str)
          return duration_hrs + ":" + duration_mins

      def main():
          """Return string to display based on params."""
          task_desc = ""
          task_append = ""
          timew_duration = ""
          pending_text = ""
          if taskw_tf:
              descr, task_num = get_taskw_info()
              task_desc = shorten(descr)
              if task_num > 1:
                  task_append = " + " + str(task_num - 1)

          if timew_tf:
              get_string = get_timew_string("dom.active.duration")
              timew_duration = (
                  translate_timew_string(get_string) + " " if get_timew_active() else ""
              )

          if timew_desc_override or not taskw_tf:
              task_desc = shorten(export_timew_description())

          if pending_tasks_tf:
              pending_text = f" [{export_pending()}]"

          bar_text = timew_duration + task_desc + task_append + pending_text
          return bar_text

      if __name__ == "__main__":
          print(main())
    '';
    ".local/libexec/i3blocks/temperature".executable = true;
    ".local/libexec/i3blocks/temperature".text = ''
      #!/usr/bin/env perl
      # Copyright 2014 Pierre Mavro <deimos@deimos.fr>
      # Copyright 2014 Vivien Didelot <vivien@didelot.org>
      # Copyright 2014 Andreas Guldstrand <andreas.guldstrand@gmail.com>
      # Copyright 2014 Benjamin Chretien <chretien at lirmm dot fr>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      use strict;
      use warnings;
      use utf8;
      use Getopt::Long;

      binmode(STDOUT, ":utf8");

      # default values
      my $t_warn = $ENV{T_WARN} || 70;
      my $t_crit = $ENV{T_CRIT} || 90;
      my $chip = $ENV{SENSOR_CHIP} || "";
      my $temperature = -9999;

      sub help {
          print "Usage: temperature [-w <warning>] [-c <critical>] [--chip <chip>]\n";
          print "-w <percent>: warning threshold to become yellow\n";
          print "-c <percent>: critical threshold to become red\n";
          print "--chip <chip>: sensor chip\n";
          exit 0;
      }

      GetOptions("help|h" => \&help,
                 "w=i"    => \$t_warn,
                 "c=i"    => \$t_crit,
                 "chip=s" => \$chip);

      # Get chip temperature
      open (SENSORS, "sensors -u $chip |") or die;
      while (<SENSORS>) {
          if (/^\s+temp1_input:\s+[\+]*([\-]*\d+\.\d)/) {
              $temperature = $1;
              last;
          }
      }
      close(SENSORS);

      $temperature eq -9999 and die 'Cannot find temperature';

      # Print short_text, full_text
      print "$temperature°C\n" x2;

      # Print color, if needed
      if ($temperature >= $t_crit) {
          print "#FF0000\n";
          exit 33;
      } elsif ($temperature >= $t_warn) {
          print "#FFFC00\n";
      }

      exit 0;
    '';
    ".local/libexec/i3blocks/temperature-status".executable = true;
    ".local/libexec/i3blocks/temperature-status".text = ''
      #!/usr/bin/env bash

      # Change this according to your devices

      # Coretemp
      cpu_core_temp=$(printf "%.1f\n" $(echo $(cat /sys/class/thermal/thermal_zone0/temp)/1000 | bc -l))
      temp_icon="<span font='icon'>🌡</span>" # thermometer icon
      #temp_icon=$'\U0001F321' # thermometer icon

      echo "$temp_icon $cpu_core_temp°C"

      exit 0
    '';
    ".local/libexec/i3blocks/time".executable = true;
    ".local/libexec/i3blocks/time".text = ''
      #!/usr/bin/env perl

      use strict;
      use warnings;
      use POSIX qw/strftime/;

      my $click   = $ENV{BLOCK_BUTTON} || 0;
      my $format  = $ENV{BLOCK_INSTANCE} || $ENV{STRFTIME_FORMAT} || "%H:%M";
      my $tz_file = shift || $ENV{TZ_FILE} || "$ENV{HOME}/.tz";
      $tz_file = glob($tz_file);
      my $default_tz = get_default_tz();

      my $tzones = $ENV{TZONES} || '$DEFAULT_TZ';
      $tzones =~ s/\$DEFAULT_TZ/$default_tz/g;
      my @tz_list = split(/,/, $tzones);
      my @tz_labels = split(/,/, $ENV{TZ_LABELS} || "");
      if (scalar(@tz_list) != scalar(@tz_labels)) {
          @tz_labels = @tz_list;
      }

      my $current_tz;
      if ($click == 1) {
          $current_tz = get_tz();

          my %tzmap;
          $tzmap{""} = $tz_list[0];
          my $prev = $tz_list[0];
          foreach my $tz (@tz_list) {
              $tzmap{$prev} = $tz;
              $prev = $tz;
          }
          $tzmap{$prev} = $tz_list[0];

          if (exists $tzmap{$current_tz}) {
              set_tz($tzmap{$current_tz});
              $current_tz = $tzmap{$current_tz};
          }
      }

      # How each timezone will be displayed in the bar.
      my %display_map;
      for (my $i=0; $i < scalar(@tz_list); $i++) {
          $display_map{$tz_list[$i]} = $tz_labels[$i];
      }

      if (!defined $current_tz) {
          $current_tz = get_tz();
          set_tz($current_tz);
      }
      $ENV{TZ} = $current_tz;
      my $tz_display = "";
      if (!exists $display_map{$ENV{TZ}}) {
          $ENV{TZ} = $tz_list[0];
          set_tz($tz_list[0]);
      }
      $tz_display = $display_map{$ENV{TZ}};

      binmode(STDOUT, ":utf8");
      my $time = strftime($format, localtime());
      if ($tz_display eq "") {
          print "$time\n";
      } else {
          print "$time ($tz_display)\n";
      }

      sub get_tz {
          my $current_tz;

          if (-f $tz_file) {
              open my $fh, '<', $tz_file || die "Couldn't open file: $tz_file";
              $current_tz = <$fh>;
              chomp $current_tz;
              close $fh;
          }

          return $current_tz || get_default_tz();
      }

      sub set_tz {
          my $tz = shift;

          open my $fh, '>', $tz_file || die "Couldn't open file: $tz_file";
          print $fh $tz;
          close $fh;
      }

      sub get_default_tz {
          my $tz = "Europe/London";

          if (-f "/etc/timezone") {
              open my $fh, '<', "/etc/timezone" || die "Couldn't open file: /etc/timezone";
              $tz = <$fh>;
              chomp $tz;
              close $fh;
          } elsif (-l "/etc/localtime") {
              $tz = readlink "/etc/localtime";
              $tz = (split /zoneinfo\//, $tz)[-1];
          }

          return $tz;
      }
    '';
    ".local/libexec/i3blocks/timer_and_stopwatch".executable = true;
    ".local/libexec/i3blocks/timer_and_stopwatch".text = ''
      #!/usr/bin/env bash
      ###### Default environment variables ######
      STOPWATCH_LABEL=''${STOPWATCH_LABEL:-stopwatch}
      TIMER_LABEL=''${TIMER_LABEL:-timer}
      DEFAULT_MODE=''${DEFAULT_MODE:-timer}
      DEFAULT_STOPWATCH=''${DEFAULT_STOPWATCH:-0}
      DEFAULT_TIMER=''${DEFAULT_TIMER:-60}
      PLAY_LABEL=''${PLAY_LABEL:-(playing)}
      PAUSE_LABEL=''${PAUSE_LABEL:-(paused)}
      TIMER_LOOP=''${TIMER_LOOP:-false}
      NEUTRAL_COLOR=''${NEUTRAL_COLOR:-#000000}
      ###### Default environment variables ######

      ###### Functions ######
      error() {
        echo Error: "$@" 1>&2
      }

      next_mode() {
        mode=$(( (mode + 1) % ''${#modes[@]} ))
        set_mode
      }

      play_pause() {
        $running && pause || play
      }

      play() {
        running=true
        status_symbol=$PLAY_LABEL
      }

      pause() {
        running=false
        status_symbol=$PAUSE_LABEL
      }

      reset_times() {
        unset time
        set_mode
      }

      set_mode() {
        case ''${modes[$mode]} in
          'timer' )
            running=false
            status_symbol=$PAUSE_LABEL
            initial_time=''${initial_time-$DEFAULT_TIMER}
            time=$initial_time
            incr=-1
            ;;
          'stopwatch' )
            running=false
            status_symbol=$PAUSE_LABEL
            time=''${time-$DEFAULT_STOPWATCH}
            fgcolor='#FFFFFF'
            bgcolor=$NEUTRAL_COLOR
            incr=1
            ;;
        esac
      }

      compute_color() {
        t=$1
        hue360=$(( 120*t/initial_time ))
        tmp=$(( hue360 % 120 - 60 ))
        tmp=$(( (60 - ''${tmp#-})*255/60 ))
        if (( hue360 < 60 && hue360 >= 0 )); then
          R=255 G=$tmp B=0
        elif (( hue360 <= 120 && hue360 >= 60 )); then
          R=$tmp G=255 B=0
        fi
        printf '#%06X\n' $(( R*16*16*16*16 + G*16*16 + B ))
      }

      prettify_time() {
        seconds=$time
        if (( time >= 60 )); then
          minutes=$(( time / 60 ))
          seconds=$(( time % 60 ))
          (( seconds < 10 )) && seconds=0$seconds
        fi
        if (( minutes >= 60 )); then
          hours=$(( minutes / 60 ))
          minutes=$(( minutes % 60 ))
          (( minutes < 10 )) && minutes=0$minutes
        fi
        echo $hours''${hours+:}$minutes''${minutes+:}$seconds
      }
      ###### Functions ######

      ###### Internal variables ######
      modes=([0]='timer' [1]='stopwatch')
      labels=([0]="$TIMER_LABEL" [1]="$STOPWATCH_LABEL")
      ###### Internal variables ######

      ###### First run initialization ######
      if [[ ! -v time ]]; then
        for i in "''${!modes[@]}"; do
          if [[ "''${modes[$i]}" == "$DEFAULT_MODE" ]]; then
            mode=$i
          fi
        done
        set_mode
      fi
      ###### First run initialization ######

      ###### Click processing ######
      case $BLOCK_BUTTON in
        1 )
          play_pause
          ;;
        2 )
          reset_times
          ;;
        3 )
          next_mode
          reset_times
          pause
          ;;
        4 )
          $running && pause
          initial_time=$(( initial_time + 1 ))
          time=$initial_time
          ;;
        5 )
          $running && pause
          initial_time=$(( initial_time - 1 ))
          time=$initial_time
          ;;
      esac
      ###### Click processing ######

      ###### Time increment ######
      $running && time=$(( time + incr ))
      if (( mode == 0 )); then
        if (( time <= 0 )); then
          bgcolor='#FF0000'
          fgcolor=$NEUTRAL_COLOR
          time=0
          pause
        elif (( time > 0 )); then
          fgcolor=$(compute_color $time)
          bgcolor=$NEUTRAL_COLOR
        fi
      else
        bgcolor=$NEUTRAL_COLOR
        fgcolor='#FFFFFF'
      fi
      full_text="''${labels[$mode]} $status_symbol $(prettify_time)"
      if (( mode == 0 && time == 0 )); then
          $TIMER_LOOP && reset_times && play
      fi
      ###### Time increment ######

      ###### Output ######
      cat << EOF
      {"full_text":"$full_text",\
      "status_symbol":"$status_symbol",\
      "time":"$time",\
      "initial_time":"$initial_time",\
      "incr":"$incr",\
      "running":"$running",\
      "mode":"$mode",\
      "color":"$fgcolor",\
      "background":"$bgcolor"}
      EOF
      ###### Output ######
    '';
    ".local/libexec/i3blocks/toggle".executable = true;
    ".local/libexec/i3blocks/toggle".text = ''
      #!/usr/bin/env bash

      if [[ -z ''${COMMAND_ON} || -z ''${COMMAND_OFF} || -z ''${COMMAND_STATUS} ]]; then
        echo "All of COMMAND_ON, COMMAND_OFF, and COMMAND_STATUS are required" >&2
        exit 1
      fi

      on_cmd=''${COMMAND_ON}
      off_cmd=''${COMMAND_OFF}
      status_cmd=''${COMMAND_STATUS}

      if (( ''${BLOCK_BUTTON:-0} == 1 )); then
        eval $status_cmd 2>&1 >/dev/null
        if (( $? == 0 )); then
          eval $off_cmd 2>&1 >/dev/null
        else
          eval $on_cmd 2>&1 >/dev/null
        fi
      fi

      eval $status_cmd 2>&1 >/dev/null
      if (( $? == 0 )); then
        COLOR=''${COLOR_ON}
      else
        COLOR=''${COLOR_OFF:-#555555}
      fi

      echo
      echo
      echo $COLOR
    '';
    ".local/libexec/i3blocks/usb".executable = true;
    ".local/libexec/i3blocks/usb".text = ''
      #!/usr/bin/env python3
      #
      # Copyright (C) 2015 James Murphy
      # Licensed under the terms of the GNU GPL v2 only.
      #
      # i3blocks blocklet script to output connected usb storage device info.

      import os

      def _default(name, default=''', arg_type=str):
          val = default
          if name in os.environ:
              val = os.environ[name]
          return arg_type(val)

      ###############################################################################
      # BEGIN CONFIG
      # Most of these can be specified as command line options, run with --help for
      # more information.
      # You may edit any of the following entries.  DO NOT delete any of them, else
      # the main script will have unpredictable behavior.
      ###############################################################################

      # Color options, can be a color name or #RRGGBB
      INFO_TEXT_COLOR = _default("INFO_TEXT_COLOR", "white")
      MOUNTED_COLOR = _default("MOUNTED_COLOR", "green")
      PLUGGED_COLOR = _default("PLUGGED_COLOR", "gray")
      LOCKED_COLOR = _default("LOCKED_COLOR", "gray")
      UNLOCKED_NOT_MOUNTED_COLOR = _default("UNLOCKED_NOT_MOUNTED_COLOR", "yellow")
      PARTITIONLESS_COLOR = _default("PARTITIONLESS_COLOR", "red")

      # Default texts
      PARTITIONLESS_TEXT = _default("PARTITIONLESS_TEXT", "no partitions")
      SEPARATOR = _default("SEPARATOR", "<span color='gray'> | </span>")

      # Indicate whether an encrypted partition is locked/unlocked, "" is allowed.
      LOCKED_INDICATOR = _default("LOCKED_INDICATOR", "\uf023 ")
      UNLOCKED_INDICATOR = _default("UNLOCKED_INDICATOR", "\uf09c ")

      # Shows instead of space available when a partition is mounted readonly
      READONLY_INDICATOR = _default("READONLY_INDICATOR", "ro")

      # Maximum length of a filesystem label to display. Use None to disable
      # truncation, a positive integer to right truncate to that many characters, or
      # a negative integer to left truncate to that many characters. Setting this
      # option to 0 will disable the displaying of filesystem labels.
      TRUNCATE_FS_LABELS = _default("TRUNCASE_FS_LABELS", None)

      # List of devices to ignore. Must be a valid python3 representation of a list
      # of strings
      IGNORE_LIST = _default("IGNORE_LIST", "[]")
      if IGNORE_LIST:
          import ast
          IGNORE_LIST = list(map(lambda p:
                                 p if p.startswith("/")
                                 else "/dev/{}".format(p),
                                 ast.literal_eval(IGNORE_LIST)
                                 ))

      # Edit this function to ignore certain devices (e.g. those that are always
      # plugged in).
      # The dictionary udev_attributes_dict contains all the attributes given by
      # udevadm info --query=propery --name=$path
      def ignore(path, udev_attributes_dict):
          # E.g. how to ignore devices whose device name begins with /dev/sda
          # if udev_attributes_dict["DEVNAME"].startswith("/dev/sda"):
          #     return True
          return False

      # Edit this function to ignore devices before the udev attributes are
      # computed in order to save time and memory.
      def fastIgnore(path):
          if path in IGNORE_LIST:
              return True

          # E.g. how to to ignore devices whose path begins with /dev/sda
          # if path.startswith("/dev/sda"):
          #     return True

          # E.g. how to ignore a fixed set of paths
          # if path in [ "/dev/path1", "/dev/path2", "/dev/path3" ]:
          #     return True
          return False

      ###############################################################################
      # END CONFIG
      # DO NOT EDIT ANYTHING AFTER THIS POINT UNLESS YOU KNOW WHAT YOU ARE DOING
      ###############################################################################

      from subprocess import check_output
      import argparse

      def pangoEscape(text):
          return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")

      def getLeafDevicePaths():
          lines = check_output(['lsblk', '-lpno', 'NAME'], universal_newlines=True)
          lines = lines.split("\n")
          lines = filter(lambda s: s[:4]=='/dev', lines)
          lines = map(lambda s: s.split(' ')[0], lines)
          lines = filter(None, lines)
          return lines

      def getKernelName(path):
          return check_output(['lsblk', '-lndo', 'KNAME', path],
                  universal_newlines=True).rstrip("\n")

      def getDeviceType(path):
          return check_output(['lsblk', '-no', 'TYPE', path],
                              universal_newlines=True).strip()

      def getFSType(path):
          global attributeMaps
          return attributeMaps[path].get("ID_FS_TYPE")

      def isLUKSPartition(path):
          return getFSType(path) == "crypto_LUKS"

      def isSwapPartition(path):
          return getFSType(path) == "swap"

      def getFSLabel(path):
          global attributeMaps
          label = attributeMaps[path].get("ID_FS_LABEL_ENC", "")
          if label:
              label = label.encode().decode("unicode-escape")
              if type(TRUNCATE_FS_LABELS) == int:
                  if TRUNCATE_FS_LABELS >= 0:
                      label = label[:TRUNCATE_FS_LABELS]
                  elif TRUNCATE_FS_LABELS < 0:
                      label = label[TRUNCATE_FS_LABELS:]
          return label

      def getFSOptions(path):
          lines = check_output(['findmnt', '-no', 'FS-OPTIONS', path],
                               universal_newlines=True).strip()
          lines = lines.split(",")
          return lines

      def isReadOnly(path):
          return "ro" in getFSOptions(path)

      def isExtendedPartitionMarker(path):
          global attributeMaps
          MARKERS = ["0xf", "0x5"]
          return attributeMaps[path].get("ID_PART_ENTRY_TYPE") in MARKERS

      def getMountPoint(path):
          return check_output(['lsblk', '-ndo', 'MOUNTPOINT', path],
                              universal_newlines=True).rstrip("\n")

      def getSpaceAvailable(path):
          lines = check_output(['df', '-h', '--output=avail', path],
                               universal_newlines=True)
          lines = lines.split("\n")
          if len(lines) != 3:
              return ""
          else:
              return lines[1].strip()

      def getLockedCryptOutput(path):
          form = "<span color='{}'>[{}{}]</span>"
          kname = pangoEscape(getKernelName(path))
          output = form.format(LOCKED_COLOR, LOCKED_INDICATOR, kname)
          return output

      def getParentKernelName(path):
          lines = check_output(['lsblk', '-nso', 'KNAME', path],
                               universal_newlines=True)
          lines = lines.split("\n")
          if len(lines) > 2:
              return lines[1].rstrip("\n")
          else:
              return ""

      def getUnlockedCryptOutput(path):
          mountPoint = getMountPoint(path)
          if mountPoint:
              color = MOUNTED_COLOR
              if isReadOnly(path):
                  spaceAvail = READONLY_INDICATOR
              else:
                  spaceAvail = pangoEscape(getSpaceAvailable(path))
              mountPoint = "<i>{}</i>:".format(pangoEscape(mountPoint))
          else:
              color = UNLOCKED_NOT_MOUNTED_COLOR
              spaceAvail = ""
          kernelName = pangoEscape(getKernelName(path))
          parentKernelName = pangoEscape(getParentKernelName(path))

          block = "<span color='{}'>[{}{}:{}]</span>"
          block = block.format(color, UNLOCKED_INDICATOR,
                               parentKernelName, kernelName)

          label = pangoEscape(getFSLabel(path))
          if label:
              label = '"{}"'.format(label)

          items = [block, label, mountPoint, spaceAvail]
          return " ".join(filter(None, items))

      def getSwapOutput(path):
          return ""

      def getUnencryptedPartitionOutput(path):
          mountPoint = getMountPoint(path)
          if mountPoint:
              color = MOUNTED_COLOR
              if isReadOnly(path):
                  spaceAvail = READONLY_INDICATOR
              else:
                  spaceAvail = pangoEscape(getSpaceAvailable(path))
              mountPoint = "<i>{}</i>:".format(pangoEscape(mountPoint))
          else:
              color = PLUGGED_COLOR
              spaceAvail = ""
          kernelName = pangoEscape(getKernelName(path))

          block = "<span color='{}'>[{}]</span>"
          block = block.format(color, kernelName)

          label = pangoEscape(getFSLabel(path))
          if label:
              label = '"{}"'.format(label)

          items = [block, label, mountPoint, spaceAvail]
          return " ".join(filter(None, items))

      def getDiskWithNoPartitionsOutput(path):
          form = "<span color='{}'>[{}] {}</span>"
          kernelName = pangoEscape(getKernelName(path))
          return form.format(PARTITIONLESS_COLOR, kernelName, PARTITIONLESS_TEXT)

      def getOutput(path):
          if isSwapPartition(path):
              return getSwapOutput(path)
          t = getDeviceType(path)
          if t == "part":
              if isExtendedPartitionMarker(path):
                  return ""
              elif isLUKSPartition(path):
                  return getLockedCryptOutput(path)
              else:
                  return getUnencryptedPartitionOutput(path)
          elif t == "disk":
              return getDiskWithNoPartitionsOutput(path)
          elif t == "crypt":
              return getUnlockedCryptOutput(path)
          elif t == "rom":
              return ""

      def makeAttributeMap(path):
          attributeMap = {}
          lines = check_output(
              ['udevadm', 'info', '--query=property', '--name={}'.format(path)],
              universal_newlines=True)
          lines = lines.split("\n")
          for line in lines:
              if line:
                  key, val = line.split("=", maxsplit=1)
                  attributeMap[key] = val
          return attributeMap

      def getAttributeMaps(paths):
          return {path: makeAttributeMap(path) for path in paths}

      def parseArguments():
          dsc = " ".join(["i3blocks blocklet script",
                          "to output connected usb storage device info"])
          parser = argparse.ArgumentParser(prog="usb.py", description=dsc)

          def unArg(flag, text, default, *args, **kwargs):
              parser.add_argument(flag, nargs=1,
                                  help="{}. Default: {}"
                                  .format(text, default), *args, **kwargs)

          def unArgs(flagTempl, textTempl, vals):
              for flag, text, default in vals:
                  unArg(flagTempl.format(flag), textTempl.format(text), default)

          unArgs("--{}-color", "Set the color of {}",
                 [("info-text", "info text", INFO_TEXT_COLOR),
                  ("mounted", "mounted devices", MOUNTED_COLOR),
                  ("plugged", "plugged devices", PLUGGED_COLOR),
                  ("locked", "locked crypt devices", LOCKED_COLOR),
                  ("unlocked-not-mounted", "unlocked not mounted crypt devices",
                   UNLOCKED_NOT_MOUNTED_COLOR),
                  ("partitionless", "devices with no partitions",
                   PARTITIONLESS_COLOR)
                  ])

          unArg("--partitionless-text",
                "Set the text to display for a device with no partitions",
                PARTITIONLESS_TEXT)
          unArg("--separator", "Set the separator between devices", SEPARATOR)

          unArgs("--{}-indicator", "Set the indicator to use for {}",
                 [("locked", "a locked crypt device", LOCKED_INDICATOR),
                  ("unlocked", "an unlocked crypt device", UNLOCKED_INDICATOR),
                  ("readonly", "a readonly device", READONLY_INDICATOR)
                  ])

          unArg("--truncate-fs-labels",
                "(integer) Trucate device labels to a certain number of characters",
                TRUNCATE_FS_LABELS, type=int)
          ignoreText = " ".join([
              "Ignore a device by path.",
              "If path doesn't begin with / then it is assumed to be in /dev/"])
          parser.add_argument("-i", "--ignore", action="append", help=ignoreText)
          args = parser.parse_args()
          setParsedArgs(args)

      def setParsedArgs(args):
          if args.info_text_color is not None:
              global INFO_TEXT_COLOR
              INFO_TEXT_COLOR = args.info_text_color[0]
          if args.mounted_color is not None:
              global MOUNTED_COLOR
              MOUNTED_COLOR = args.mounted_color[0]
          if args.plugged_color is not None:
              global PLUGGED_COLOR
              PLUGGED_COLOR = args.plugged_color[0]
          if args.locked_color is not None:
              global LOCKED_COLOR
              LOCKED_COLOR = args.locked_color[0]
          if args.unlocked_not_mounted_color is not None:
              global UNLOCKED_NOT_MOUNTED_COLOR
              UNLOCKED_NOT_MOUNTED_COLOR = args.unlocked_not_mounted_color[0]
          if args.partitionless_color is not None:
              global PARTITIONLESS_COLOR
              PARTITIONLESS_COLOR = args.partitionless_color[0]
          if args.partitionless_text is not None:
              global PARTITIONLESS_TEXT
              PARTITIONLESS_TEXT = args.partitionless_text[0]
          if args.separator is not None:
              global SEPARATOR
              SEPARATOR = args.separator[0]
          if args.locked_indicator is not None:
              global LOCKED_INDICATOR
              LOCKED_INDICATOR = args.locked_indicator[0]
          if args.unlocked_indicator is not None:
              global UNLOCKED_INDICATOR
              UNLOCKED_INDICATOR = args.unlocked_indicator[0]
          if args.readonly_indicator is not None:
              global READONLY_INDICATOR
              READONLY_INDICATOR = args.readonly_indicator[0]
          if args.truncate_fs_labels is not None:
              global TRUNCATE_FS_LABELS
              TRUNCATE_FS_LABELS = args.truncate_fs_labels[0]
          if args.ignore is not None:
              args.ignore = list(map(lambda p:
                                     p if p.startswith("/") else "/dev/{}".format(p),
                                     args.ignore))
              global fastIgnore
              oldFastIgnore = fastIgnore

              def newFastIgnore(path):
                  return oldFastIgnore(path) or path in args.ignore
              fastIgnore = newFastIgnore

      parseArguments()
      leaves = getLeafDevicePaths()
      leaves = [path for path in leaves if not fastIgnore(path)]
      attributeMaps = getAttributeMaps(leaves)
      leaves = (path for path in leaves if not ignore(path, attributeMaps[path]))
      outputs = filter(None, map(getOutput, leaves))
      output = SEPARATOR.join(outputs)
      if output:
          output = "<span color='{}'>{}</span>".format(INFO_TEXT_COLOR, output)
      print(output)
      print(output)
    '';
    ".local/libexec/i3blocks/volume".executable = true;
    ".local/libexec/i3blocks/volume".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>
      # Copyright (C) 2014 Alexander Keller <github@nycroth.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #------------------------------------------------------------------------

      # The second parameter overrides the mixer selection
      # For PulseAudio users, eventually use "pulse"
      # For Jack/Jack2 users, use "jackplug"
      # For ALSA users, you may use "default" for your primary card
      # or you may use hw:# where # is the number of the card desired
      if [[ -z "$MIXER" ]] ; then
          MIXER="default"
          if command -v pulseaudio >/dev/null 2>&1 && pulseaudio --check ; then
              # pulseaudio is running, but not all installations use "pulse"
              if amixer -D pulse info >/dev/null 2>&1 ; then
                  MIXER="pulse"
              fi
          fi
          [ -n "$(lsmod | grep jack)" ] && MIXER="jackplug"
          MIXER="''${2:-$MIXER}"
      fi

      # The instance option sets the control to report and configure
      # This defaults to the first control of your selected mixer
      # For a list of the available, use `amixer -D $Your_Mixer scontrols`
      if [[ -z "$SCONTROL" ]] ; then
          SCONTROL="''${BLOCK_INSTANCE:-$(amixer -D $MIXER scontrols |
                            sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" |
                            head -n1
                          )}"
      fi

      # The first parameter sets the step to change the volume by (and units to display)
      # This may be in in % or dB (eg. 5% or 3dB)
      if [[ -z "$STEP" ]] ; then
          STEP="''${1:-5%}"
      fi

      # AMIXER(1):
      # "Use the mapped volume for evaluating the percentage representation like alsamixer, to be
      # more natural for human ear."
      NATURAL_MAPPING=''${NATURAL_MAPPING:-0}
      if [[ "$NATURAL_MAPPING" != "0" ]] ; then
          AMIXER_PARAMS="-M"
      fi

      #------------------------------------------------------------------------

      capability() { # Return "Capture" if the device is a capture device
        amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL |
          sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
      }

      volume() {
        amixer $AMIXER_PARAMS -D $MIXER get $SCONTROL $(capability)
      }

      format() {
        
        perl_filter='if (/.*\[(\d+%)\] (\[(-?\d+.\d+dB)\] )?\[(on|off)\]/)'
        perl_filter+='{CORE::say $4 eq "off" ? "MUTE" : "'
        # If dB was selected, print that instead
        perl_filter+=$([[ $STEP = *dB ]] && echo '$3' || echo '$1')
        perl_filter+='"; exit}'
        output=$(perl -ne "$perl_filter")
        echo "$LABEL$output"
      }

      #------------------------------------------------------------------------

      case $BLOCK_BUTTON in
        3) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) toggle ;;  # right click, mute/unmute
        4) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ''${STEP}+ unmute ;; # scroll up, increase
        5) amixer $AMIXER_PARAMS -q -D $MIXER sset $SCONTROL $(capability) ''${STEP}- unmute ;; # scroll down, decrease
      esac

      volume | format
    '';
    ".local/libexec/i3blocks/volume-pipewire".executable = true;
    ".local/libexec/i3blocks/volume-pipewire".text = ''
      #!/usr/bin/env bash
      # Displays the default device, volume, and mute status for i3blocks

      set -a

      AUDIO_HIGH_SYMBOL=''${AUDIO_HIGH_SYMBOL:-'  '}

      AUDIO_MED_THRESH=''${AUDIO_MED_THRESH:-50}
      AUDIO_MED_SYMBOL=''${AUDIO_MED_SYMBOL:-'  '}

      AUDIO_LOW_THRESH=''${AUDIO_LOW_THRESH:-0}
      AUDIO_LOW_SYMBOL=''${AUDIO_LOW_SYMBOL:-'  '}

      AUDIO_MUTED_SYMBOL=''${AUDIO_MUTED_SYMBOL:-'  '}

      AUDIO_DELTA=''${AUDIO_DELTA:-5}

      DEFAULT_COLOR=''${DEFAULT_COLOR:-"#ffffff"}
      MUTED_COLOR=''${MUTED_COLOR:-"#a0a0a0"}

      LONG_FORMAT=''${LONG_FORMAT:-''\'''${SYMB} ''${VOL}% [''${INDEX}:''${NAME}]'}
      SHORT_FORMAT=''${SHORT_FORMAT:-''\'''${SYMB} ''${VOL}% [''${INDEX}]'}
      USE_ALSA_NAME=''${USE_ALSA_NAME:-0}
      USE_DESCRIPTION=''${USE_DESCRIPTION:-0}

      SUBSCRIBE=''${SUBSCRIBE:-0}

      MIXER=''${MIXER:-""}
      SCONTROL=''${SCONTROL:-""}

      while getopts F:Sf:adH:M:L:X:T:t:C:c:i:m:s:h opt; do
          case "$opt" in
              S) SUBSCRIBE=1 ;;
              F) LONG_FORMAT="$OPTARG" ;;
              f) SHORT_FORMAT="$OPTARG" ;;
              a) USE_ALSA_NAME=1 ;;
              d) USE_DESCRIPTION=1 ;;
              H) AUDIO_HIGH_SYMBOL="$OPTARG" ;;
              M) AUDIO_MED_SYMBOL="$OPTARG" ;;
              L) AUDIO_LOW_SYMBOL="$OPTARG" ;;
              X) AUDIO_MUTED_SYMBOL="$OPTARG" ;;
              T) AUDIO_MED_THRESH="$OPTARG" ;;
              t) AUDIO_LOW_THRESH="$OPTARG" ;;
              C) DEFAULT_COLOR="$OPTARG" ;;
              c) MUTED_COLOR="$OPTARG" ;;
              i) AUDIO_INTERVAL="$OPTARG" ;;
              m) MIXER="$OPTARG" ;;
              s) SCONTROL="$OPTARG" ;;
              h) printf \
      "Usage: volume-pulseaudio [-S] [-F format] [-f format] [-p] [-a|-d] [-H symb] [-M symb]
              [-L symb] [-X symb] [-T thresh] [-t thresh] [-C color] [-c color] [-i inter] 
              [-m mixer] [-s scontrol] [-h]
      Options:
      -F, -f\tOutput format (-F long format, -f short format) to use, with exposed variables:
      \''${SYMB}, \''${VOL}, \''${INDEX}, \''${NAME}
      -S\tSubscribe to volume events (requires persistent block, always uses long format)
      -a\tUse ALSA name if possible
      -d\tUse device description instead of name if possible
      -H\tSymbol to use when audio level is high. Default: '$AUDIO_HIGH_SYMBOL'
      -M\tSymbol to use when audio level is medium. Default: '$AUDIO_MED_SYMBOL'
      -L\tSymbol to use when audio level is low. Default: '$AUDIO_LOW_SYMBOL'
      -X\tSymbol to use when audio is muted. Default: '$AUDIO_MUTED_SYMBOL'
      -T\tThreshold for medium audio level. Default: $AUDIO_MED_THRESH
      -t\tThreshold for low audio level. Default: $AUDIO_LOW_THRESH
      -C\tColor for non-muted audio. Default: $DEFAULT_COLOR
      -c\tColor for muted audio. Default: $MUTED_COLOR
      -i\tInterval size of volume increase/decrease. Default: $AUDIO_DELTA
      -m\tUse the given mixer.
      -s\tUse the given scontrol.
      -h\tShow this help text
      " && exit 0;;
          esac
      done

      if [[ -z "$MIXER" ]] ; then
          MIXER="default"
          if amixer -D pulse info >/dev/null 2>&1 ; then
              MIXER="pulse"
          fi
      fi

      if [[ -z "$SCONTROL" ]] ; then
          SCONTROL=$(amixer -D "$MIXER" scontrols | sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" | head -n1)
      fi

      CAPABILITY=$(amixer -D $MIXER get $SCONTROL | sed -n "s/  Capabilities:.*cvolume.*/Capture/p")

      function move_sinks_to_new_default {
          DEFAULT_SINK=$1
          pactl list sink-inputs | grep 'Sink Input #' | grep -o '[0-9]\+' | while read SINK
          do
              pactl move-sink-input $SINK $DEFAULT_SINK
          done
      }

      function set_default_playback_device_next {
          inc=''${1:-1}
          num_devices=$(pactl list sinks | grep -c Name:)
          sink_arr=($(pactl list sinks | grep Name: | sed -r 's/\s+Name: (.+)/\1/'))
          default_sink=$(pactl get-default-sink)
          default_sink_index=$(for i in "''${!sink_arr[@]}"; do if [[ "$default_sink" = "''${sink_arr[$i]}" ]]; then echo "$i"; fi done)
          default_sink_index=$(( ($default_sink_index + $num_devices + $inc) % $num_devices ))
          default_sink=''${sink_arr[$default_sink_index]}
          pactl set-default-sink $default_sink
          move_sinks_to_new_default $default_sink
      }

      case "$BLOCK_BUTTON" in
          1) set_default_playback_device_next ;;
          2) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY toggle ;;
          3) set_default_playback_device_next -1 ;;
          4) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY $AUDIO_DELTA%+ ;;
          5) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY $AUDIO_DELTA%- ;;
      esac

      function print_format {
          echo "$1" | envsubst ''\'''${SYMB}''${VOL}''${INDEX}''${NAME}'
      }

      function print_block {
          ACTIVE=$(pactl list sinks  | grep "State\: RUNNING" -B4 -A55 | grep "Name:\|Volume: \(front-left\|mono\)\|Mute:\|api.alsa.pcm.card = \|node.nick = ")
          for Name in NAME MUTED VOL INDEX NICK; do
              read $Name
          done < <(echo "$ACTIVE")
          INDEX=$(echo "$INDEX"  | grep -o '".*"' | sed 's/"//g')
          VOL=$(echo "$VOL" | grep -o "[0-9]*%" | head -1 )
          VOL="''${VOL%?}"
          NAME=$(echo "$NICK" | grep -o '".*"' | sed 's/"//g')

          if [[ $USE_ALSA_NAME == 1 ]] ; then
              ALSA_NAME=$(pactl list sinks |\
      awk '/^\s*\*/{f=1}/^\s*index:/{f=0}f' |\
      grep "alsa.name\|alsa.mixer_name" |\
      head -n1 |\
      sed 's/.*= "\(.*\)".*/\1/')
              NAME=''${ALSA_NAME:-$NAME}
          elif [[ $USE_DESCRIPTION == 1 ]] ; then
              DESCRIPTION=$(pactl list sinks  | grep "State\: RUNNING" -B4 -A55 | grep 'Description: ' | sed 's/^.*: //')
              NAME=''${DESCRIPTION:-$NAME}
          fi

          if [[ $MUTED =~ "no" ]] ; then
              SYMB=$AUDIO_HIGH_SYMBOL
              [[ $VOL -le $AUDIO_MED_THRESH ]] && SYMB=$AUDIO_MED_SYMBOL
              [[ $VOL -le $AUDIO_LOW_THRESH ]] && SYMB=$AUDIO_LOW_SYMBOL
              COLOR=$DEFAULT_COLOR
          else
              SYMB=$AUDIO_MUTED_SYMBOL
              COLOR=$MUTED_COLOR
          fi

          if [[ $ACTIVE = "" ]] ; then
              echo "Sound inactive"
              COLOR='#222225'
          fi

          if [[ $SUBSCRIBE == 1 ]] ; then
              print_format "$LONG_FORMAT"
          else
              print_format "$LONG_FORMAT"
              print_format "$SHORT_FORMAT"
              echo "$COLOR"
          fi
      }

      print_block
      if [[ $SUBSCRIBE == 1 ]] ; then
          while read -r EVENT; do
              print_block
          done < <(pactl subscribe | stdbuf -oL grep change)
      fi
    '';
    ".local/libexec/i3blocks/volume-pulseaudio".executable = true;
    ".local/libexec/i3blocks/volume-pulseaudio".text = ''
      #!/usr/bin/env bash
      # Displays the default device, volume, and mute status for i3blocks

      set -a

      AUDIO_HIGH_SYMBOL=''${AUDIO_HIGH_SYMBOL:-'  '}

      AUDIO_MED_THRESH=''${AUDIO_MED_THRESH:-50}
      AUDIO_MED_SYMBOL=''${AUDIO_MED_SYMBOL:-'  '}

      AUDIO_LOW_THRESH=''${AUDIO_LOW_THRESH:-0}
      AUDIO_LOW_SYMBOL=''${AUDIO_LOW_SYMBOL:-'  '}

      AUDIO_MUTED_SYMBOL=''${AUDIO_MUTED_SYMBOL:-'  '}

      AUDIO_DELTA=''${AUDIO_DELTA:-5}

      DEFAULT_COLOR=''${DEFAULT_COLOR:-"#ffffff"}
      MUTED_COLOR=''${MUTED_COLOR:-"#a0a0a0"}

      LONG_FORMAT=''${LONG_FORMAT:-''\'''${SYMB} ''${VOL}% [''${INDEX}:''${NAME}]'}
      SHORT_FORMAT=''${SHORT_FORMAT:-''\'''${SYMB} ''${VOL}% [''${INDEX}]'}
      USE_ALSA_NAME=''${USE_ALSA_NAME:-0}
      USE_DESCRIPTION=''${USE_DESCRIPTION:-0}

      SUBSCRIBE=''${SUBSCRIBE:-0}

      MIXER=''${MIXER:-""}
      SCONTROL=''${SCONTROL:-""}

      while getopts F:Sf:adH:M:L:X:T:t:C:c:i:m:s:h opt; do
          case "$opt" in
              S) SUBSCRIBE=1 ;;
              F) LONG_FORMAT="$OPTARG" ;;
              f) SHORT_FORMAT="$OPTARG" ;;
              a) USE_ALSA_NAME=1 ;;
              d) USE_DESCRIPTION=1 ;;
              H) AUDIO_HIGH_SYMBOL="$OPTARG" ;;
              M) AUDIO_MED_SYMBOL="$OPTARG" ;;
              L) AUDIO_LOW_SYMBOL="$OPTARG" ;;
              X) AUDIO_MUTED_SYMBOL="$OPTARG" ;;
              T) AUDIO_MED_THRESH="$OPTARG" ;;
              t) AUDIO_LOW_THRESH="$OPTARG" ;;
              C) DEFAULT_COLOR="$OPTARG" ;;
              c) MUTED_COLOR="$OPTARG" ;;
              i) AUDIO_INTERVAL="$OPTARG" ;;
              m) MIXER="$OPTARG" ;;
              s) SCONTROL="$OPTARG" ;;
              h) printf \
      "Usage: volume-pulseaudio [-S] [-F format] [-f format] [-p] [-a|-d] [-H symb] [-M symb]
              [-L symb] [-X symb] [-T thresh] [-t thresh] [-C color] [-c color] [-i inter]
              [-m mixer] [-s scontrol] [-j] [-h]
      Options:
      -F, -f\tOutput format (-F long format, -f short format) to use, with exposed variables:
      \''${SYMB}, \''${VOL}, \''${INDEX}, \''${NAME}
      -S\tSubscribe to volume events (requires persistent block, always uses long format)
      -a\tUse ALSA name if possible
      -d\tUse device description instead of name if possible
      -H\tSymbol to use when audio level is high. Default: '$AUDIO_HIGH_SYMBOL'
      -M\tSymbol to use when audio level is medium. Default: '$AUDIO_MED_SYMBOL'
      -L\tSymbol to use when audio level is low. Default: '$AUDIO_LOW_SYMBOL'
      -X\tSymbol to use when audio is muted. Default: '$AUDIO_MUTED_SYMBOL'
      -T\tThreshold for medium audio level. Default: $AUDIO_MED_THRESH
      -t\tThreshold for low audio level. Default: $AUDIO_LOW_THRESH
      -C\tColor for non-muted audio. Default: $DEFAULT_COLOR
      -c\tColor for muted audio. Default: $MUTED_COLOR
      -i\tInterval size of volume increase/decrease. Default: $AUDIO_DELTA
      -m\tUse the given mixer.
      -s\tUse the given scontrol.
      -h\tShow this help text
      " && exit 0;;
          esac
      done

      if [[ -z "$MIXER" ]] ; then
          MIXER="default"
          if amixer -D pulse info >/dev/null 2>&1 ; then
              MIXER="pulse"
          fi
      fi

      if [[ -z "$SCONTROL" ]] ; then
          SCONTROL=$(amixer -D "$MIXER" scontrols | sed -n "s/Simple mixer control '\([^']*\)',0/\1/p" | head -n1)
      fi

      CAPABILITY=$(amixer -D $MIXER get $SCONTROL | sed -n "s/  Capabilities:.*cvolume.*/Capture/p")


      function move_sinks_to_new_default {
          DEFAULT_SINK=$1
          pacmd list-sink-inputs | grep index: | grep -o '[0-9]\+' | while read SINK
          do
              pacmd move-sink-input $SINK $DEFAULT_SINK
          done
      }

      function set_default_playback_device_next {
          inc=''${1:-1}
          num_devices=$(pacmd list-sinks | grep -c index:)
          sink_arr=($(pacmd list-sinks | grep index: | grep -o '[0-9]\+'))
          default_sink_index=$(( $(pacmd list-sinks | grep index: | grep -no '*' | grep -o '^[0-9]\+') - 1 ))
          default_sink_index=$(( ($default_sink_index + $num_devices + $inc) % $num_devices ))
          default_sink=''${sink_arr[$default_sink_index]}
          pacmd set-default-sink $default_sink
          move_sinks_to_new_default $default_sink
      }

      case "$BLOCK_BUTTON" in
          1) set_default_playback_device_next ;;
          2) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY toggle ;;
          3) set_default_playback_device_next -1 ;;
          4) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY $AUDIO_DELTA%+ ;;
          5) amixer -q -D $MIXER sset $SCONTROL $CAPABILITY $AUDIO_DELTA%- ;;
      esac


      function print_format {
          if [[ $markup == "pango" ]] ; then
              output="<span color=\"$2\">$1</span>"
          else
              output=$1
          fi

          echo "$output" | envsubst ''\'''${SYMB}''${VOL}''${INDEX}''${NAME}'
      }

      function print_block {
          ACTIVE=$(pacmd list-sinks | grep "state\: RUNNING" -B4 -A7 | grep "index:\|name:\|volume: \(front\|mono\)\|muted:")
          [[ -z "$ACTIVE" ]] && ACTIVE=$(pacmd list-sinks | grep "index:\|name:\|volume: \(front\|mono\)\|muted:" | grep -A3 '*')
          for name in INDEX NAME VOL MUTED; do
              read $name
          done < <(echo "$ACTIVE")
          INDEX=$(echo "$INDEX" | grep -o '[0-9]\+')
          VOL=$(echo "$VOL" | grep -o "[0-9]*%" | head -1 )
          VOL="''${VOL%?}"

          NAME=$(echo "$NAME" | sed \
      's/.*<.*\.\(.*\)>.*/\1/; t;'\
      's/.*<\(.*\)>.*/\1/; t;'\
      's/.*/unknown/')

          if [[ $USE_ALSA_NAME == 1 ]] ; then
              ALSA_NAME=$(pacmd list-sinks |\
      awk '/^\s*\*/{f=1}/^\s*index:/{f=0}f' |\
      grep "alsa.name\|alsa.mixer_name" |\
      head -n1 |\
      sed 's/.*= "\(.*\)".*/\1/')
              NAME=''${ALSA_NAME:-$NAME}
          elif [[ $USE_DESCRIPTION == 1 ]] ; then
              DESCRIPTION=$(pacmd list-sinks |\
      awk '/^\s*\*/{f=1}/^\s*index:/{f=0}f' |\
      grep "device.description" |\
      head -n1 |\
      sed 's/.*= "\(.*\)".*/\1/')
              NAME=''${DESCRIPTION:-$NAME}
          fi

          if [[ $MUTED =~ "no" ]] ; then
              SYMB=$AUDIO_HIGH_SYMBOL
              [[ $VOL -le $AUDIO_MED_THRESH ]] && SYMB=$AUDIO_MED_SYMBOL
              [[ $VOL -le $AUDIO_LOW_THRESH ]] && SYMB=$AUDIO_LOW_SYMBOL
              COLOR=$DEFAULT_COLOR
          else
              SYMB=$AUDIO_MUTED_SYMBOL
              COLOR=$MUTED_COLOR
          fi

          print_format "$LONG_FORMAT" $COLOR
          if [[ $SUBSCRIBE != 1 ]] ; then
              print_format "$SHORT_FORMAT" $COLOR
              echo $COLOR
          fi
      }

      print_block
      if [[ $SUBSCRIBE == 1 ]] ; then
          while read -r EVENT; do
              print_block
          done < <(pactl subscribe | stdbuf -oL grep change)
      fi
    '';
    ".local/libexec/i3blocks/weather_NOAA".executable = true;
    ".local/libexec/i3blocks/weather_NOAA".text = ''
      #!/usr/bin/env perl
      #
      #   Copyright 2021 Robert Unverzagt <robert.unverzagt@protonmail.com>
      #
      #   This program is free software: you can redistribute it and/or modify
      #   it under the terms of the GNU General Public License as published by
      #   the Free Software Foundation, either version 3 of the License, or
      #   (at your option) any later version.
      #
      #   This program is distributed in the hope that it will be useful,
      #   but WITHOUT ANY WARRANTY; without even the implied warranty of
      #   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      #   GNU General Public License for more details.
      #
      #   You should have received a copy of the GNU General Public License
      #   along with this program.  If not, see <https://www.gnu.org/licenses/>.

      use strict;
      use warnings;
      use JSON;
      use Data::Dumper;
      use Getopt::Long;

      # Default option values (default location is Portland, OR)
      my $lat = $ENV{LAT} || "45.52";
      my $lon = $ENV{LON} || "-122.70";

      sub help {
          print "Usage: weather_NOAA [-lat <latitude>] [-lon <longitude>]\n";
          print "-lat <latitude>: the latitude coordinate of your location\n";
          print "-lon <longitude>: the longitude coordinate of your location\n\n";
          print "NOTE: Only works in areas where NOAA publishes forecasts (namely the USA)\n";
          exit 0;
      }

      GetOptions( "help|h"    => \&help,
                  "lat=s"     => \$lat,
                  "lon=s"     => \$lon,
      );

      # Use CURL to retrieve station ID and gridpoint
      my $json;
      {
          open( my $fh, 'curl -s https:\/\/api.weather.gov\/points\/'.$lat.','.$lon.' |') or die;
          local $/;
          $json = <$fh>;
          close $fh;
      }


      # Decode the json data into a perl native datatype, and extract the data we need
      my $decoded = decode_json($json);

      # Detect error
      if ($decoded->{"status"})
      {
          print "ERROR: ".$decoded->{'title'}."\n";
          print $decoded->{'detail'}."\n";
          die;
      }

      my $stationID   = $decoded->{'properties'}->{'gridId'};
      my $Xcoord      = $decoded->{'properties'}->{'gridX'};
      my $Ycoord      = $decoded->{'properties'}->{'gridY'};

      # Use CURL to retrieve the forecast from NOAA
      {
          open( my $fh, 'curl -s https:\/\/api.weather.gov\/gridpoints\/'.$stationID.'\/'.$Xcoord.','.$Ycoord.'\/forecast\/hourly |') or die;
          local $/;
          $json = <$fh>;
          close $fh;
      }

      $decoded = decode_json($json);

      if ($decoded->{"status"})
      {
          print "ERROR: ".$decoded->{'title'}."\n";
          print $decoded->{'detail'}."\n";
          die;
      }

      # Extract just the forecast for the next hour
      my $forecast = $decoded->{'properties'}->{'periods'}->[0];

      # Use this forecast data to construct the output string
      print $forecast->{'temperature'}."°".$forecast->{'temperatureUnit'}." ".$forecast->{'shortForecast'}."\n";
    '';
    ".local/libexec/i3blocks/wifi".executable = true;
    ".local/libexec/i3blocks/wifi".text = ''
      #!/usr/bin/env bash
      # Copyright (C) 2014 Alexander Keller <github@nycroth.com>

      # This program is free software: you can redistribute it and/or modify
      # it under the terms of the GNU General Public License as published by
      # the Free Software Foundation, either version 3 of the License, or
      # (at your option) any later version.

      # This program is distributed in the hope that it will be useful,
      # but WITHOUT ANY WARRANTY; without even the implied warranty of
      # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      # GNU General Public License for more details.

      # You should have received a copy of the GNU General Public License
      # along with this program.  If not, see <http://www.gnu.org/licenses/>.

      #------------------------------------------------------------------------
      if [[ -z "$INTERFACE" ]] ; then
          INTERFACE="''${BLOCK_INSTANCE:-wlan0}"
      fi
      #------------------------------------------------------------------------

      COLOR_GE80=''${COLOR_GE80:-#00FF00}
      COLOR_GE60=''${COLOR_GE60:-#FFF600}
      COLOR_GE40=''${COLOR_GE40:-#FFAE00}
      COLOR_LOWR=''${COLOR_LOWR:-#FF0000}
      COLOR_DOWN=''${COLOR_DOWN:-#FF0000}

      # As per #36 -- It is transparent: e.g. if the machine has no battery or wireless
      # connection (think desktop), the corresponding block should not be displayed.
      [[ ! -d /sys/class/net/''${INTERFACE}/wireless ]] && exit

      # If the wifi interface exists but no connection is active, "down" shall be displayed.
      if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
          echo "down"
          echo "down"
          echo $COLOR_DOWN
          exit
      fi

      #------------------------------------------------------------------------

      QUALITY=$(iw dev ''${INTERFACE} link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')

      #------------------------------------------------------------------------

      echo $QUALITY% # full text
      echo $QUALITY% # short text

      # color
      if [[ $QUALITY -ge 80 ]]; then
          echo $COLOR_GE80
      elif [[ $QUALITY -ge 60 ]]; then
          echo $COLOR_GE60
      elif [[ $QUALITY -ge 40 ]]; then
          echo $COLOR_GE40
      else
          echo $COLOR_LOWR
      fi
    '';
    ".local/libexec/i3blocks/wifi-status".executable = true;
    ".local/libexec/i3blocks/wifi-status".text = ''
      # Change this according to your devices

      # Network
      network_adapter=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
      QUALITY=$(iw dev ''${network_adapter} link | grep 'dBm$' | grep -Eoe '-[0-9]{2}' | awk '{print  ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')
      SSID=$(iw dev ''${network_adapter} link | grep 'SSID\:' | cut -d ' ' -f2)
      # interface_easyname grabs the "old" interface name before systemd renamed it
      #interface_easyname=$(journalctl --dmesg -o short-monotonic --no-hostname --no-pager | grep $network | grep renamed | awk 'NF>1{print $NF}')
      #ping=$(ping -c 1 www.google.com | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)
      if ! [ $network_adapter ]; then
          network_active="<span font='icon'>⛔</span>" # do not enter (no network)
      #    network_active=$'\u26D4' # do not enter (no network)
      else
          network_active="<span font='icon'></span>" # wifi symbol
      #    network_active=$'\uF1EB' # wifi symbol
      #    network_active="<span font='icon'>⇆</span>" # double opposing arrows
      #    network_active=$'\u21C6' # double opposing arrows
      fi

      echo "$network_active $SSID (''${QUALITY}%)"
      #echo "$network_active $network_adapter (''${QUALITY}%)"
      echo "$network_active (''${QUALITY}%)"

      exit 0
    '';
    ".local/libexec/i3blocks/wlan-dbm".executable = true;
    ".local/libexec/i3blocks/wlan-dbm".text = ''
      #!/usr/bin/env bash
      #
      # i3blocks blocklet script to display wifi signal in dBm

      if [[ -z "$IFACE" ]] ; then
          IFACE="''${BLOCK_INSTANCE:-wlan0}"
      fi

      USE_PERCENT=''${USE_PERCENT:-0}

      IW=$(which iw || echo "/sbin/iw")

      if [[ ! -x $IW ]]; then
          echo "No iw binary was found on the system." 1>2
          exit 1
      fi

      while getopts p opt; do
          case "$opt" in
              p) USE_PERCENT=1 ;;
          esac
      done

      dbm=$($IW dev "$IFACE" link | grep 'dBm$' | grep -Eoe '-[0-9]{2}')

      [[ -n "$dbm" ]] || exit 1

      if [[ $USE_PERCENT -eq 0 ]]; then
          echo "$dbm" dBm
          echo "$dbm"
      else
          if [[ "$dbm" -le -100 ]]; then
              quality=0
          elif [[ $dbm -ge -50 ]]; then
              quality=100
          else
              quality=$((2 * (dbm + 100)))
          fi
          echo "$quality%"
          echo "$quality%"
      fi

      if [[ $dbm -ge -55 ]]; then
          echo "#00FF00"
      elif [[ $dbm -ge -60 ]]; then
          echo "#CCFF00"
      elif [[ $dbm -ge -70 ]]; then
          echo "#FFFF00"
      elif [[ $dbm -ge -80 ]]; then
          echo "#FFAA00"
      else
          echo "#FF0000"
      fi
    '';
    ".local/libexec/i3blocks/xkb_layout".executable = true;
    ".local/libexec/i3blocks/xkb_layout".text = ''
      #!/usr/bin/env sh
      # This script is supposed to be used as an i3blocks persistent blocklet.
      # It outputs current keyboard layout, then waits for it to change in an infinite loop.
      # Requires `xkb-switch` utility. Should work in any *sh.
      # Written by skidnik <skidnik@gmail.com>
      #
      # Defaults:
      font=''${font:-monospace}
      font_weight=''${font_weight:-bold}
      while :
      do
      # Output current layout:
          xkb-switch -p | awk -v font="$font" -v font_weight="$font_weight" '{print "<span font_family=\""font"\"  font_weight=\""font_weight"\">"toupper($0)"</span>"}' || sleep 1
      # Wait for layout change:
          xkb-switch -w
      done
    '';
    ".local/libexec/i3blocks/ytdl-mpv".executable = true;
    ".local/libexec/i3blocks/ytdl-mpv".text = ''
      #!/usr/bin/env perl
      #
      # Copyright (C) 2018-2021 James Murphy, Falko Galperin
      # Licensed under the terms of the GNU GPL v2 only.
      #
      # i3blocks blocklet script to play youtube videos from your clipboard using mpv

      use strict;
      use warnings;
      use utf8;
      use Data::Validate::URI;

      my $signal = $ENV{signal} || 1;
      my $notify_i3bar = "pkill -RTMIN+$signal i3blocks";
      my $string = qx/xclip -out/;
      $string =~ s/[';\\]//g; # remove characters that can cause i3-msg to crash
      my $uriValidator = new Data::Validate::URI();
      my $BLOCK_BUTTON = $ENV{BLOCK_BUTTON} || 0;
      my $PLAYING_COLOR = $ENV{PLAYING_COLOR} || "red";
      my $NOT_PLAYING_COLOR = $ENV{PLAYING_COLOR} || "white";
      my $USER = $ENV{USER};
      my $i3cmd = "";
      my $i3cmdexitstatus = 0;

      if ($uriValidator->is_web_uri($string) or $BLOCK_BUTTON == 3) {
          if ($BLOCK_BUTTON == 1) {
              $i3cmd = "exec mpv --ytdl --tls-verify '$string' && $notify_i3bar";
          } elsif ($BLOCK_BUTTON == 2) {
              $i3cmd = "exec mpv --ytdl --tls-verify --ytdl-format=bestaudio '$string' && $notify_i3bar";
          } elsif ($BLOCK_BUTTON == 3) {
              $i3cmd = "exec killall -u $USER mpv && $notify_i3bar";
          }

          system("i3-msg", "-q", $i3cmd);
          # i3-msg may return before mpv has started
          sleep(.1);
      }

      my $color;

      if (system("pgrep -x mpv 2>&1 1>/dev/null") == 0) {
          $color = $PLAYING_COLOR;
      } else {
          $color = $NOT_PLAYING_COLOR;
      }

      binmode(STDOUT, ":utf8");
      print("<span color='$color'>\x{f16a}</span>\n");
      print("<span color='$color'>\x{f16a}</span>\n");
    '';
  };
}
