{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".local/bin/reboot-menu".executable = true;
    ".local/bin/reboot-menu".text = ''
      #!/usr/bin/env bash

      # Am I root?
      if [ $(id -u) = 0 ]; then
          sudo_cmd=''';
      else
          sudo_cmd='sudo ';
      fi
      shopt -s nullglob
      bootMenuItems=(`systemctl --boot-loader-entry=help`)
      shopt -u nullglob
      if (( ''${#bootMenuItems[@]} == 0 )); then
          echo "No boot loader menu entries found" >&2
          exit 1
      else
          i=0
          for menuItem in "''${bootMenuItems[@]}"; do
              bootMenuItems[i]=$(basename ''${menuItem})
              ((i=i+1))
          done
      fi
      select menuItem in ''${bootMenuItems[@]}; do
          echo "Rebooting to $menuItem"
          ''${sudo_cmd}systemctl reboot --boot-loader-entry=''${menuItem}
      done
    '';
    ".local/bin/rsync-backup-local".executable = true;
    ".local/bin/rsync-backup-local".text = ''
      #!/usr/bin/env bash

      # External SATA Drive UUID=82a75835-a541-4976-bc10-d643a69169b6

      filesystem_UUID="82a75835-a541-4976-bc10-d643a69169b6"
      mount_options='relatime,discard=async,compress=zstd,subvol=/@backup'
      target_dir="/mnt/backup/128Gext"
      remount_target=0
      unmount_target=0
      src_folders="/root /home"

      # External SATA drive may be mounted by fstab
      # Uncomment the following if you marked the external
      # SATA drive "noauto,user" in fstab and only mount it
      # on demand.

      # determine if filesystem is already mounted to prepare for 
      # later remount
      mounted_dir=$(findmnt -f UUID=''${filesystem_UUID} -n -o TARGET)
      if [ $? -eq 0 ]; then
          if [ ''${mounted_dir} != ''${target_dir} ]; then
              umount ''${mounted_dir}
              mount UUID=''${filesystem_UUID} -o ''${mount_options} ''${target_dir} || { echo "mount ''${target_dir} failed" ; exit 1; }
              remount_target=1
          else
              unmount_target=0
          fi
      else
          mount UUID=''${filesystem_UUID} -o ''${mount_options} ''${target_dir} || { echo "mount ''${target_dir} failed" ; exit 1; }
          unmount_target=1
      fi

      if [[ -d /usr/share/keyrings ]]; then
          src_folders="''${src_folders} /usr/share/keyrings"
      fi
      if [[ -d /var/db/repos/localrepo ]]; then
          src_folders="''${src_folders} /var/db/repos/localrepo"
      fi

      #
      # read in OS info
      #
      ID='''
      if [ -r /etc/os-release ]; then
          source /etc/os-release
      elif [ -r /usr/lib/os-release ]; then
          source /usr/lib/os-release
      fi
      if [[ -z ''${ID} ]] ; then
          ID='unknown'
      fi

      echo
      echo "syncing ''${src_folders} -> ''${target_dir}/$(hostname)-''${ID}"
      echo

      #rsync -avxHASLe ssh -X --filter='-x security.selinux' --delete --delete-excluded --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="- Mega Limited/" ''${src_folders} ''${target_dir}/$(hostname)-''${ID}
      rsync -avxHASLe ssh --delete --delete-excluded --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="- Mega Limited/" --exclude="- akonadi/" --exclude="- baloo/" ''${src_folders} ''${target_dir}/$(hostname)-''${ID}
      echo 1 > /proc/sys/vm/drop_caches
      # Uncomment the following if you marked the internal
      # SATA drive "noauto,user" in fstab and only mount it
      # on demand.
      #
      # remount previously mounted filesystem
      if [ $unmount_target -eq 1 ] || [ $remount_target -eq 1 ]; then
          umount ''${target_dir} || { echo "umount ''${target_dir} failed" ; exit 1; }
          if [ $remount_target -eq 1 ]; then
              mount UUID=''${filesystem_UUID} -o ''${mount_options} ''${mounted_dir} || { echo "mount ''${mounted_dir} failed" ; exit 1; }
          fi
      fi
    '';
    ".local/bin/rsync-backup-remote".executable = true;
    ".local/bin/rsync-backup-remote".text = ''
      #!/usr/bin/env bash

      shopt -s extglob
      set -e # exit immediately on command failure

      out() { printf "$1 $2\n" "''${@:3}"; }
      error() { out "==> ERROR:" "$@"; } >&2
      warning() { out "==> WARNING:" "$@"; } >&2
      msg() { out "==>" "$@"; }
      msg2() { out "  ->" "$@";}
      die() { error "$@"; exit 1; }

      _DEBUG="off"
      function DEBUG() {
          if [[ "$_DEBUG" == "on" ]]; then
             $@
          fi
      }

      usage() {
        cat <<EOF
      usage: ''${0##*/} [arguments...]

          -d                       Verbose output (debug)
          -h                       Print this help message and exit
          -t <target_host>         target with which to sync

      EOF
      }

      target_host='''
      target_dir="/mnt/backup/internal"
      src_folders="/root /home"

      # read cmdline options
      while getopts dht: flag
      do
          case $flag in
              d) 
                  _DEBUG="on" 
                  ;;
              h)
                  usage 
                  exit 0 
                  ;;
              t) 
                  target_host=''${OPTARG} 
                  ;;
              ?) 
                  die '%s: invalid option -- \''%s\''' "''${0##*/}" "''${OPTARG}" 
                  ;;
          esac
      done
      shift "$(( OPTIND - 1 ))"

      if [ -z ''${target_host} ]; then 
          target_host='leanangle'
      fi

      if [[ -d /usr/share/keyrings ]]; then
          src_folders="''${src_folders} /usr/share/keyrings"
      fi
      if [[ -d /var/db/repos/localrepo ]]; then
          src_folders="''${src_folders} /var/db/repos/localrepo"
      fi

      #
      # read in OS info
      #
      ID='''
      if [ -r /etc/os-release ]; then
          source /etc/os-release
      elif [ -r /usr/lib/os-release ]; then
          source /usr/lib/os-release
      fi
      if [[ -z ''${ID} ]] ; then
          ID='unknown'
      fi

      echo
      echo "syncing ''${src_folders} -> ''${target_dir}/$(hostname)-''${ID}"
      echo

      #rsync -avxHASLe ssh -X --filter='-x security.selinux' --delete --delete-excluded --exclude="- MEGA/" --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="music-library/" --exclude="- Mega Limited/" ''${src_folders} leanangle:''${target_dir}/$(hostname)-''${ID}
      rsync -avxHASLe ssh --delete --delete-excluded --exclude="- MEGA/" --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="music-library/" --exclude="- Mega Limited/" --exclude="- akonadi/" --exclude="- baloo/" ''${src_folders} ''${target_host}:''${target_dir}/$(hostname)-''${ID}
    '';
  };
}
