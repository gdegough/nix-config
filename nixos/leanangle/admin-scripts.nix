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
    destination = "/bin/reboot-menu";
    executable = true;
    text = ''
    #!/usr/bin/env bash

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
        systemctl reboot --boot-loader-entry=''${menuItem}
    done
    '';
  };
  rsync-backup-local = pkgs.writeTextFile {
    name = "rsync-backup-local";
    destination = "/bin/rsync-backup-local";
    executable = true;
    text = ''
    #!/usr/bin/env bash

    set -e # exit immediately on command failure

    out() { printf "$1 $2\n" "''${@:3}"; }
    error() { out "==> ERROR:" "$@"; } >&2
    warning() { out "==> WARNING:" "$@"; } >&2
    msg() { out "==>" "$@"; }
    msg2() { out "  ->" "$@";}
    die() { error "$@"; exit 1; }

    _DEBUG="off"
    DEBUG() {
        if [[ "$_DEBUG" == "on" ]]; then
           $@
        fi
    }

    usage() {
      cat <<EOF
    usage: ''${0##*/} [arguments...]

        -d                       Verbose output (debug)
        -h                       Print this help message and exit
        -t <target_directory>    target directory on host

    EOF
    }

    target_dir='''
    src_folders="/root /home /etc"

    if [ -d /usr/share/keyrings ]; then
        src_folders="''${src_folders} /usr/share/keyrings"
    fi
    if [ -d /var/db/repos/localrepo ]; then
        src_folders="''${src_folders} /var/db/repos/localrepo"
    fi

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
            target_dir=''${OPTARG} 
            ;;
        ?) 
            die '%s: invalid option -- %s' "''${0##*/}" "''${OPTARG}" 
            ;;
        esac
    done
    shift "$(( OPTIND - 1 ))"

    # set some personal defaults
    if [ -z ''${target_dir} ]; then 
        target_dir="/mnt/backup/internal"
    fi

    #
    # read in OS info
    #
    ID='''
    if [ -r /etc/os-release ]; then
        . /etc/os-release
    elif [ -r /usr/lib/os-release ]; then
        . /usr/lib/os-release
    fi
    if [ -z ''${ID} ] ; then
        ID='unknown'
    fi

    echo
    echo "syncing ''${src_folders} -> ''${target_dir}/$(hostname)-''${ID}"
    echo

    for i in ''${src_folders}
    do
        rsync -avRHASL \
        --delete --delete-excluded \
        --exclude="- akonadi/" \
        --exclude="- baloo/" \
        --exclude="- .cache/" \
        --exclude="- .cargo/" \
        --exclude="- .ccache/" \
        --exclude="- *.iso" \
        --exclude="- Library/Caches/" \
        --exclude="- .local/share/flatpak/" \
        --exclude="- .local/state/" \
        --exclude="- Mega Limited/" \
        --exclude="- .nix-defexpr/" \
        --exclude="- .nix-profile/" \
        --exclude="- public/" \
        --exclude="- *.qcow2" \
        --exclude="- .rustup/" \
        $i ''${target_dir}/$(hostname)-''${ID}/
    done
    sync
    '';
  };
  rsync-backup-remote = pkgs.writeTextFile {
    name = "rsync-backup-remote";
    destination = "/bin/rsync-backup-remote";
    executable = true;
    text = ''
    #!/usr/bin/env bash

    set -e # exit immediately on command failure

    out() { printf "$1 $2\n" "''${@:3}"; }
    error() { out "==> ERROR:" "$@"; } >&2
    warning() { out "==> WARNING:" "$@"; } >&2
    msg() { out "==>" "$@"; }
    msg2() { out "  ->" "$@";}
    die() { error "$@"; exit 1; }

    _DEBUG="off"
    DEBUG() {
        if [[ "$_DEBUG" == "on" ]]; then
           $@
        fi
    }

    usage() {
      cat <<EOF
    usage: ''${0##*/} [arguments...]

        -d                       Verbose output (debug)
        -h                       Print this help message and exit
        -r <remote_host>         remote host with which to sync
        -t <target_directory>    target directory on remote host

    EOF
    }

    remote_host='''
    target_dir='''
    src_folders="/root /home /etc"

    if [ -d /usr/share/keyrings ]; then
        src_folders="''${src_folders} /usr/share/keyrings"
    fi
    if [ -d /var/db/repos/localrepo ]; then
        src_folders="''${src_folders} /var/db/repos/localrepo"
    fi

    # read cmdline options
    while getopts dhr:t: flag
    do
        case $flag in
        d) 
            _DEBUG="on" 
            ;;
        h)
            usage 
            exit 0 
            ;;
        r) 
            remote_host=''${OPTARG} 
            ;;
        t) 
            target_dir=''${OPTARG} 
            ;;
        ?) 
            die '%s: invalid option -- %s' "''${0##*/}" "''${OPTARG}" 
            ;;
        esac
    done
    shift "$(( OPTIND - 1 ))"

    # set some personal defaults
    if [ -z ''${remote_host} ]; then 
        remote_host='leanangle'
    fi
    if [ -z ''${target_dir} ]; then 
        target_dir="/mnt/backup/internal"
    fi

    #
    # read in OS info
    #
    ID='''
    if [ -r /etc/os-release ]; then
        . /etc/os-release
    elif [ -r /usr/lib/os-release ]; then
        . /usr/lib/os-release
    fi
    if [ -z ''${ID} ]; then
        ID='unknown'
    fi

    echo
    echo "syncing ''${src_folders} -> ''${remote_host}:''${target_dir}/$(hostname)-''${ID}"
    echo

    for i in ''${src_folders}
    do
        rsync -avRHASLe ssh \
        --delete --delete-excluded \
        --exclude="- akonadi/" \
        --exclude="- baloo/" \
        --exclude="- .cache/" \
        --exclude="- .cargo/" \
        --exclude="- .ccache/" \
        --exclude="- *.iso" \
        --exclude="- Library/Caches/" \
        --exclude="- .local/share/flatpak/" \
        --exclude="- .local/state/" \
        --exclude="- MEGA/" \
        --exclude="- Mega Limited/" \
        --exclude="- music-library/" \
        --exclude="- .nix-defexpr/" \
        --exclude="- .nix-profile/" \
        --exclude="- public/" \
        --exclude="- *.qcow2" \
        --exclude="- .rustup/" \
        $i ''${remote_host}:''${target_dir}/$(hostname)-''${ID}/
    done
    '';
  };
  rsync-internal-external = pkgs.writeTextFile {
    name = "rsync-internal-external";
    destination = "/bin/rsync-internal-external";
    executable = true;
    text = ''
    #!/usr/bin/env bash

    set -e # exit immediately on command failure

    out() { printf "$1 $2\n" "''${@:3}"; }
    error() { out "==> ERROR:" "$@"; } >&2
    warning() { out "==> WARNING:" "$@"; } >&2
    msg() { out "==>" "$@"; }
    msg2() { out "  ->" "$@";}
    die() { error "$@"; exit 1; }

    _DEBUG="off"
    DEBUG() {
        if [[ "$_DEBUG" == "on" ]]; then
           $@
        fi
    }

    usage() {
      cat <<EOF
    usage: ''${0##*/} [arguments...]

        -d                       Verbose output (debug)
        -h                       Print this help message and exit
        -s <source_directory>    source directory on host
        -t <target_directory>    target directory on host

    EOF
    }

    target_dir='''
    src_dir='''

    # read cmdline options
    while getopts dhs:t: flag
    do
        case $flag in
        d) 
            _DEBUG="on" 
            ;;
        h)
            usage 
            exit 0 
            ;;
        s) 
            src_dir=''${OPTARG} 
            ;;
        t) 
            target_dir=''${OPTARG} 
            ;;
        ?) 
            die '%s: invalid option -- %s' "''${0##*/}" "''${OPTARG}" 
            ;;
        esac
    done
    shift "$(( OPTIND - 1 ))"

    # set some personal defaults
    if [ -z ''${src_dir} ]; then 
        src_dir="/mnt/backup/internal"
    fi
    if [ -z ''${target_dir} ]; then 
        target_dir="/mnt/backup/128Gext"
    fi

    echo
    echo "syncing ''${src_dir} -> ''${target_dir}"
    echo

    for i in ''${src_dir}
    do
        rsync -avHASL \
        --delete --delete-excluded \
        $i/ ''${target_dir}/
    done
    sync
    '';
  };
in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    reboot-menu
    rsync-backup-local
    rsync-backup-remote
    rsync-internal-external
  ];
}
