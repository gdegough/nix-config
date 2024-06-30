{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
let
  reboot-menu = pkgs.writeTextFile {
    name = "reboot-menu";
    destination = "/sbin/reboot-menu";
    executable = true;
    text = ''
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
  };
  rsync-backup-internal = pkgs.writeTextFile {
    name = "rsync-backup-internal";
    destination = "/bin/rsync-backup-internal";
    executable = true;
    text = ''
      #!/usr/bin/env bash

      filesystem_UUID="174c69f3-e1cd-4c29-98f1-a18dfd0c6d34"
      mount_options='defaults,relatime'
      target_dir="/mnt/backup/internal"
      remount_target=0
      unmount_target=0
      src_folders="/root /home"

      # Internal SATA drive may be mounted by fstab
      # Uncomment the following if you marked the internal
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
      rsync -avxHASLe ssh --delete --delete-excluded --exclude="- .nix*/" --exclude="- nix*/" --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="- Mega Limited/" --exclude="- akonadi/" --exclude="- baloo/" ''${src_folders} ''${target_dir}/$(hostname)-''${ID}
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
  };
  rsync-backup-local = pkgs.writeTextFile {
    name = "rsync-backup-local";
    destination = "/bin/rsync-backup-local";
    executable = true;
    text = ''
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
      rsync -avxHASLe ssh --delete --delete-excluded --exclude="- .nix*/" --exclude="- nix*/" --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="- Mega Limited/" --exclude="- akonadi/" --exclude="- baloo/" ''${src_folders} ''${target_dir}/$(hostname)-''${ID}
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
  };
  rsync-backup-remote = pkgs.writeTextFile {
    name = "rsync-backup-remote";
    destination = "/bin/rsync-backup-remote";
    executable = true;
    text = ''
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
                  die '%s: invalid option -- %s' "''${0##*/}" "''${OPTARG}" 
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
      rsync -avxHASLe ssh --delete --delete-excluded --exclude="- .nix*/" --exclude="- nix*/" --exclude="- MEGA/" --exclude="- .rustup/" --exclude="- .cargo/" --exclude="- .ccache/" --exclude="- .cache/" --exclude="- Library/Caches/" --exclude="- .local/share/flatpak/" --exclude="- public/" --exclude="- *.qcow2" --exclude="music-library/" --exclude="- Mega Limited/" --exclude="- akonadi/" --exclude="- baloo/" ''${src_folders} ''${target_host}:''${target_dir}/$(hostname)-''${ID}
    '';
  };
  rsync-internal-external = pkgs.writeTextFile {
    name = "rsync-internal-external";
    destination = "/bin/rsync-internal-external";
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # External SATA external backup drive UUID=82a75835-a541-4976-bc10-d643a69169b6
      # Internal SATA internal backup drive UUID=a964e4ff-b7e1-4d41-b236-40807252d02a
      # Internal NVME backup drive UUID=174c69f3-e1cd-4c29-98f1-a18dfd0c6d34

      src_filesystem_UUID="174c69f3-e1cd-4c29-98f1-a18dfd0c6d34"
      src_dir="/mnt/backup/internal"
      remount_src=0
      unmount_src=0
      target_filesystem_UUID="82a75835-a541-4976-bc10-d643a69169b6"
      target_dir="/mnt/backup/128Gext"
      remount_target=0
      unmount_target=0
      source_mount_options='''
      target_mount_options='-o relatime,discard=async,compress=zstd,subvol=/@backup'

      # Determine status of source and mount if needed
      src_mounted_dir=$(findmnt -f UUID=''${src_filesystem_UUID} -n -o TARGET)
      if [ $? -eq 0 ]; then
          if [ ''${src_mounted_dir} != ''${src_dir} ]; then
              umount ''${src_mounted_dir}
              mount UUID=''${src_filesystem_UUID} ''${source_mount_options} ''${src_dir} || { echo "mount ''${src_dir} failed" ; exit 1; }
              remount_src=1
          else
              unmount_src=0
          fi
      else
          mount UUID=''${src_filesystem_UUID} ''${source_mount_options} ''${src_dir} || { echo "mount ''${src_dir} failed" ; exit 1; }
          unmount_src=1
      fi

      # Determine status of target and mount if needed
      target_mounted_dir=$(findmnt -f UUID=''${target_filesystem_UUID} -n -o TARGET)
      if [ $? -eq 0 ]; then
          if [ ''${target_mounted_dir} != ''${target_dir} ]; then
              umount ''${target_mounted_dir}
              mount UUID=''${target_filesystem_UUID} ''${target_mount_options} ''${target_dir} || { echo "mount ''${target_dir} failed" ; exit 1; }
              remount_target=1
          else
              unmount_target=0
          fi
      else
          mount UUID=''${target_filesystem_UUID} ''${target_mount_options} ''${target_dir} || { echo "mount ''${target_dir} failed" ; exit 1; }
          unmount_target=1
      fi

      echo
      echo "syncing ''${src_dir} -> ''${target_dir}"
      echo

      #rsync -avxHASe ssh -X --filter='-x security.selinux' --delete --delete-excluded ''${src_dir}/ ''${target_dir}
      rsync -avxHASe ssh --delete --delete-excluded ''${src_dir}/ ''${target_dir}
      echo 1 > /proc/sys/vm/drop_caches
      if [ $unmount_src -eq 1 ] || [ $remount_src -eq 1 ]; then
          umount ''${src_dir} || { echo "umount ''${src_dir} failed" ; exit 1; }
          if [ $remount_src -eq 1 ]; then
              mount UUID=''${src_filesystem_UUID} ''${source_mount_options} ''${src_mounted_dir} || { echo "mount ''${src_mounted_dir} failed" ; exit 1; }
          fi
      fi
      if [ $unmount_target -eq 1 ] || [ $remount_target -eq 1 ]; then
          umount ''${target_dir} || { echo "umount ''${target_dir} failed" ; exit 1; }
          if [ $remount_target -eq 1 ]; then
              mount UUID=''${target_filesystem_UUID} ''${target_mount_options} ''${target_mounted_dir} || { echo "mount ''${target_mounted_dir} failed" ; exit 1; }
          fi
      fi
    '';
  };
in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    reboot-menu
    rsync-backup-internal
    rsync-backup-local
    rsync-backup-remote
    rsync-internal-external
  ];
}
