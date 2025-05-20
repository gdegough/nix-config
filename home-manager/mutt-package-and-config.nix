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
    pkgs.mutt
  ];
  home.file = {
    ".muttrc".text = ''
      ###----------------------------------------------------------------------------
      ### Global settings
      ###----------------------------------------------------------------------------
      source "$HOME/.mutt/muttrc"

      ###----------------------------------------------------------------------------
      ### Local settings
      ###----------------------------------------------------------------------------
      unset suspend
      set spoolfile="$HOME/Maildir/"

      # local mailboxes go here
      source "$HOME/.mutt/mailboxes-local"

      # configure it to the account where you are using mutt
      set hostname="`hostname`"

      set mail_check="120"
      set imap_keepalive="120"
      macro pager , "<sync-mailbox><change-folder>?<toggle-mailboxes>"
      macro index , "<sync-mailbox><change-folder>?<toggle-mailboxes>"
    '';
    ".mutt/accounts_account_hooks".text = ''
      ###----------------------------------------------------------------------------
      ### Account Settings :: Account Hooks
      ###----------------------------------------------------------------------------

      # Always reset account-hook to sensible defaults
      account-hook . '\
          unset imap_user;\
          unset imap_pass;\
          unset tunnel;'
      #   set status_format="-=- DEFAULT -=- ";\

      account-hook imaps://imap.gmail.com:993 'set \
          imap_user="gdegough@gmail.com"\
          imap_pass="xxxxxxxx"'

      #account-hook imaps://mail.account-server-01.org 'set \
      #    imap_user="my_login@account-server-01.org"\
      #    imap_pass="my_pass_at_account-server-01.org"'
          
      #account-hook account-server-02 'set \
      #    tunnel="ssh -q -C -l my_login account-server-02 imapd 2>/dev/null Maildir/"'

      #account-hook imap://account-server-03 'set \
      #    tunnel="ssh -q -C -l my_login account-server-03 /home/externo/my_login/imapd 2>/dev/null Maildir/"'

      #account-hook imap://account-server-04 'set \
      #    tunnel="ssh -q -C -l my_login account-server-04 imapd 2>/dev/null Maildir/"'

      #account-hook imap://account-server-06 'set \
      #    tunnel="ssh -p16123 -q -C -l my_login account-server-06 imapd 2>/dev/null Maildir/"'


      # Account no. 5
      #account-hook imaps://account-server-05 ' set \
      #    imap_user="my_login"'
      # SSH forwarded account no. 5, since it is closed to outside access
      #account-hook imaps://localhost:15143 ' set \
      #    preconnect="ssh -f -q -L 15143:imap.account-server-05:993 -L 15145:smtp.account-server-05:25 login.account-server-05 sleep 25"\
      #    imap_user="my_login"'
    '';
    ".mutt/accounts_folder_hooks".text = ''
      ###----------------------------------------------------------------------------
      ### Account settings :: Folder Hooks
      ###----------------------------------------------------------------------------


      folder-hook .	'unset from;\
          set sendmail="sendmail -oem -oi";'
      #    set from="my_login@account-server-09.com.br";\    

      folder-hook gdegough@gmail.com/.* 'set \
          from = "gdegough@gmail.com"\
          smtp_url = "smtp://gdegough@smtp.gmail.com:587/"\
          smtp_pass = "xxxxxxxx"\
          realname = "Gregory DeGough"\
          hostname = "gmail.com"\
          ssl_force_tls = "yes";\
          unset ssl_starttls'

      #folder-hook mail.account-server-01.org/.* 'set \
      #    from="my_login@account-server-01.org"\
      #    sendmail="ssh my_login@mail.account-server-01.org sendmail -oem -oi"'

      #folder-hook account-server-06/.* 'set \
      #    from="my_login@account-server-06"\
      #    sendmail="ssh -p16123 my_login@account-server-06 sendmail -oem -oi"'
          
      #folder-hook account-server-02/.* 'set \
      #    from="my_login@account-server-02"\
      #    sendmail="ssh my_login@account-server-02 sendmail -oem -oi"'
          
      #folder-hook account-server-03/.* 'set \
      #    from="my_login@account-server-03"\
      #    sendmail="ssh my_login@account-server-03 sendmail -oem -oi"'
          

      #Account no. 5
      #folder-hook localhost:15143/.* 'set \
      #    from="my_login@account-server-05"\
      #    sendmail="esmtp -v -X /tmp/esmtp.log -f my_login@account-server-05"'
      #folder-hook account-server-05/.* 'set \
      #    from="my_login@daccount-server-05"\
      #    sendmail="esmtp -v -X /tmp/esmtp.log -f my_login@account-server-05"'

      # Account-server-04
      #folder-hook account-server-04/.* 'set \
      #    from="my_login@account-server-04"\
      #    sendmail="ssh my_login@account-server-04 sendmail -oem -oi"'
    '';
    ".mutt/muttrc".text = ''
      ###----------------------------------------------------------------------------
      ### Global Settings
      ###----------------------------------------------------------------------------
      set quit="ask-yes"
      set header="yes"
      set mbox_type="Maildir"
      set check_new="yes"
      set use_from="yes"
      set mail_check = 15
      set spoolfile="$HOME/Maildir/"
      set folder="$HOME/Maildir/"
      set mbox="=/Maildir/"
      set record="=sent/"
      set postponed="=drafts/"
      set editor="vim -f -c 'set tw=72 et ft=mail fo=tr'"
      set mime_forward="ask-yes"
      set header="yes"

      # Local folders for cached headers and certificates
      set header_cache = "$HOME/.mutt/cache/headers"
      set message_cachedir = "$HOME/.mutt/cache/bodies"
      set certificate_file = "$HOME/.mutt/certificates"
      set pager_context=4
      set pager_index_lines=10
      set pager_stop
      set sig_dashes='yes'
      set signature='$HOME/.mutt/signature'

      ###----------------------------------------------------------------------------
      ### Aliases
      ###----------------------------------------------------------------------------
      set alias_file="$HOME/.mutt/aliases"
      source "$HOME/.mutt/aliases"

      ###----------------------------------------------------------------------------
      ### Macros
      ###----------------------------------------------------------------------------
      macro  generic	 \em  ":source $HOME/.muttrc\n" "Reload mutt's configuration file"

      ###----------------------------------------------------------------------------
      ### Load external global settings
      ###----------------------------------------------------------------------------
      source $HOME/.mutt/header_config
      source $HOME/.mutt/keybind
      source $HOME/.mutt/color
    '';
    ".mutt/mailboxes-local".text = ''
      ###----------------------------------------------------------------------------
      ### Local Mailboxes
      ###----------------------------------------------------------------------------
      mailboxes ! + `\
      for file in $HOME/Maildir/.*; do \
        box=$(basename "$file"); \
        if [ ! "$box" = '.' -a ! "$box" = '..' -a ! "$box" = '.customflags' \
            -a ! "$box" = '.subscriptions' ]; then \
          echo -n "\"+$box\" "; \
        fi; \
      done`
    '';
    ".mutt/aliases".text = ''
      #
      # .mail_aliases - private mail aliases
      #
      # see also mail(1)
      #

      # FreeBSD Mailing lists aliases
      # alias freebsd-bugs freebsd-bugs@FreeBSD.org
      # alias freebsd-questions freebsd-questions@FreeBSD.org

      # an alias for your good friends
      # alias bicycle  christoph gerhardt velophil zentralrad

      alias me "DeGough, Gregory M." <gdegough@gmail.com>

      alias briggs_carney "Briggs, Carney" <carney.briggs@gmail.com>
      alias briggs_marsha "Briggs, Marsha" <mbriggs@chapman.edu>
      alias degough_aaron "DeGough, Aaron" <adegough@gmail.com>
      alias degough_aaron_celinda "DeGough, Aaron & Celinda" <acdegough@gmail.com>
      alias degough_caleb "DeGough, Caleb" <cdegough@gmail.com>
      alias degough_celinda "DeGough, Celinda" <cdegough@affinitybank.com>
      alias degough_greg "DeGough, Gregory M." <gdegough@gmail.com>
      alias degough_jake "DeGough, Jacob" <koastin@gmail.com>
      alias degough_peggy "DeGough, Peggy" <peggydegough@gmail.com>
      alias degough_tifany "DeGough, Tifany" <tdegough@gmail.com>
      alias domenigoni_camellia "Domenigoni, Camellia" <sugarshackc@hotmail.com>
      alias eubanks_eric "Eubanks, Eric" <eseubanks@usamedia.tv>
      alias eubanks_evan "Eubanks, Evan" <longnecks@gmail.com>
      alias fox_daniel "Fox, Daniel" <dwfox12@gmail.com>
      alias fox_kathy "Fox, Kathy" <kakifox2003@yahoo.com>
      alias fox_michael "Fox, Michael" <bldprnt@pacbell.net>
      alias fox_raymond "Fox, Raymond" <raymondfoxx@yahoo.com>
      alias fox_raymond_shelly "Fox, Raymond & Shelly" <fmly4jc@sbcglobal.net>
      alias gamble_donna "Gamble, Donna" <nonnagamble@yahoo.com>
      alias gamble_fred "Gamble, Fred" <fggamble@pacbell.net>
      alias gay_chris "Gay, Chris" <chris.gay@weyerhaeuser.com>
      alias gay_rachelle "Gay, Rachelle" <chrisnrac@comcast.net>
      alias herota_mark "Herota, Mark" <kirxander@yahoo.com>
      alias howard_ryan "Howard, Ryan" <ryanhoward.pe@gmail.com>
      alias howard_sharon "Howard, Sharon" <sharonphoward@gmail.com>
      alias lee_holli "Lee, Holli" <richnhollilee@yahoo.com>
      alias long_donna "Long, Donna" <lonniendonna@comcast.net>
      alias long_lonnie "Long, Lonnie" <lonniendonna@comcast.net>
      alias long_lonnie_donna "Long, Lonnie & Donna" <lonniendonna@comcast.net>
      alias mackey_carol "Mackey, Carol" <puka89@hotmail.com>
      alias mackey_kaylee "Mackey, Kaylee" <singingsoprano93@yahoo.com>
      alias mackey_kevin "Mackey, Kevin" <kmackey87@hotmail.com>
      alias mackey_kristen "Mackey, Kristen" <kamackey@ucdavis.edu>
      alias mackey_paul "Mackey, Paul" <pdmackey798@aol.com>
      alias maudlin_james "Maudlin, James" <jmaudlin@cisco.com>
      alias maudlin_jim_jan "Maudlin, Jim & Jan" <pops2@sbcglobal.net>
      alias maudlin_megan "Maudlin, Megan" <megmaudlin@hotmail.com>
      alias mcguffin_don "McGuffin, Don" <don_mcguffin@hotmail.com>
      alias modgling_sarah "Modgling, Sarah" <smodgling@hotmail.com>
      alias osburn_stacey "Osburn, Stacey" <smosburn@hotmail.com>
      alias perrin_nick "Perrin, Nick" <s10guru@gmail.com>
      alias perrin_randy_linda "Perrin, Randy & Linda" <ranlin@copper.net>
      alias rowley_donna "Rowley, Donna" <donna@actionrealty.com>
      alias rowley_doug "Rowley, Doug" <doug.rowley.p0ti@statefarm.com>
      alias rowley_doug_molly "Rowley, Doug & Molly" <dnmrowley@gmail.com>
      alias rowley_scout "Scout" <molly.rowley.qaf8@statefarm.com>
      alias shores_moriah "Shores, Moriah" <moriahshores@surewest.net>
      alias shores_scott "Shores, Scott" <SShores@coen.com>
      alias stahl_gena "Stahl, Gena" <gstahl@altaregional.org>
      alias stahl_larry "Stahl, Larry" <stahlwerks@sbcglobal.net>
      alias steen_winona "Steen, Winona" <winona@sbcglobal.net>
      alias stevens_gail "Stevens, Gail" <flywsky@comcast.net>
      alias stevens_patsy "Stevens, Patsy" <sweetpea50@comcast.net>
      alias tate_paul "Tate, Paul" <matchingsocks@netzero.net>
      alias wackerly_earl "Wackerly, Earl" <eticketman@gmail.com>
      alias wackerly_shaun "Wackerly, Shaun" <swackerl@gmail.com>
      alias watson_rodney "Watson, Rodney" <rodney@cornerstonegroup.net>
      alias family degough_peggy degough_aaron degough_caleb degough_jake degough_celinda degough_tifany rowley_scout rowley_doug
    '';
    ".mutt/header_config".text = ''
      ###----------------------------------------------------------------------------
      ### header config
      ###----------------------------------------------------------------------------
      ignore User-Agent X-UIDL X-Keywords X-UID List- X-BeenThere
      ignore X-Mailman-Version X-eGroups X-Yahoo-
      ignore List- X-MDRemoteIP
      ignore X-MIMETrack
      ignore x-accept-language x-authentication-warning
      ignore x-qmail
      ignore X-MESINK
      ignore X-Apparently-To Mailing-List X-MIME-Autoconverted Importance
      unignore date
      hdr_order	Return-Path: From: Resent-By: Reply-To: X-Organisation: \
              X-Address: To: Cc: Bcc: Date: Subject:
      #my_hdr X-PGP-Key: http://www.burocrata.org/pubkey.asc
    '';
    ".mutt/keybind".text = ''
      ###----------------------------------------------------------------------------
      ### Binding
      ###----------------------------------------------------------------------------
      #bind pager $ imap-fetch-mail

      bind index <Left>  previous-unread
      bind index <Right> next-unread
      bind index <Up>   previous-entry
      bind index <Down>  next-entry

      bind pager <Left>  previous-entry
      bind pager <Right> next-entry
      bind pager <Up>   previous-line
      bind pager <Down>  next-line

      bind  pager <backspace> previous-page
      bind  pager -           previous-line
      bind  pager \eOm        previous-line
      bind  pager +           next-line
      bind  pager \eOk        next-line
      bind  pager \eOM        next-line
      bind  pager \e[1~       top
      bind  pager \e[4~       bottom

      bind  index <backspace> previous-entry
      bind  index -           previous-entry
      bind  index \eOm        previous-entry
      bind  index +           next-entry
      bind  index \eOk        next-entry
      bind  index \eOM        display-message
      bind  index \e[H        first-entry
      bind  index \e[F        last-entry
      bind  index \e[1~       first-entry
      bind  index \e[4~       last-entry

      bind  alias   <space>   select-entry
      bind  alias   x         exit
      bind  attach  x         exit
      bind  browser x         exit
    '';
    ".mutt/color".text = ''
      ###----------------------------------------------------------------------------
      ### color config
      ###----------------------------------------------------------------------------

      #source $HOME/.mutt/colors.default
      #source $HOME/.mutt/colors.linux
      #source $HOME/.mutt/solarized/mutt-colors-solarized-dark-16.muttrc
      #source $HOME/.mutt/solarized/mutt-colors-solarized-light-16.muttrc
      #source $HOME/.mutt/solarized/mutt-colors-solarized-dark-256.muttrc
      #source $HOME/.mutt/solarized/mutt-colors-solarized-light-256.muttrc
      source $HOME/.mutt/gruvbox/colors-gruvbox-shuber.muttrc
      #source $HOME/.mutt/gruvbox/colors-gruvbox-shuber-extended.muttrc
    '';
    ".mutt/colors.default".text = ''
      # -*-muttrc-*-

      # Palette for use with the Linux console.  Black background.

      #color normal black default
      color hdrdefault blue default
      color quoted green default 
      color signature blue default 
      color attachment brightred default
      color message brightred default
      color error brightred default
      color indicator brightwhite red
      color status brightgreen blue
      color tree default default
      color markers magenta default 
      color search brightcyan default
      color tilde brightmagenta default
      color underline brightgreen default
      color index blue default ~F
      color index red default "~N|~O"

      color header red default ^(From|Subject):
      color body brightblue default "(ftp|http)://[^ ><\"]+"	# point out URLs
      color body cyan default [-a-z_0-9.]+@[-a-z_0-9.]+	# e-mail addresses

      # color body brightwhite black '\*+[^*]+\*+'
      # color body brightwhite black '_+[^_]+_+'
    '';
    ".mutt/colors.linux".text = ''
      # -*-muttrc-*-

      # Palette for use with the Linux console.  Black background.

      color hdrdefault blue black
      color quoted blue black
      color signature blue black
      color attachment red black
      color message brightred black
      color error brightred black
      color indicator black red
      color status brightgreen blue
      color tree white black
      color normal white black
      color markers red black
      color search white black
      color tilde brightmagenta black
      color index blue black ~F
      color index red black "~N|~O"

      # color body brightwhite black '\*+[^*]+\*+'
      # color body brightwhite black '_+[^_]+_+'
    '';
    ".mutt/gpg.rc".text = ''
      # -*-muttrc-*-
      #
      # Command formats for gpg.
      # 
      # This version uses gpg-2comp from 
      #   http://muppet.faveve.uni-stuttgart.de/~gero/gpg-2comp.tar.gz
      #
      # $Id: gpg.rc,v 1.12 2001/12/11 09:33:57 roessler Exp $
      #
      # %p    The empty string when no passphrase is needed,
      #       the string "PGPPASSFD=0" if one is needed.
      #
      #       This is mostly used in conditional % sequences.
      #
      # %f    Most PGP commands operate on a single file or a file
      #       containing a message.  %f expands to this file's name.
      #
      # %s    When verifying signatures, there is another temporary file
      #       containing the detached signature.  %s expands to this
      #       file's name.
      #
      # %a    In "signing" contexts, this expands to the value of the
      #       configuration variable $pgp_sign_as.  You probably need to
      #       use this within a conditional % sequence.
      #
      # %r    In many contexts, mutt passes key IDs to pgp.  %r expands to
      #       a list of key IDs.

      # Note that we explicitly set the comment armor header since GnuPG, when used
      # in some localiaztion environments, generates 8bit data in that header, thereby
      # breaking PGP/MIME.

      # decode application/pgp
      set pgp_decode_command="gpg   %?p?--passphrase-fd 0? --no-verbose --quiet  --batch  --output - %f"

      # verify a pgp/mime signature
      set pgp_verify_command="gpg   --no-verbose --quiet  --batch  --output - --verify %s %f"

      # decrypt a pgp/mime attachment
      set pgp_decrypt_command="gpg   --passphrase-fd 0 --no-verbose --quiet  --batch  --output - %f"

      # create a pgp/mime signed attachment
      # set pgp_sign_command="gpg-2comp --comment ''' --no-verbose --batch  --output - --passphrase-fd 0 --armor --detach-sign --textmode %?a?-u %a? %f"
      set pgp_sign_command="gpg    --no-verbose --batch --quiet   --output - --passphrase-fd 0 --armor --detach-sign --textmode %?a?-u %a? %f"

      # create a application/pgp signed (old-style) message
      # set pgp_clearsign_command="gpg-2comp --comment '''  --no-verbose --batch  --output - --passphrase-fd 0 --armor --textmode --clearsign %?a?-u %a? %f"
      set pgp_clearsign_command="gpg   --no-verbose --batch --quiet   --output - --passphrase-fd 0 --armor --textmode --clearsign %?a?-u %a? %f"

      # create a pgp/mime encrypted attachment
      # set pgp_encrypt_only_command="pgpewrap gpg-2comp  -v --batch  --output - --encrypt --textmode --armor --always-trust -- -r %r -- %f"
      set pgp_encrypt_only_command="pgpewrap gpg    --batch  --quiet  --no-verbose --output - --encrypt --textmode --armor --always-trust -- -r %r -- %f"

      # create a pgp/mime encrypted and signed attachment
      # set pgp_encrypt_sign_command="pgpewrap gpg-2comp  --passphrase-fd 0 -v --batch  --output - --encrypt --sign %?a?-u %a? --armor --always-trust -- -r %r -- %f"
      set pgp_encrypt_sign_command="pgpewrap gpg  --passphrase-fd 0  --batch --quiet  --no-verbose  --textmode --output - --encrypt --sign %?a?-u %a? --armor --always-trust -- -r %r -- %f"

      # import a key into the public key ring
      set pgp_import_command="gpg  --no-verbose --import -v %f"

      # export a key from the public key ring
      set pgp_export_command="gpg   --no-verbose --export --armor %r"

      # verify a key
      set pgp_verify_key_command="gpg   --verbose --batch  --fingerprint --check-sigs %r"

      # read in the public key ring
      set pgp_list_pubring_command="gpg   --no-verbose --batch --quiet   --with-colons --list-keys %r" 

      # read in the secret key ring
      set pgp_list_secring_command="gpg   --no-verbose --batch --quiet   --with-colons --list-secret-keys %r" 

      # fetch keys
      # set pgp_getkeys_command="pkspxycwrap %r"

      # pattern for good signature - may need to be adapted to locale!

      # set pgp_good_sign="^gpg: Good signature from"

      # OK, here's a version which uses gnupg's message catalog:
      set pgp_good_sign="`gettext -d gnupg -s 'Good signature from "' | tr -d '"'`"
    '';
    ".mutt/gruvbox/colors-gruvbox-shuber-extended.muttrc".text = ''
      color sidebar_unread     color108 color234
    '';
    ".mutt/gruvbox/colors-gruvbox-shuber.muttrc".text = ''
      # gruvbox dark (contrast dark):

      # bg0    = 234
      # bg1    = 237
      # bg2    = 239
      # bg3    = 241
      # bg4    = 243
      # 
      # gray   = 245
      # 
      # fg0    = 229
      # fg1    = 223
      # fg2    = 250
      # fg3    = 248
      # fg4    = 246
      # 
      # red    = 167
      # green  = 142
      # yellow = 214
      # blue   = 109
      # purple = 175
      # aqua   = 108
      # orange = 208


      # See http://www.mutt.org/doc/manual/#color

      color attachment  color109 color234
      color bold        color229 color234
      color error       color167 color234
      color hdrdefault  color246 color234
      color indicator   color223 color237
      color markers     color243 color234
      color normal      color223 color234
      color quoted      color250 color234
      color quoted1     color108 color234
      color quoted2     color250 color234
      color quoted3     color108 color234
      color quoted4     color250 color234
      color quoted5     color108 color234
      color search      color234 color208
      color signature   color108 color234
      color status      color234 color250
      color tilde       color243 color234
      color tree        color142 color234
      color underline   color223 color239

      color sidebar_divider    color250 color234
      color sidebar_new        color142 color234

      color index color142 color234 ~N
      color index color108 color234 ~O
      color index color109 color234 ~P
      color index color214 color234 ~F
      color index color175 color234 ~Q
      color index color167 color234 ~=
      color index color234 color223 ~T
      color index color234 color167 ~D

      color header color214 color234 "^(To:|From:)"
      color header color142 color234 "^Subject:"
      color header color108 color234 "^X-Spam-Status:"
      color header color108 color234 "^Received:"

      # Regex magic for URLs and hostnames
      #
      # Attention: BSD's regex has RE_DUP_MAX set to 255.
      #
      # Examples:
      #   http://some-service.example.com
      #   example.com
      #   a.example.com
      #   some-service.example.com
      #   example.com/
      #   example.com/datenschutz
      #   file:///tmp/foo
      #
      # Non-examples:
      #   1.1.1900
      #   14.02.2022/24:00
      #   23.59
      #   w.l.o.g
      #   team.its
      color body color142 color234 "[a-z]{3,255}://[[:graph:]]*"
      color body color142 color234 "([-[:alnum:]]+\\.)+([0-9]{1,3}|[-[:alpha:]]+)/[[:graph:]]*"
      color body color142 color234 "([-[:alnum:]]+\\.){2,255}[-[:alpha:]]{2,10}"

      # IPv4 and IPv6 stolen from https://stackoverflow.com/questions/53497/regular-expression-that-matches-valid-ipv6-addresses
      color body color142 color234 "((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])"
      color body color142 color234 "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))"

      # Mail addresses and mailto URLs
      color body color208 color234 "[-a-z_0-9.%$]+@[-a-z_0-9.]+\\.[-a-z][-a-z]+"
      color body color208 color234 "mailto:[-a-z_0-9.]+@[-a-z_0-9.]+"

      # some simleys and stuff
      color body color234 color214 "[;:]-*[)>(<lt;|]"
      color body color229 color234 "\\*[- A-Za-z]+\\*"

      color body color214 color234 "^-.*PGP.*-*"
      color body color142 color234 "^gpg: Good signature from"
      color body color167 color234 "^gpg: Can't.*$"
      color body color214 color234 "^gpg: WARNING:.*$"
      color body color167 color234 "^gpg: BAD signature from"
      color body color167 color234 "^gpg: Note: This key has expired!"
      color body color214 color234 "^gpg: There is no indication that the signature belongs to the owner."
      color body color214 color234 "^gpg: can't handle these multiple signatures"
      color body color214 color234 "^gpg: signature verification suppressed"
      color body color214 color234 "^gpg: invalid node with packet of type"

      color body color142 color234 "^Good signature from:"
      color body color167 color234 "^.?BAD.? signature from:"
      color body color142 color234 "^Verification successful"
      color body color167 color234 "^Verification [^s][^[:space:]]*$"

      color compose header            color223 color234
      color compose security_encrypt  color175 color234
      color compose security_sign     color109 color234
      color compose security_both     color142 color234
      color compose security_none     color208 color234
    '';
    ".mutt/lists_hooks".text = ''
      send-hook . 'unmy_hdr From:'
      send-hook '~t gdegough@gmail.com' 'my_hdr From: "DeGough, Gregory M." <gdegough@gmail.com>'

      #send-hook '~t ^alu-l@account-server-02' 'my_hdr From: Tiago Macambira <my_login-alu@account-server-02>'
      #send-hook '~t ufcsite-l@account-server-02' 'my_hdr From: Tiago Macambira <my_login-ufcsite@account-server-02>'
      #send-hook '~t postfix-users@no.spam.cloud9.net' 'my_hdr From: Tiago Macambira <my_login-postfix@account-server-02>'
      #send-hook '~t p2p-hackers@no.spam.zgp.org' 'my_hdr From: Tiago Macambira <my_login-p2phackers@account-server-02>'
      #send-hook '~t decentralization@no.spam.egroups.com' 'my_hdr From: Tiago Macambira <my_login-decentralization@no.spam.account-server-02>'
      #send-hook '~t peleja@no.spam.yahoogrupos.com.br' 'my_hdr From: Tiago Macambira <my_login-peleja@account-server-02>'
      #send-hook '~t linphone-users@no.spam.nongnu.org' 'my_hdr From: Tiago Macambira <my_login-linphone@account-server-02>'
    '';
    ".mutt/mailboxes-imap".text = ''
      ###----------------------------------------------------------------------------
      ### Global Mailboxes
      ###----------------------------------------------------------------------------

      mailboxes "imaps://imap.gmail.com:993/INBOX"
      mailboxes "imaps://imap.gmail.com:993/Bike Parts"
      mailboxes "imaps://imap.gmail.com:993/eBay"
      mailboxes "imaps://imap.gmail.com:993/good news"
      mailboxes "imaps://imap.gmail.com:993/Junk E-mail"
      mailboxes "imaps://imap.gmail.com:993/PayPal"
      mailboxes "imaps://imap.gmail.com:993/Queue"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/All Mail"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Drafts"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Important"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Sent Mail"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Starred"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Spam"
      mailboxes "imaps://imap.gmail.com:993/[Gmail]/Trash"
    '';
    ".mutt/personal".text = ''
      ## Receive Options
      set imap_user = 'gdegough@gmail.com'
      set imap_pass = 'xxxxxxxx'
      set folder = 'imaps://imap.gmail.com:993'
      set spoolfile = '+INBOX'
      set postponed = '+[GMAIL]/Drafts' 
      set record = '+[GMAIL]/Sent Mail'

      ## Send Options
      set smtp_url = 'smtp://gdegough@smtp.gmail.com:587/'
      set smtp_pass = 'xxxxxxxx'
      set realname = 'Gregory DeGough'
      set from = 'gdegough@gmail.com'
      set hostname = 'gmail.com'
      set signature = '-greg'
      # Connection Options
      set ssl_force_tls = yes
      unset ssl_starttls

      ## Hook -- IMPORTANT!!
      account-hook $folder 'set imap_user="gdegough@gmail.com"; set imap_pass="xxxxxxxx"'

      # Gmail-style keyboard shortcuts
      macro index,pager y "unset trash\n " "Gmail archive message"
      macro index,pager d "set trash=\"imaps://imap.googlemail.com/[GMAIL]/Bin\"\n " "Gmail delete message"
      macro index,pager gi "=INBOX" "Go to inbox"
      macro index,pager ga "=[GMAIL]/All Mail" "Go to all mail"
      macro index,pager gs "=[GMAIL]/Starred" "Go to starred messages"
      macro index,pager gd "=[GMAIL]/Drafts" "Go to drafts"
      macro index,pager gp "=[GMAIL]/Spam" "Go to spam"
      macro index,pager gt "=[GMAIL]/Trash" "Go to trash"
    '';
    ".mutt/signature".text = ''
      --
      Greg
    '';
    ".mutt/solarized/mutt-colors-solarized-dark-16.muttrc".text = ''
      # vim: filetype=muttrc

      #
      #
      # make sure that you are using mutt linked against slang, not ncurses, or
      # suffer the consequences of weird color issues. use "mutt -v" to check this.

      # custom body highlights -----------------------------------------------
      # highlight my name and other personally relevant strings
      #color body          yellow          default         "(ethan|schoonover)"
      # custom index highlights ----------------------------------------------
      # messages which mention my name in the body
      #color index         yellow          default         "~b \"phil(_g|\!| gregory| gold)|pgregory\" !~N !~T !~F !~p !~P"
      #color index         J_cream         brightwhite     "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~N !~T !~F !~p !~P"
      #color index         yellow          cyan            "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~T !~F !~p !~P"
      #color index         yellow          J_magent        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~F !~p !~P"
      ## messages which are in reference to my mails
      #color index         J_magent        default         "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" !~N !~T !~F !~p !~P"
      #color index         J_magent        brightwhite     "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~N !~T !~F !~p !~P"
      #color index         J_magent        cyan            "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~T !~F !~p !~P"
      #color index         J_magent        red             "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~F !~p !~P"

      # for background in 16 color terminal, valid background colors include:
      # base03, bg, black, any of the non brights

      # basic colors ---------------------------------------------------------
      color normal        brightyellow    default         
      color error         red             default         
      color tilde         black           default         
      color message       cyan            default         
      color markers       red             white           
      color attachment    white           default         
      color search        brightmagenta   default         
      #color status        J_black         J_status        
      color status        brightyellow    black           
      color indicator     brightblack     yellow          
      color tree          yellow          default                                     # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         red             default         "~D(!~p|~p)"               # deleted
      #color index         black           default         ~F                         # flagged
      #color index         brightred       default         ~=                         # duplicate messages
      #color index         brightgreen     default         "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          default         "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         red             default         "~A"                        # all messages
      color index         brightred       default         "~E"                        # expired messages
      color index         blue            default         "~N"                        # new messages
      color index         blue            default         "~O"                        # old messages
      color index         brightmagenta   default         "~Q"                        # messages that have been replied to
      color index         brightgreen     default         "~R"                        # read messages
      color index         blue            default         "~U"                        # unread messages
      color index         blue            default         "~U~$"                      # unread, unreferenced messages
      color index         brightyellow    default         "~v"                        # messages part of a collapsed thread
      color index         brightyellow    default         "~P"                        # messages from me
      color index         cyan            default         "~p!~F"                     # messages to me
      color index         cyan            default         "~N~p!~F"                   # new messages to me
      color index         cyan            default         "~U~p!~F"                   # unread messages to me
      color index         brightgreen     default         "~R~p!~F"                   # messages to me
      color index         red             default         "~F"                        # flagged messages
      color index         red             default         "~F~p"                      # flagged messages to me
      color index         red             default         "~N~F"                      # new flagged messages
      color index         red             default         "~N~F~p"                    # new flagged messages to me
      color index         red             default         "~U~F~p"                    # new flagged messages to me
      color index         black           red             "~D"                        # deleted messages
      color index         brightcyan      default         "~v~(!~N)"                  # collapsed thread with no unread
      color index         yellow          default         "~v~(~N)"                   # collapsed thread with some unread
      color index         green           default         "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         red             black           "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         yellow          black           "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         green           black           "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         green           black           "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         cyan            black           "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         yellow          red             "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         yellow          default         "~(~N)"                    # messages in threads with some unread
      #color index         green           default         "~S"                       # superseded messages
      #color index         red             default         "~T"                       # tagged messages
      #color index         brightred       red             "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        brightgreen     default         "^"
      color hdrdefault    brightgreen     default         
      color header        brightyellow    default         "^(From)"
      color header        blue            default         "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        blue            default         
      color quoted1       cyan            default         
      color quoted2       yellow          default         
      color quoted3       red             default         
      color quoted4       brightred       default         

      color signature     brightgreen     default         
      color bold          black           default         
      color underline     black           default         
      color normal        default         default         
      #
      color body          brightcyan      default         "[;:][-o][)/(|]"    # emoticons
      color body          brightcyan      default         "[;:][)(|]"         # emoticons
      color body          brightcyan      default         "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          brightcyan      default         "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          brightcyan      default         "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          red             default         "(BAD signature)"
      color body          cyan            default         "(Good signature)"
      color body          brightblack     default         "^gpg: Good signature .*"
      color body          brightyellow    default         "^gpg: "
      color body          brightyellow    red             "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"

      # yes, an insance URL regex
      color body          red             default         "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      # and a heavy handed email regex
      #color body          J_magent        default         "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

      # Various smilies and the like
      #color body          brightwhite     default         "<[Gg]>"                            # <g>
      #color body          brightwhite     default         "<[Bb][Gg]>"                        # <bg>
      #color body          yellow          default         " [;:]-*[})>{(<|]"                  # :-) etc...
      # *bold*
      #color body          blue            default         "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      #mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      # _underline_
      #color body          blue            default         "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      #mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      # /italic/  (Sometimes gets directory names)
      #color body         blue            default         "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
      #mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

      # Border lines.
      #color body          blue            default         "( *[-+=#*~_]){6,}"

      #folder-hook .                  "color status        J_black         J_status        "
      #folder-hook gmail/inbox        "color status        J_black         yellow          "
      #folder-hook gmail/important    "color status        J_black         yellow          "
    '';
    ".mutt/solarized/mutt-colors-solarized-dark-256.muttrc".text = ''
      # vim: filetype=muttrc

      #
      #
      # make sure that you are using mutt linked against slang, not ncurses, or
      # suffer the consequences of weird color issues. use "mutt -v" to check this.

      # custom body highlights -----------------------------------------------
      # highlight my name and other personally relevant strings
      #color body          color136        color234        "(ethan|schoonover)"
      # custom index highlights ----------------------------------------------
      # messages which mention my name in the body
      #color index         color136        color234        "~b \"phil(_g|\!| gregory| gold)|pgregory\" !~N !~T !~F !~p !~P"
      #color index         J_cream         color230        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~N !~T !~F !~p !~P"
      #color index         color136        color37         "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~T !~F !~p !~P"
      #color index         color136        J_magent        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~F !~p !~P"
      ## messages which are in reference to my mails
      #color index         J_magent        color234        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" !~N !~T !~F !~p !~P"
      #color index         J_magent        color230        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~N !~T !~F !~p !~P"
      #color index         J_magent        color37         "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~T !~F !~p !~P"
      #color index         J_magent        color160        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~F !~p !~P"

      # for background in 16 color terminal, valid background colors include:
      # base03, bg, black, any of the non brights

      # basic colors ---------------------------------------------------------
      color normal        color241        color234        
      color error         color160        color234        
      color tilde         color235        color234        
      color message       color37         color234        
      color markers       color160        color254        
      color attachment    color254        color234        
      color search        color61         color234        
      #color status        J_black         J_status        
      color status        color241        color235        
      color indicator     color234        color136        
      color tree          color136        color234                                    # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         color160        color234        "~D(!~p|~p)"               # deleted
      #color index         color235        color234        ~F                         # flagged
      #color index         color166        color234        ~=                         # duplicate messages
      #color index         color240        color234        "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          color234        "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         color160        color234        "~A"                        # all messages
      color index         color166        color234        "~E"                        # expired messages
      color index         color33         color234        "~N"                        # new messages
      color index         color33         color234        "~O"                        # old messages
      color index         color61         color234        "~Q"                        # messages that have been replied to
      color index         color240        color234        "~R"                        # read messages
      color index         color33         color234        "~U"                        # unread messages
      color index         color33         color234        "~U~$"                      # unread, unreferenced messages
      color index         color241        color234        "~v"                        # messages part of a collapsed thread
      color index         color241        color234        "~P"                        # messages from me
      color index         color37         color234        "~p!~F"                     # messages to me
      color index         color37         color234        "~N~p!~F"                   # new messages to me
      color index         color37         color234        "~U~p!~F"                   # unread messages to me
      color index         color240        color234        "~R~p!~F"                   # messages to me
      color index         color160        color234        "~F"                        # flagged messages
      color index         color160        color234        "~F~p"                      # flagged messages to me
      color index         color160        color234        "~N~F"                      # new flagged messages
      color index         color160        color234        "~N~F~p"                    # new flagged messages to me
      color index         color160        color234        "~U~F~p"                    # new flagged messages to me
      color index         color235        color160        "~D"                        # deleted messages
      color index         color245        color234        "~v~(!~N)"                  # collapsed thread with no unread
      color index         color136        color234        "~v~(~N)"                   # collapsed thread with some unread
      color index         color64         color234        "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         color160        color235        "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         color136        color235        "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         color64         color235        "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         color64         color235        "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         color37         color235        "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         color136        color160        "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         color136        color234        "~(~N)"                    # messages in threads with some unread
      #color index         color64         color234        "~S"                       # superseded messages
      #color index         color160        color234        "~T"                       # tagged messages
      #color index         color166        color160        "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        color240        color234        "^"
      color hdrdefault    color240        color234        
      color header        color241        color234        "^(From)"
      color header        color33         color234        "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        color33         color234        
      color quoted1       color37         color234        
      color quoted2       color136        color234        
      color quoted3       color160        color234        
      color quoted4       color166        color234        

      color signature     color240        color234        
      color bold          color235        color234        
      color underline     color235        color234        
      color normal        color244        color234        
      #
      color body          color245        color234        "[;:][-o][)/(|]"    # emoticons
      color body          color245        color234        "[;:][)(|]"         # emoticons
      color body          color245        color234        "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          color245        color234        "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          color245        color234        "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          color160        color234        "(BAD signature)"
      color body          color37         color234        "(Good signature)"
      color body          color234        color234        "^gpg: Good signature .*"
      color body          color241        color234        "^gpg: "
      color body          color241        color160        "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"

      # yes, an insance URL regex
      color body          color160        color234        "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      # and a heavy handed email regex
      #color body          J_magent        color234        "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

      # Various smilies and the like
      #color body          color230        color234        "<[Gg]>"                            # <g>
      #color body          color230        color234        "<[Bb][Gg]>"                        # <bg>
      #color body          color136        color234        " [;:]-*[})>{(<|]"                  # :-) etc...
      # *bold*
      #color body          color33         color234        "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      #mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      # _underline_
      #color body          color33         color234        "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      #mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      # /italic/  (Sometimes gets directory names)
      #color body         color33         color234        "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
      #mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

      # Border lines.
      #color body          color33         color234        "( *[-+=#*~_]){6,}"

      #folder-hook .                  "color status        J_black         J_status        "
      #folder-hook gmail/inbox        "color status        J_black         color136        "
      #folder-hook gmail/important    "color status        J_black         color136        "
    '';
    ".mutt/solarized/mutt-colors-solarized-light-16.muttrc".text = ''
      # vim: filetype=muttrc

      #
      #
      # make sure that you are using mutt linked against slang, not ncurses, or
      # suffer the consequences of weird color issues. use "mutt -v" to check this.

      # custom body highlights -----------------------------------------------
      # highlight my name and other personally relevant strings
      #color body          yellow          default         "(ethan|schoonover)"
      # custom index highlights ----------------------------------------------
      # messages which mention my name in the body
      #color index         yellow          default         "~b \"phil(_g|\!| gregory| gold)|pgregory\" !~N !~T !~F !~p !~P"
      #color index         J_cream         brightblack     "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~N !~T !~F !~p !~P"
      #color index         yellow          cyan            "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~T !~F !~p !~P"
      #color index         yellow          J_magent        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~F !~p !~P"
      ## messages which are in reference to my mails
      #color index         J_magent        default         "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" !~N !~T !~F !~p !~P"
      #color index         J_magent        brightblack     "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~N !~T !~F !~p !~P"
      #color index         J_magent        cyan            "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~T !~F !~p !~P"
      #color index         J_magent        red             "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~F !~p !~P"

      # for background in 16 color terminal, valid background colors include:
      # base03, bg, black, any of the non brights

      # basic colors ---------------------------------------------------------
      color normal        brightblue      default         
      color error         red             default         
      color tilde         white           default         
      color message       cyan            default         
      color markers       red             black           
      color attachment    black           default         
      color search        brightmagenta   default         
      #color status        J_black         J_status        
      color status        brightblue      white           
      color indicator     brightwhite     yellow          
      color tree          yellow          default                                     # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         red             default         "~D(!~p|~p)"               # deleted
      #color index         white           default         ~F                         # flagged
      #color index         brightred       default         ~=                         # duplicate messages
      #color index         brightcyan      default         "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          default         "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         red             default         "~A"                        # all messages
      color index         brightred       default         "~E"                        # expired messages
      color index         blue            default         "~N"                        # new messages
      color index         blue            default         "~O"                        # old messages
      color index         brightmagenta   default         "~Q"                        # messages that have been replied to
      color index         brightcyan      default         "~R"                        # read messages
      color index         blue            default         "~U"                        # unread messages
      color index         blue            default         "~U~$"                      # unread, unreferenced messages
      color index         brightblue      default         "~v"                        # messages part of a collapsed thread
      color index         brightblue      default         "~P"                        # messages from me
      color index         cyan            default         "~p!~F"                     # messages to me
      color index         cyan            default         "~N~p!~F"                   # new messages to me
      color index         cyan            default         "~U~p!~F"                   # unread messages to me
      color index         brightcyan      default         "~R~p!~F"                   # messages to me
      color index         red             default         "~F"                        # flagged messages
      color index         red             default         "~F~p"                      # flagged messages to me
      color index         red             default         "~N~F"                      # new flagged messages
      color index         red             default         "~N~F~p"                    # new flagged messages to me
      color index         red             default         "~U~F~p"                    # new flagged messages to me
      color index         white           red             "~D"                        # deleted messages
      color index         brightgreen     default         "~v~(!~N)"                  # collapsed thread with no unread
      color index         yellow          default         "~v~(~N)"                   # collapsed thread with some unread
      color index         green           default         "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         red             white           "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         yellow          white           "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         green           white           "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         green           white           "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         cyan            white           "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         yellow          red             "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         yellow          default         "~(~N)"                    # messages in threads with some unread
      #color index         green           default         "~S"                       # superseded messages
      #color index         red             default         "~T"                       # tagged messages
      #color index         brightred       red             "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        brightcyan      default         "^"
      color hdrdefault    brightcyan      default         
      color header        brightblue      default         "^(From)"
      color header        blue            default         "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        blue            default         
      color quoted1       cyan            default         
      color quoted2       yellow          default         
      color quoted3       red             default         
      color quoted4       brightred       default         

      color signature     brightcyan      default         
      color bold          white           default         
      color underline     white           default         
      color normal        default         default         
      #
      color body          brightgreen     default         "[;:][-o][)/(|]"    # emoticons
      color body          brightgreen     default         "[;:][)(|]"         # emoticons
      color body          brightgreen     default         "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          brightgreen     default         "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          brightgreen     default         "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          red             default         "(BAD signature)"
      color body          cyan            default         "(Good signature)"
      color body          brightwhite     default         "^gpg: Good signature .*"
      color body          brightblue      default         "^gpg: "
      color body          brightblue      red             "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"

      # yes, an insance URL regex
      color body          red             default         "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      # and a heavy handed email regex
      #color body          J_magent        default         "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

      # Various smilies and the like
      #color body          brightblack     default         "<[Gg]>"                            # <g>
      #color body          brightblack     default         "<[Bb][Gg]>"                        # <bg>
      #color body          yellow          default         " [;:]-*[})>{(<|]"                  # :-) etc...
      # *bold*
      #color body          blue            default         "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      #mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      # _underline_
      #color body          blue            default         "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      #mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      # /italic/  (Sometimes gets directory names)
      #color body         blue            default         "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
      #mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

      # Border lines.
      #color body          blue            default         "( *[-+=#*~_]){6,}"

      #folder-hook .                  "color status        J_black         J_status        "
      #folder-hook gmail/inbox        "color status        J_black         yellow          "
      #folder-hook gmail/important    "color status        J_black         yellow          "
    '';
    ".mutt/solarized/mutt-colors-solarized-light-256.muttrc".text = ''
      # vim: filetype=muttrc

      #
      #
      # make sure that you are using mutt linked against slang, not ncurses, or
      # suffer the consequences of weird color issues. use "mutt -v" to check this.

      # custom body highlights -----------------------------------------------
      # highlight my name and other personally relevant strings
      #color body          color136        color233        "(ethan|schoonover)"
      # custom index highlights ----------------------------------------------
      # messages which mention my name in the body
      #color index         color136        color233        "~b \"phil(_g|\!| gregory| gold)|pgregory\" !~N !~T !~F !~p !~P"
      #color index         J_cream         color233        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~N !~T !~F !~p !~P"
      #color index         color136        color37         "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~T !~F !~p !~P"
      #color index         color136        J_magent        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~F !~p !~P"
      ## messages which are in reference to my mails
      #color index         J_magent        color233        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" !~N !~T !~F !~p !~P"
      #color index         J_magent        color233        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~N !~T !~F !~p !~P"
      #color index         J_magent        color37         "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~T !~F !~p !~P"
      #color index         J_magent        color160        "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~F !~p !~P"

      # for background in 16 color terminal, valid background colors include:
      # base03, bg, black, any of the non brights

      # basic colors ---------------------------------------------------------
      color normal        color244        color233        
      color error         color160        color233        
      color tilde         color254        color233        
      color message       color37         color233        
      color markers       color160        color234        
      color attachment    color234        color233        
      color search        color61         color233        
      #color status        J_black         J_status        
      color status        color244        color254        
      color indicator     color230        color136        
      color tree          color136        color233                                    # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         color160        color233        "~D(!~p|~p)"               # deleted
      #color index         color254        color233        ~F                         # flagged
      #color index         color166        color233        ~=                         # duplicate messages
      #color index         color245        color233        "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          color233        "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         color160        color233        "~A"                        # all messages
      color index         color166        color233        "~E"                        # expired messages
      color index         color33         color233        "~N"                        # new messages
      color index         color33         color233        "~O"                        # old messages
      color index         color61         color233        "~Q"                        # messages that have been replied to
      color index         color245        color233        "~R"                        # read messages
      color index         color33         color233        "~U"                        # unread messages
      color index         color33         color233        "~U~$"                      # unread, unreferenced messages
      color index         color244        color233        "~v"                        # messages part of a collapsed thread
      color index         color244        color233        "~P"                        # messages from me
      color index         color37         color233        "~p!~F"                     # messages to me
      color index         color37         color233        "~N~p!~F"                   # new messages to me
      color index         color37         color233        "~U~p!~F"                   # unread messages to me
      color index         color245        color233        "~R~p!~F"                   # messages to me
      color index         color160        color233        "~F"                        # flagged messages
      color index         color160        color233        "~F~p"                      # flagged messages to me
      color index         color160        color233        "~N~F"                      # new flagged messages
      color index         color160        color233        "~N~F~p"                    # new flagged messages to me
      color index         color160        color233        "~U~F~p"                    # new flagged messages to me
      color index         color254        color160        "~D"                        # deleted messages
      color index         color239        color233        "~v~(!~N)"                  # collapsed thread with no unread
      color index         color136        color233        "~v~(~N)"                   # collapsed thread with some unread
      color index         color64         color233        "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         color160        color254        "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         color136        color254        "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         color64         color254        "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         color64         color254        "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         color37         color254        "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         color136        color160        "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         color136        color233        "~(~N)"                    # messages in threads with some unread
      #color index         color64         color233        "~S"                       # superseded messages
      #color index         color160        color233        "~T"                       # tagged messages
      #color index         color166        color160        "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        color245        color233        "^"
      color hdrdefault    color245        color233        
      color header        color244        color233        "^(From)"
      color header        color33         color233        "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        color33         color233        
      color quoted1       color37         color233        
      color quoted2       color136        color233        
      color quoted3       color160        color233        
      color quoted4       color166        color233        

      color signature     color245        color233        
      color bold          color254        color233        
      color underline     color254        color233        
      color normal        color240        color233        
      #
      color body          color239        color233        "[;:][-o][)/(|]"    # emoticons
      color body          color239        color233        "[;:][)(|]"         # emoticons
      color body          color239        color233        "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          color239        color233        "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          color239        color233        "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          color160        color233        "(BAD signature)"
      color body          color37         color233        "(Good signature)"
      color body          color230        color233        "^gpg: Good signature .*"
      color body          color244        color233        "^gpg: "
      color body          color244        color160        "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"

      # yes, an insance URL regex
      color body          color160        color233        "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      # and a heavy handed email regex
      #color body          J_magent        color233        "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

      # Various smilies and the like
      #color body          color233        color233        "<[Gg]>"                            # <g>
      #color body          color233        color233        "<[Bb][Gg]>"                        # <bg>
      #color body          color136        color233        " [;:]-*[})>{(<|]"                  # :-) etc...
      # *bold*
      #color body          color33         color233        "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      #mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      # _underline_
      #color body          color33         color233        "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      #mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      # /italic/  (Sometimes gets directory names)
      #color body         color33         color233        "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
      #mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

      # Border lines.
      #color body          color33         color233        "( *[-+=#*~_]){6,}"

      #folder-hook .                  "color status        J_black         J_status        "
      #folder-hook gmail/inbox        "color status        J_black         color136        "
      #folder-hook gmail/important    "color status        J_black         color136        "
    '';
    ".mutt/solarized/mutt-colors-solarized-template.muttrc".text = ''
      # vim: filetype=muttrc

      #
      #
      # make sure that you are using mutt linked against slang, not ncurses, or
      # suffer the consequences of weird color issues. use "mutt -v" to check this.

      # custom body highlights -----------------------------------------------
      # highlight my name and other personally relevant strings
      #color body          J_yellow        J_bg            "(ethan|schoonover)"
      # custom index highlights ----------------------------------------------
      # messages which mention my name in the body
      #color index         J_yellow        J_bg            "~b \"phil(_g|\!| gregory| gold)|pgregory\" !~N !~T !~F !~p !~P"
      #color index         J_cream         J_base3         "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~N !~T !~F !~p !~P"
      #color index         J_yellow        J_cyan          "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~T !~F !~p !~P"
      #color index         J_yellow        J_magent        "~b \"phil(_g|\!| gregory| gold)|pgregory\" ~F !~p !~P"
      ## messages which are in reference to my mails
      #color index         J_magent        J_bg            "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" !~N !~T !~F !~p !~P"
      #color index         J_magent        J_base3         "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~N !~T !~F !~p !~P"
      #color index         J_magent        J_cyan          "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~T !~F !~p !~P"
      #color index         J_magent        J_red           "~x \"(mithrandir|aragorn)\\.aperiodic\\.net|thorin\\.hillmgt\\.com\" ~F !~p !~P"

      # for background in 16 color terminal, valid background colors include:
      # base03, bg, black, any of the non brights

      # basic colors ---------------------------------------------------------
      color normal        J_base00        J_bg            
      color error         J_red           J_bg            
      color tilde         J_base02        J_bg            
      color message       J_cyan          J_bg            
      color markers       J_red           J_base2         
      color attachment    J_base2         J_bg            
      color search        J_violet        J_bg            
      #color status        J_black         J_status        
      color status        J_statusfg      J_statusbg      
      color indicator     J_base03        J_yellow        
      color tree          J_yellow        J_bg                                        # arrow in threads

      # basic monocolor screen
      mono  bold          bold
      mono  underline     underline
      mono  indicator     reverse
      mono  error         bold

      # index ----------------------------------------------------------------

      #color index         J_red           J_bg            "~D(!~p|~p)"               # deleted
      #color index         J_base02        J_bg            ~F                         # flagged
      #color index         J_orange        J_bg            ~=                         # duplicate messages
      #color index         J_base01        J_bg            "~A!~N!~T!~p!~Q!~F!~D!~P"  # the rest
      #color index         J_base          J_bg            "~A~N!~T!~p!~Q!~F!~D"      # the rest, new
      color index         J_red           J_bg            "~A"                        # all messages
      color index         J_orange        J_bg            "~E"                        # expired messages
      color index         J_blue          J_bg            "~N"                        # new messages
      color index         J_blue          J_bg            "~O"                        # old messages
      color index         J_violet        J_bg            "~Q"                        # messages that have been replied to
      color index         J_base01        J_bg            "~R"                        # read messages
      color index         J_blue          J_bg            "~U"                        # unread messages
      color index         J_blue          J_bg            "~U~$"                      # unread, unreferenced messages
      color index         J_base00        J_bg            "~v"                        # messages part of a collapsed thread
      color index         J_base00        J_bg            "~P"                        # messages from me
      color index         J_cyan          J_bg            "~p!~F"                     # messages to me
      color index         J_cyan          J_bg            "~N~p!~F"                   # new messages to me
      color index         J_cyan          J_bg            "~U~p!~F"                   # unread messages to me
      color index         J_base01        J_bg            "~R~p!~F"                   # messages to me
      color index         J_red           J_bg            "~F"                        # flagged messages
      color index         J_red           J_bg            "~F~p"                      # flagged messages to me
      color index         J_red           J_bg            "~N~F"                      # new flagged messages
      color index         J_red           J_bg            "~N~F~p"                    # new flagged messages to me
      color index         J_red           J_bg            "~U~F~p"                    # new flagged messages to me
      color index         J_base02        J_red           "~D"                        # deleted messages
      color index         J_base1         J_bg            "~v~(!~N)"                  # collapsed thread with no unread
      color index         J_yellow        J_bg            "~v~(~N)"                   # collapsed thread with some unread
      color index         J_green         J_bg            "~N~v~(~N)"                 # collapsed thread with unread parent
      # statusbg used to indicated flagged when foreground color shows other status
      # for collapsed thread
      color index         J_red           J_statusbg      "~v~(~F)!~N"                # collapsed thread with flagged, no unread
      color index         J_yellow        J_statusbg      "~v~(~F~N)"                 # collapsed thread with some unread & flagged
      color index         J_green         J_statusbg      "~N~v~(~F~N)"               # collapsed thread with unread parent & flagged
      color index         J_green         J_statusbg      "~N~v~(~F)"                 # collapsed thread with unread parent, no unread inside, but some flagged
      color index         J_cyan          J_statusbg      "~v~(~p)"                   # collapsed thread with unread parent, no unread inside, some to me directly
      color index         J_yellow        J_red           "~v~(~D)"                   # thread with deleted (doesn't differentiate between all or partial)
      #color index         J_yellow        J_bg            "~(~N)"                    # messages in threads with some unread
      #color index         J_green         J_bg            "~S"                       # superseded messages
      #color index         J_red           J_bg            "~T"                       # tagged messages
      #color index         J_orange        J_red           "~="                       # duplicated messages

      # message headers ------------------------------------------------------

      #color header        J_base01        J_bg            "^"
      color hdrdefault    J_base01        J_bg            
      color header        J_base00        J_bg            "^(From)"
      color header        J_blue          J_bg            "^(Subject)"

      # body -----------------------------------------------------------------

      color quoted        J_blue          J_bg            
      color quoted1       J_cyan          J_bg            
      color quoted2       J_yellow        J_bg            
      color quoted3       J_red           J_bg            
      color quoted4       J_orange        J_bg            

      color signature     J_base01        J_bg            
      color bold          J_base02        J_bg            
      color underline     J_base02        J_bg            
      color normal        J_fg            J_bg            
      #
      color body          J_base1         J_bg            "[;:][-o][)/(|]"    # emoticons
      color body          J_base1         J_bg            "[;:][)(|]"         # emoticons
      color body          J_base1         J_bg            "[*]?((N)?ACK|CU|LOL|SCNR|BRB|BTW|CWYL|\
                                                           |FWIW|vbg|GD&R|HTH|HTHBE|IMHO|IMNSHO|\
                                                           |IRL|RTFM|ROTFL|ROFL|YMMV)[*]?"
      color body          J_base1         J_bg            "[ ][*][^*]*[*][ ]?" # more emoticon?
      color body          J_base1         J_bg            "[ ]?[*][^*]*[*][ ]" # more emoticon?

      ## pgp

      color body          J_red           J_bg            "(BAD signature)"
      color body          J_cyan          J_bg            "(Good signature)"
      color body          J_base03        J_bg            "^gpg: Good signature .*"
      color body          J_base00        J_bg            "^gpg: "
      color body          J_base00        J_red           "^gpg: BAD signature from.*"
      mono  body          bold                            "^gpg: Good signature"
      mono  body          bold                            "^gpg: BAD signature from.*"

      # yes, an insance URL regex
      color body          J_red           J_bg            "([a-z][a-z0-9+-]*://(((([a-z0-9_.!~*'();:&=+$,-]|%[0-9a-f][0-9a-f])*@)?((([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(:[0-9]+)?)|([a-z0-9_.!~*'()$,;:@&=+-]|%[0-9a-f][0-9a-f])+)(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*(/([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*(;([a-z0-9_.!~*'():@&=+$,-]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?(#([a-z0-9_.!~*'();/?:@&=+$,-]|%[0-9a-f][0-9a-f])*)?|(www|ftp)\\.(([a-z0-9]([a-z0-9-]*[a-z0-9])?)\\.)*([a-z]([a-z0-9-]*[a-z0-9])?)\\.?(:[0-9]+)?(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*(/([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*(;([-a-z0-9_.!~*'():@&=+$,]|%[0-9a-f][0-9a-f])*)*)*)?(\\?([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?(#([-a-z0-9_.!~*'();/?:@&=+$,]|%[0-9a-f][0-9a-f])*)?)[^].,:;!)? \t\r\n<>\"]"
      # and a heavy handed email regex
      #color body          J_magent        J_bg            "((@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]),)*@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\.[0-9]?[0-9]?[0-9]\\]):)?[0-9a-z_.+%$-]+@(([0-9a-z-]+\\.)*[0-9a-z-]+\\.?|#[0-9]+|\\[[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\.[0-2]?[0-9]?[0-9]\\])"

      # Various smilies and the like
      #color body          J_base3         J_bg            "<[Gg]>"                            # <g>
      #color body          J_base3         J_bg            "<[Bb][Gg]>"                        # <bg>
      #color body          J_yellow        J_bg            " [;:]-*[})>{(<|]"                  # :-) etc...
      # *bold*
      #color body          J_blue          J_bg            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      #mono  body          bold                            "(^|[[:space:][:punct:]])\\*[^*]+\\*([[:space:][:punct:]]|$)"
      # _underline_
      #color body          J_blue          J_bg            "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      #mono  body          underline                       "(^|[[:space:][:punct:]])_[^_]+_([[:space:][:punct:]]|$)"
      # /italic/  (Sometimes gets directory names)
      #color body         J_blue          J_bg            "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"
      #mono body          underline                       "(^|[[:space:][:punct:]])/[^/]+/([[:space:][:punct:]]|$)"

      # Border lines.
      #color body          J_blue          J_bg            "( *[-+=#*~_]){6,}"

      #folder-hook .                  "color status        J_black         J_status        "
      #folder-hook gmail/inbox        "color status        J_black         J_yellow        "
      #folder-hook gmail/important    "color status        J_black         J_yellow        "
    '';
    ".mutt/solarized/mutt-compile-colors.sh".text = ''
      #!/usr/bin/env bash
      # ---------------------------------------------------------------------
      # SOLARIZED color values
      # ---------------------------------------------------------------------
      # Download palettes and files from: http://ethanschoonover.com/solarized
      # 
      # SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      RGB         HSB
      # --------- ------- ---- -------  ----------- ---------- ----------- -----------
      # base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
      # base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
      # base01    #586e75 10/7 brgreen  240 #585858 45 -07 -07  88 110 117 194  25  46
      # base00    #657b83 11/7 bryellow 241 #626262 50 -07 -07 101 123 131 195  23  51
      # base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
      # base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
      # base2     #eee8d5  7/7 white    254 #e4e4e4 92 -00  10 238 232 213  44  11  93
      # base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
      # yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
      # orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
      # red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
      # magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
      # violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
      # blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
      # cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
      # green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

      cat > palette_dark.tmp <<SETPALETTEDARK
      J_base03        ,color234        ,brightblack     ,
      J_base02        ,color235        ,black           ,
      J_base01        ,color240        ,brightgreen     ,
      J_base00        ,color241        ,brightyellow    ,
      J_base0         ,color244        ,brightblue      ,
      J_base1         ,color245        ,brightcyan      ,
      J_base2         ,color254        ,white           ,
      J_base3         ,color230        ,brightwhite     ,
      J_yellow        ,color136        ,yellow          ,
      J_orange        ,color166        ,brightred       ,
      J_red           ,color160        ,red             ,
      J_magenta       ,color125        ,magenta         ,
      J_violet        ,color61         ,brightmagenta   ,
      J_blue          ,color33         ,blue            ,
      J_cyan          ,color37         ,cyan            ,
      J_green         ,color64         ,green           ,
      J_bg            ,color234        ,default         ,
      J_fg            ,color244        ,default         ,
      J_statusfg      ,color241        ,brightyellow    ,
      J_statusbg      ,color235        ,black           ,
      SETPALETTEDARK
      cat > palette_light.tmp <<SETPALETTELIGHT
      J_base3         ,color233        ,brightblack     ,
      J_base2         ,color234        ,black           ,
      J_base1         ,color239        ,brightgreen     ,
      J_base0         ,color240        ,brightyellow    ,
      J_base00        ,color244        ,brightblue      ,
      J_base01        ,color245        ,brightcyan      ,
      J_base02        ,color254        ,white           ,
      J_base03        ,color230        ,brightwhite     ,
      J_yellow        ,color136        ,yellow          ,
      J_orange        ,color166        ,brightred       ,
      J_red           ,color160        ,red             ,
      J_magenta       ,color125        ,magenta         ,
      J_violet        ,color61         ,brightmagenta   ,
      J_blue          ,color33         ,blue            ,
      J_cyan          ,color37         ,cyan            ,
      J_green         ,color64         ,green           ,
      J_bg            ,color233        ,default         ,
      J_fg            ,color240        ,default         ,
      J_statusfg      ,color244        ,brightblue      ,
      J_statusbg      ,color254        ,white           ,
      SETPALETTELIGHT

      MUTTSOURCE="mutt-colors-solarized-template.muttrc"
      MUTTTARGET="mutt-colors-solarized"
      MUTTSUFFIX=".muttrc"
      rm "$MUTTTARGET-dark-256$MUTTSUFFIX"
      rm "$MUTTTARGET-dark-16$MUTTSUFFIX"
      rm "$MUTTTARGET-light-256$MUTTSUFFIX"
      rm "$MUTTTARGET-light-16$MUTTSUFFIX"

      awk 'NR==FNR {a[$1]=$2;next} {for ( i in a) gsub(i,a[i])}1' FS="," \
          palette_dark.tmp $MUTTSOURCE > "$MUTTTARGET-dark-256$MUTTSUFFIX"
      awk 'NR==FNR {a[$1]=$3;next} {for ( i in a) gsub(i,a[i])}1' FS="," \
          palette_dark.tmp $MUTTSOURCE > "$MUTTTARGET-dark-16$MUTTSUFFIX"
      awk 'NR==FNR {a[$1]=$2;next} {for ( i in a) gsub(i,a[i])}1' FS="," \
          palette_light.tmp $MUTTSOURCE > "$MUTTTARGET-light-256$MUTTSUFFIX"
      awk 'NR==FNR {a[$1]=$3;next} {for ( i in a) gsub(i,a[i])}1' FS="," \
          palette_light.tmp $MUTTSOURCE > "$MUTTTARGET-light-16$MUTTSUFFIX"

      rm palette_light.tmp
      rm palette_dark.tmp
    '';
    ".mutt/solarized/README.md".text = ''
      Solarized Colorscheme for Mutt
      ==============================

      Developed by Ethan Schoonover <es@ethanschoonover.com>

      See the [homepage for the Solarized colorscheme][solarized] for versions for 
      Vim, popular terminal emulators and other applications.

      If you have come across this colorscheme via the [mutt-only repository on 
      github][mutt-solarized-github], see the link above to the Solarized homepage or
      visit the [github repository for Solarized][solarized-github].

      [solarized]: http://ethanschoonover.com/solarized
      [solarized-github]: https://github.com/altercation/solarized
      [mutt-solarized-github]: https://github.com/altercation/mutt-colors-solarized

      Installation
      ------------

      1. Move the mutt-colors-solarized directory into the same location as your 
         muttrc. Alternately, you can copy just the version of the colorscheme you 
         will be using (see below for details).

      2. Source the colorscheme in your muttrc. Only one of the following, depending 
         on the light or dark background you wish to use, and whether you want to use 
         the native 16 colors of your terminal emulator or the approximatation 
         provided by the 256 color values. See note below for recommendations.

          source $MAILCONF/mutt-colors-solarized/mutt-colors-solarized-dark-16.muttrc
          source $MAILCONF/mutt-colors-solarized/mutt-colors-solarized-light-16.muttrc
          source $MAILCONF/mutt-colors-solarized/mutt-colors-solarized-dark-256.muttrc
          source $MAILCONF/mutt-colors-solarized/mutt-colors-solarized-light-256.muttrc

      Note: You can safely ignore the compile colors script and the template file.  
      They are used only for creating the actual colorscheme files. If you want to 
      modify the colorscheme or colors, you can use the compile script and template 
      to do so.

      Which Variation?
      ----------------

      See the [Solarized homepage][solarized] for screenshots which will help you 
      select either the light or dark background.

      A thornier question is whether to use the 16 color version or the 256 color 
      version. I have spent a great deal of time refining this colorscheme and for 
      the most accurate experience I recommend that you set your terminal emulator to 
      use the Solarized colorvalues with the 16 color mutt colorschemes in this 
      distribution. Terminal colorschemes/values are available at the homepage linked 
      to above.

      The 256 color versions provide an approximate experience of the colorscheme in 
      most regards, though the carefully selected monotones are crudely replaced by 
      neutral tones.

      The Values
      ----------

      L\*a\*b values are canonical (White D65, Reference D50), other values are 
      matched in sRGB space.

          SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
          --------- ------- ---- -------  ----------- ---------- ----------- -----------
          base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
          base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
          base01    #586e75 10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46
          base00    #657b83 11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51
          base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
          base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
          base2     #eee8d5  7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93
          base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
          yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
          orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
          red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
          magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
          violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
          blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
          cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
          green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

      License
      -------
      Copyright (c) 2011 Ethan Schoonover

      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:

      The above copyright notice and this permission notice shall be included in
      all copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
      THE SOFTWARE.
    '';
  };
}
