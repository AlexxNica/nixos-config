# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ]; #/imports


##############
#### BOOT ####
##############

  # Use the systemd-boot EFI boot loader.
  boot = {
    cleanTmpDir = true;
    vesa = true;
    enableContainers = true;
    kernelPackages = pkgs.linuxPackages_testing;
    initrd.availableKernelModules = [
      "ext4"
    ];
    #|failed|extraModulePackages = [
    #|failed|  pkgs.linuxPackages_testing.splUnstable
    #|failed|  pkgs.linuxPackages_testing.zfsUnstable
    #|failed|];
    #|BUG1|kernelPatches = [
    #|BUG1|  pkgs.kernelPatches.grsecurity_testing
    #|BUG1|];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
     }; #/loader
  }; #/boot


####################
#### NETWORKING ####
####################

  networking = {
    hostName = "alexxnica-nixos"; # Define your hostname.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    #wireguard.enable = true;
  };

##########################
#### POWER MANAGEMENT ####
##########################

  powerManagement.enable = true;

  
##############
#### i18n ####
##############

  i18n = {
    consoleFont = "Lat2-Terminus16";
    #consoleKeyMap = "us";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";

    #inputMethod = {
    #  enabled = "ibus";
    #};
  }; #/i18n


##############
#### TIME ####
##############

  # TimeZone
  time.timeZone = "America/Sao_Paulo";


##################
#### PACKAGES ####
##################

  nixpkgs.config = {
    allowUnfree = true;
    #neoload.accept_license = true;

    permittedInsecurePackages = [
      "webkitgtk-2.4.11"
      "libplist-1.12"
    ];

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
      #enableWideVine = true;
      enableHotwording = false;
      proprietaryCodecs = true;
      gnomeSupport = true;
      pulseSupport = true;
      cupsSupport = true;
      defaultSearchProviderSearchURL = "https://encrypted.google.com/search?q={searchTerms}&{google:RLZ}{google:originalQueryForSuggestion}{google:assistedQueryStats}{google:searchFieldtrialParameter}{google:
        ↪searchClient}{google:sourceId}{google:instantExtendedEnabledParameter}ie={inputEncoding}";
      defaultSearchProviderSuggestURL = "https://encrypted.google.com/complete/search?output=chrome&q={searchTerms}";
      extensions = [
        "gcbommkclmclpchllfjekcdonpmejbdp" # HTTPS Everywhere
      ]; #/extensions
    }; #/chromium

    firefox = {
      enableGoogleTalkPlugin = true;
      #enableAdobeFlash = true;
      #enableAdobeReader = true;
      #enableAdobeFlashDRM = true;
      enableGnomeExtensions = true;
      enableGeckoMediaPlayer = true;
      #enableMPlayer = true;
      enableVLC = true;
      ffmpegSupport = true;
    };

    #packageOverrides = pkgs: {
    #  clooj = pkgs.clooj // {
    #    clooj = pkgs.lib.overrideDerivation pkgs.clooj (a:{
    #      name = a.name + "-0.4.4-standalone";
    #      jar = {
    #        url = "http://download1492.mediafire.com/4710l05oz6tg/prkf64humftrmz3/clooj-0.4.4-standalone.jar";
    #        sha256 = "cd6eb546fc63fae83437e0ac6cd70432ad76e0917ba6ae47cd0629f156126c41";
    #      }; #/jar
    #    }); #/clooj
    #  }; #/clooj
    #}; #/packageOverrides

  }; #/nixpkgs.config


#####################
#### ENVIRONMENT ####
#####################

  environment = {
    #interactiveShellInit = "${pkgs.gnome3.vte}/etc/profile.d/vte.sh";
    enableDebugInfo = true;

    shells = [
      "${pkgs.bash}/bin/bash"
      "${pkgs.zsh}/bin/zsh"
    ]; #/shells

    variables = {
      BROWSER = pkgs.lib.mkOverride 0 "chromium";
      EDITOR = pkgs.lib.mkOverride 0 "vim";
    }; #/variables

    systemPackages = with pkgs; [

      ## Warning - New - Unstable - Testing [2] ##
      mkpasswd
      inetutils
      hyperterm
      pbzip2
      ## /Warning ##
      ## Warning - New - Unstable - Testing ##
      docker-proxy
      docker-machine
      docker-machine-kvm
      docker-distribution
      docker-edge
      wordnet
      taskwarrior
      rtv
      mpvc
      jekyll
      hugo
      hyper
      nmap-graphical
      haxor-news
      googleearth
      gammu
      tortoisehg
      freerdpUnstable
      bazaar
      bazaarTools
      gitAndTools.hub
      gitkraken
      isyncUnstable
      botanUnstable
      xcb-util-cursor-HEAD
      swc # @TODO: CONFIGURE
      wlc # @TODO: CONFIGURE #wlc.sway?
      sway # @TODO: CONFIGURE
      #|failed|xkbcomp
      xkeyboard_config
      #|undefined|xorgserver
      #|attribute_missing|xorg.xwayland
      xorg.libFS
      xorg.kbproto
      xorg.inputproto
      xorg.imake
      xorg.libX11
      xorg.libXcomposite
      xorg.libXrandr
      xorg.libXrender
      #|attribute_missing|xorg.libXrandrUtils
      xorg.libXres
      xorg.libpciaccess
      xorg.libpthreadstubs
      xorg.libxcb
      xorg.libxkbfile
      xorg.makedepend
      xorg.setxkbmap
      xorg.xcbutil
      xorg.xcbproto
      xorg.xdm
      xorg.xinit
      xorg.xinput
      xorg.xkbevd
      xorg.xkbprint
      xorg.xkbutils
      xorg.xkeyboardconfig
      xorg.xrdb
      xorg.xset
      ## /Warning ##

      ## Build Support ##
      #|coerce_set_to_string|autoreconfHook
      #|COERCE_1|ensureNewerSourcesHook
      #|COERCE_1|updateAutotoolsGnuConfigScriptsHook
      #|COERCE_1|buildEnv
      #|undefined|BuildFHSUserEnv
      #|COERCE_1|buildMaven
      cmark
      #|COERCE_1|dhallToNix
      #dockerTools
      docker_compose
      #|COERCE_1|dotnetenv
      #|COERCE_1|dotnetbuildhelpers
      #|COERCE_1|vsenv
      #|COERCE_1|fetchadc
      #|COERCE_1|fetchbower
      #|COERCE_1|fetchbzr
      #|COERCE_1|fetchcvs
      #|COERCE_1|fetchdarcs
      #|COERCE_1|fetchfossil
      #|COERCE_1|fetchgit
      #|COERCE_1|fetchgitPrivate
      #|COERCE_1|fetchgitrevision
      #|COERCE_1|fetchgitLocal
      #|COERCE_1|fetchmtn
      #|COERCE_1|fetchMavenArtifact
      packer
      #|COERCE_1|fetchpatch
      #|undefined|fetchs3
      #|COERCE_1|fetchsvn
      #|COERCE_1|fetchsvnssh
      #|COERCE_1|fetchhg
      #fetchurl
      #|COERCE_1|fetchRepoProject
      #|COERCE_1|fetchurlBoot
      #fetchFromGitHub
      #|COERCE_1|fetchNuGet
      #|COERCE_1|buildDotnetPackage
      #|COERCE_1|fetchgx
      libredirect
      #makeDesktopItem
      #makeAutostartItem
      #makeInitrd
      makeWrapper
      #makeModulesClosure
      #|COERCE_1|pathsFromGraph
      #setupSystemdUnits
      #singularity-tools
      #|COERCE_1|removeReferencesTo
      #vmTools
      #releaseTools
      #|COERCE_1|composableDerivation
      #|COERCE_1|keepBuildTree
      enableGCOVInstrumentation
      makeGCOVReport
      findXMLCatalogs
      wrapGAppsHook
      #|COERCE_1|separateDebugInfo
      iconConvTools

      ## Nix Developer Tools ##
      nix-generate-from-cpan
      #nixpkgs-lint # Already called below
      common-updater-scripts

      ## Version & Revision Control System ##
      git
      git-lfs
      github-release
      #git-radar
      #gitAndTools.gitflow
      rcs

      ## Security ##
      gnupg
      gnutls
      gnutls-kdh
      monkeysphere
      openpts
      openxpki
      pax-utils

      ## Penetration Testing ##
      burpsuite

      # Reverse-Engineering
      icestorm

      ## CryptoCurency / Bitcoin ##
      #vanitygen
      #altcoins.bitcoin
      #altcoins.bitcoin-classic
      #altcoins.bitcoin-xt
      #altcoins.bitcoind
      #altcoins.bitcoind-classic
      #altcoins.bitcoind-xt
      #altcoins.ethabi
      #altcoins.ethrun
      #altcoins.go-ethereum

      ## Ethereum ##
      cpp_ethereum
      serpent
      solc

      ## Apps ##
      #dropbox
      #dropbox-cli
      wine
      wineFull
      #wineMinimal
      #wineStable
      wineUnstable
      #wineStaging
      calligra
      zathura
      aegisub


      ## Media (Image & Video Processing) ##
      #@TODO: divide apps from libraries
      mpv
      gnome-mpv
      mplayer
      vlc
      obs-studio
      qtpfsgui
      ffmpeg
      ffmpeg-full
      ffmpeg-sixel
      ffmpegthumbnailer
      ffms
      libav
      libmpeg2
      libmkv
      openh264
      libjpeg
      libmediainfo
      mediainfo
      mediainfo-gui
      mediastreamer
      mediastreamer-openh264
      libmatroska
      mjpegtools
      mjpegtoolsFull
      movit
      mp4v2
      mozjpeg
      openjpeg
      puredata
      libv4l
      v4l_utils
      x264
      x265
      xvidcore
      faad2
      libdv
      libmad
      mpg123
      graphicsmagick
      mp3val
      imlib2
      #imlib2-nox
      speex
      speexdsp
      libpulseaudio
      flac
      mp3gain
      potrace
      xgboost
      mjpg-streamer
      mkvtoolnix
      gstreamer
      #|coerce_set_to_string|gst_all
      gst-plugins-base
      gst-plugins-good
      gst-plugins-ugly
      gst-ffmpeg
      gst-python
      gstreamermm
      bomi

      ## Browsers ##
      chromium
      #chromiumBeta
      #chromiumDev
      google-chrome
      google-chrome-beta
      google-chrome-dev
      firefox
      firefox-unwrapped
      firefox-beta-bin
      firefox-esr
      firefox-esr-unwrapped
      #firefox-trunk
      torbrowser
      opera
      vivaldi
      w3m
      w3m-full
      epiphany
      vimb
      #vimb-unwrapped
      vimprobable2
      #vimprobable2-unwrapped
      qutebrowser
      palemoon
      conkeror
      #conkeror-unwrapped

      ## FTP/FTPS/SFTP ##
      filezilla

      ## Backups ##
      backup
      obnam
      bup
      partclone
      rsnapshot
      snapper

      ## P2P / Torrent ##
      transmission
      transmission_gtk
      transmission_remote_gtk
      gnunet
      gnunet_svn
      rtorrent
      mldonkey

      ## Design ##
      inkscape

      ## Hardware Graphics & Rendering (e.g. OpenGL / OpenCL / 3D) ##
      cairo
      cairomm
      libva-full
      #|er|libva-x11
      directfb
      clutter
      clutter-gst
      #spirv-headers
      spirv-tools
      vulkan-loader
      vogl
      opencl-clhpp
      opencl-headers
      opencl-info
      freeglut
      virtualglLib
      glfw
      cogl
      glui
      mesa
      mesa_drivers
      mesa_glu
      libvdpau
      quesoglc
      xorg_sys_opengl
      libpgf
      libsixel
      libxmi
      openscenegraph
      pgf_graphics
      Xaw3d
      SDL
      SDL2
      SDL2_gfx
      SDL2_image
      SDL2_mixer
      SDL2_net
      SDL2_ttf
      SDL_gfx
      SDL_image
      SDL_mixer
      SDL_net
      SDL_sixel
      SDL_sound
      SDL_stretch
      SDL_ttf
      sfml
      vtk
      vtkWithQt4
      libtiger
      pangoxsl
      pbrt
      plib
      poppler
      poppler_gi
      poppler_data
      poppler_utils
      libsForQt5.poppler
      gnome3.gtk
      elementary-icon-theme
      wxGTK
      radeontop
      #radeontools
      #radeon-profile

      # Qt
      qt5Full
      #qtwebkit-plugins
      qtkeychain
      qtscriptgenerator
      #qtstyleplugins

      ## Window/Display Manager ##
      wayland
      wayland-protocols
      weston
      libsForQt5.kwayland
      kwayland-integration
      orbment
      st-wayland
      dmenu-wayland
      swc
      wld
      xwayland

      ## Text Editor ##
      sublime3
      brackets
      bluefish
      emacs
      #emacs25-nox
      fte
      gnome3.gedit
      kakoune
      lighttable
      notepadqq
      nano
      neovim
      nvi
      #qtikz
      qvim
      scite
      textadept
      vimPlugins.editorconfig-vim
      vis
      zed
      manuskript
      readline
      texmacs
      zile
      elvis
      qscintilla
      libsForQt5.qscintilla

      ## Vim ##
      vim
      vimHugeX
      vimNox
      vimPlugins.editorconfig-vim
      vimPlugins.pluginnames2nix
      vimPlugins.auto-pairs
      vimPlugins.alchemist-vim
      vimPlugins.calendar
      vimPlugins.CheckAttach
      vimPlugins.clang_complete
      vimPlugins.clighter8
      vimPlugins.command-t
      vimPlugins.commentary
      vimPlugins.deoplete-go
      vimPlugins.deoplete-jedi
      vimPlugins.deoplete-nvim
      vimPlugins.elm-vim
      vimPlugins.floobits-neovim
      vimPlugins.ghc-mod-vim
      vimPlugins.Gist
      vimPlugins.haskell-vim
      vimPlugins.Hoogle
      vimPlugins.idris-vim
      vimPlugins.latex-box
      vimPlugins.lightline-vim
      vimPlugins.limelight-vim
      vimPlugins.lushtags
      vimPlugins.molokai
      #vimPlugins.neco-gh
      vimPlugins.neco-vim
      vimPlugins.neocomplete
      vimPlugins.neoformat
      vimPlugins.neomake
      vimPlugins.neosnippet-snippets
      vimPlugins.neosnippet
      vimPlugins.purescript-vim
      vimPlugins.python-mode
      vimPlugins.rust-vim
      vimPlugins.sensible
      vimPlugins.Solarized
      vimPlugins.Spacegray-vim
      vimPlugins.spacevim
      vimPlugins.tslime
      vimPlugins.typescript-vim
      vimPlugins.UltiSnips
      vimPlugins.vim
      vimPlugins.vim-addon-actions
      vimPlugins.vim-addon-async
      vimPlugins.vim-addon-background-cmd
      vimPlugins.vim-addon-commenting
      vimPlugins.vim-addon-completion
      vimPlugins.vim-addon-errorformats
      vimPlugins.vim-addon-goto-thing-at-cursor
      vimPlugins.vim-addon-local-vimrc
      vimPlugins.vim-addon-manager
      vimPlugins.vim-addon-mru
      vimPlugins.vim-addon-mw-utils
      vimPlugins.vim-addon-nix
      vimPlugins.vim-addon-sql
      vimPlugins.airline
      vimPlugins.vim-airline-themes
      vimPlugins.vim-auto-save
      vimPlugins.vim-autoformat
      vimPlugins.vim-buffergator
      vimPlugins.vim-closetag
      vimPlugins.coffee-script
      vimPlugins.vim-colorschemes
      vimPlugins.vim-colorstepper
      vimPlugins.css_color_5056
      vimPlugins.vim-dispatch
      vimPlugins.easy-align
      vimPlugins.easymotion
      vimPlugins.vim-easytags
      vimPlugins.vim-elixir
      vimPlugins.gitgutter
      vimPlugins.vim-go
      vimPlugins.vim-grammarous
      vimPlugins.vim-hardtime
      vimPlugins.haskellConceal
      vimPlugins.haskellConcealPlus
      vimPlugins.vim-iced-coffee-script
      vimPlugins.vim-indent-guides
      vimPlugins.vim-indent-object
      vimPlugins.ipython
      vimPlugins.vim-jade
      vimPlugins.vim-jinja
      vimPlugins.vim-jsdoc
      vimPlugins.vim-jsonnet
      vimPlugins.latex-live-preview
      vimPlugins.vim-leader-guide
      vimPlugins.vim-localvimrc
      vimPlugins.vim-markdown
      vimPlugins.vim-misc
      vimPlugins.vim-nix
      vimPlugins.vim-orgmode
      vimPlugins.vim-pandoc
      vimPlugins.vim-pandoc-after
      vimPlugins.vim-pandoc-syntax
      vimPlugins.vim-peekaboo
      vimPlugins.polyglot
      vimPlugins.quickrun
      vimPlugins.vim-racer
      vimPlugins.vim-scala
      vimPlugins.signature
      vimPlugins.vim-signify
      vimPlugins.vim-snippets
      vimPlugins.vim-sort-motion
      vimPlugins.vim-speeddating
      vimPlugins.vim-startify
      vimPlugins.stylish-haskell
      vimPlugins.tmux-navigator
      vimPlugins.vim-wakatime
      vimPlugins.vim-watchdogs
      vimPlugins.vim-webdevicons
      vimPlugins.vim-xkbswitch
      vimPlugins.vim-addon-vim2nix
      vimPlugins.VimOutliner
      vimPlugins.vimpreviewpandoc
      vimPlugins.vimproc
      vimPlugins.vimshell
      vimPlugins.vimtex
      vimPlugins.vimwiki
      vimPlugins.vinegar
      vimPlugins.vundle
      vimPlugins.WebAPI
      vimPlugins.YouCompleteMe
      kgocode

      ## IDEs ##
      #|666|qtcreator
      #|666|geany
      #|666|clooj
      #|666|codeblocks
      codeblocksFull
      eclipses.eclipse-cpp-37
      eclipses.eclipse-cpp
      eclipses.eclipse-scala-sdk
      idea.idea-community
      idea.pycharm-community
      lazarus
      processing

      ## PDFs ##
      impressive

      ## Rust ##
      #rust
      #|coerce_set_to_string|rustNightly
      #|coerce_set_to_string|rustNightlyBin
      #rustc
      #rustBeta.rustc
      rustNightly.rustc
      rustracer
      rustracerd
      rustfmt
      #rustBeta.cargo
      rustNightly.cargo
      #ranicorn
      rust-bindgen
      rustPlatform.rustRegistry
      #|er|rustup

      ## Password ##
      gpg-mdp
      pass
      lastpass-cli

      ## Disk ##
      gparted
      parted
      #freefall # Free-fall protection for spinning HP/Dell Laptop HDs
      gptfdisk
      dosfstools
      e2fsprogs
      e2tools
      f2fs-tools


      ## File System, Formats & Management ##
      ori
      fuse
      fuse-7z-ng
      fuseiso
      sshfs-fuse
      gnome3.gvfs
      gvfs
      avfs
      davfs2
      davix
      libdevil
      libdevil-nox
      libgsf
      ifuse
      mtdutils
      nfs-utils
      stow
      libsysfs
      tmsu
      xcruiser
      #lizardfs
      #bindfs
      #aefs
      #tahoelafs
      #xtreemfs
      #yadm
      #zsync
      zfsUnstable
      zfstools
      splUnstable

      ## Generators / Creators / Images ##
      genimage


      ## File Archivers / Compressors ##
      gnutar
      xar
      commonsCompress
      zip

      ## Plan 9 / 9P ##
      _9pfs
      #u9ps
      diod
      libixp_hg
      plan9port

      ## Mobile ##
      libimobiledevice

      ## Maps / GPS ##
      josm
      merkaartor
      viking
      gpsbabel
      gpsd

      ## Research / Science ##
      mendeley
      avogadro
      sigil
      gpac
      grass
      #|er|scilib
      #|er|scilib-bin
      golly-beta
      gdal

      ## Graphs ##
      libmng
      neo4j

      ## LaTeX / TeX / BibTex ##
      texmaker
      texstudio
      pygmentex
      git-latexdiff
      hevea
      lyx
      biber
      rubber
      untex
      texlive.combined.scheme-basic
      texlive.combined.scheme-context
      texlive.combined.scheme-full
      texlive.combined.scheme-gust
      texlive.combined.scheme-medium
      texlive.combined.scheme-minimal
      texlive.combined.scheme-small
      texlive.combined.scheme-tetex
      texlive.combined.scheme-xml
      texinfo
      texinfoInteractive
      bibtool
      dblatexFull
      tetex


      ## Markdown ##
      multimarkdown

      ## HEX ##
      bvi
      bviplus
      dhex
      hecate
      heme
      hexcurse
      radare
      radare2
      tweak
      vanubi
      wxhexeditor

      ## Music ##
      despotify
      mopidy
      mopidy-mopify
      mopidy-spotify
      mopidy-spotify-tunigo
      mopidy-musicbox-webclient
      mopidy-soundcloud
      mopidy-gmusic
      mopidy-moped
      mopidy-youtube

      ## Communication ##
      slack
      discord
      libtoxcore
      #coyim
      hipchat
      ricochet
      skype
      teamspeak_client
      #telegram
      tdesktop # Telegram
      #telegram-qml
      #|er|cutegram
      #torchat
      #skypeforlinux
      profanity
      #|er|quaternion
      tensor
      weechat
      linphone
      pond
      viber
      telepathy_gabble
      telepathy_haze
      telepathy_logger
      telepathy_mission_control
      telepathy_salut
      telepathy_idle
      bitlbee
      #|coerce_set_to_string|bitlbee-plugins
      bitlbee-steam

      # Pidgin
      pidgin
      gnome3.pidgin-im-gnome-shell-extension
      pidginlatex
      pidgin-mra
      pidginmsnpecan
      pidgin-opensteamworks
      pidginosd
      pidginotr
      pidginsipe
      pidgin-skypeweb
      pidginwindowmerge
      pidgin-xmpp-receipts
      purple-hangouts
      purple-matrix
      #|er|pidgin-vk-plugin
      telegram-purple
      toxprpl
      purple-facebook
      skype4pidgin

      ## IRC ##
      shout
      wraith
      chatzilla
      communi
      epic5
      hexchat
      ii
      irssi
      irssi_otr
      libircclient
      quassel
      quasselClient
      quasselDaemon
      #|LATER_STUDY|quassel-webserver
      sic
      qweechat
      bip
      konversation


      ## Documents / Slides ##
      odpdown
      lout
      docutils

      ## Crawlers / Extractors ##
      streamlink
      togglesg-download

      ## Artificial Intelligence / Machine/Deep Learning ##
      #|er|caffe
      #|er|loadcaffe
      
      # Torch
      torch
      torch-repl
      neural-style
      torch-hdf5
      torchPackages.torch
      torchPackages.luafilesystem
      torchPackages.lua-cjson
      torchPackages.luarocks
      torchPackages.trepl
      torchPackages.xlua
      torchPackages.cwrap
      torchPackages.dok
      torchPackages.gnuplot
      torchPackages.graph
      torchPackages.image
      torchPackages.lbase64
      torchPackages.luaffifb
      torchPackages.nn
      torchPackages.nngraph
      torchPackages.optim
      torchPackages.paths
      torchPackages.penlight
      torchPackages.sundown
      torchPackages.sys
      torchPackages.unsup

      ## (De)Compilers / Compressors / Parsers / Transpilers / Optimizers ##
      mitscheme
      hammer
      libextractor
      libtheora
      mlton
      swig
      swig1
      swig2
      asn1c
      asn2quickder
      ccache
      ccacheWrapper
      cfr
      distcc
      distccWrapper
      compcert
      gcc
      gcc-unwrapped
      gcc_debug
      gcc_multi
      gccgo
      gnatboot
      gfortran
      ghc
      jhc
      gnat
      gnum4
      hhvm
      lfe
      libstdcxx5
      polyml
      purescript
      ragel
      ragelDev
      sdcc
      shc
      smlnj
      xsd
      yap
      ceres-solver
      yasm
      yosys
      zulu

      ## Data Science ##
      tulip

      ## Nix ##
      bundix
      cabal2nix
      egg2nix
      #|LATER_STUDY|disnix
      #|LATER_STUDY|disnixos
      #|LATER_STUDY|DisnixWebService
      dysnomia
      #nixops
      #|er|nix-bundle
      nix-prefetch-bzr
      nix-prefetch-cvs
      nix-prefetch-git
      nix-prefetch-hg
      nix-prefetch-svn
      nix-prefetch-scripts
      nix-template-rpm
      nix-serve
      nix-exec
      nixos-artwork
      nixopsUnstable
      nixos-container
      nix-repl
      nixpkgs-lint
      npm2nix
      #|er|node2nix
      hex2nix
      python2nix

      ## Converters ##
      mscgen
      transcode
      uni2ascii
      tivodecode
      bibutils
      docbook2x
      dos2unix
      pstoedit
      xcftools
      convmv
      ansifilter
      dot2tex
      unrtf
      gp2c
      bdf2psf
      wkhtmltopdf
      bibtex2html
      dmg2img

      ## Protocols ##
      mod_fastcgi
      gopher
      fcgi
      freeswitch
      protobuf3_2
      protobufc

      ## Terminal / Shell ##
      zsh
      zsh-autosuggestions
      zsh-completions
      nix-zsh-completions
      #zsh-syntax-highlightning
      oh-my-zsh
      vim_configurable
      vim-vint
      ldapvi
      gnome3.vte
      gnome3.vte-ng
      #waka
      srm
      ucspi-tcp
      elvish
      es
      scsh
      autojump
      minio-client
      rmlint
      rush
      mrxvt

      ## LDAP ##
      openldap
      nss_pam_ldapd
      pam_ldap

      ## Searching ##
      idutils
      #cscopes
      duff
      ripgrep
      findutils
      codesearch

      ## DevOps ##
      kanif
      libchop
      scons
      jenkins-job-builder
      pig

      ## System ##
      colord
      #coreutils
      coreutils-prefixed
      kbd
      systemd
      #|coerce_set_to_string|kbdKeymaps
      #|er|kbdLight
      #|er|LinuxConsoleTools


      ## Build Tools ##
      ninja
      meson
      bazel
      omake
      cmake
      gnumake
      automake
      automake114x
      premake
      sbt
      autobuild
      bsdbuild
      redo
      tup

      ## Daemons ##
      daemonize
      daemontools
      openntpd_nixos

      ## Benchmarking ##
      glmark2
      wrk
      bonnie
      dbench
      filebench
      fsmark
      ior
      xfstests

      ## Android ##
      androidsdk
      androidsdk_extras

      ## Command Line Interfaces (CLIs) ##
      bitbucket-cli
      gandi-cli
      trash-cli
      sigrok-cli
      speedtest-cli
      teensy-loader-cli
      mkvtoolnix-cli
      #nvme-cli
      acd-cli
      wireshark-cli
      telegram-cli
      #|er|todo-text-cli
      transmission-remote-cli

      ## Development ##
      ### warning ###
      amdappsdkFull
      dafny
      plm
      ### /warning ###
      cmatrix
      jujuutils
      patchelfUnstable
      pakcs
      pltScheme
      uncrustify
      trousers
      thrust
      ploticus
      coin3d
      kmscube
      #clblas-cuda
      maude
      mcgrid
      mozart
      mustache-spec
      paml
      perseus
      tk

      # Documentation
      doxygen
      doxygen_gui

      # Pharo
      pharo-vm
      #|coerce_set_to_string|pharo-vms
      pharo-vm5
      pharo-launcher

      # JavaScript
      v8
      v8_static
      spidermonkey
      spidermonkey_38
      yarn
      electron
      jsduck
      jscoverage
      phantomjs
      phantomjs2
      slimerjs
      yuicompressor
      minify
      pumpio
      nodejs
      nodejs-slim
      closurecompiler
      eventstore
      flow
      mujs
      netsurf.nsgenbind
      rhino
      jquery
      jquery-ui
      #|coerce_set_to_string|buildBowerComponents
      
      # Haxe
      haxe

      # Go
      go
      #|coerce_set_to_string|buildGoPackage
      #gdm
      delve
      glide
      go2nix
      go-bindata
      go-bindata-assetfs
      glock
      goa
      gocode
      godep
      goimports
      godef
      golint
      gotags
      gotools
      govers
      gox
      manul
      
      # Python
      python
      python2
      python3
      python36
      pypy
      devpi-client
      grabserial
      #jsonxs
      mypy
      pydb
      pypi2nix
      winpdb
      hy
      bedup
      pymol
      #|er|numpy
      #|er|scipy
      #|er|h5py
      #|er|scikitlearn
      #|er|fast-neural-doodle
      #python27Packages
      #python33Packages
      #python34Packages
      #python35Packages
      #python36Packages
      #pypyPackages
      python27Packages.tkinter
      python35Packages.tkinter
      python27Packages.EditorConfig
      python35Packages.EditorConfig
      python27Packages.editorconfig
      python35Packages.editorconfig
      python27Packages.jedi
      python35Packages.jedi
      python27Packages.python-editor
      python35Packages.python-editor
      python27Packages.robotframework-ride
      #python27Packages.pysideApiextractor
      #python35Packages.pysideApiextractor
      #python27Packages.pysideGeneratorrunner
      #python35Packages.pysideGeneratorrunner
      #python27Packages.pysideShiboken
      #python35Packages.pysideShiboken
      #python27Packages.pysideTools
      #python35Packages.pysideTools
      python27Packages.autopep8
      python35Packages.autopep8
      python27Packages.bleach
      python35Packages.bleach
      python27Packages.clientform
      python27Packages.django_colorful
      python35Packages.django_colorful
      python27Packages.extras
      python35Packages.extras
      python27Packages.eyeD3
      python35Packages.eyeD3
      #|long_compiler_time|python27Packages.filebrowser_safe
      #|long_compiler_time|python35Packages.filebrowser_safe
      python27Packages.flask_principal
      #python35Packages.flash_principal
      python27Packages.fusepy
      python35Packages.fusepy
      python27Packages.future
      python27Packages.genshi
      python27Packages.grappelli_safe
      python27Packages.guessit
      python27Packages.imageio
      python27Packages.kaa-metadata
      python27Packages.Kajiki
      python27Packages.MDP
      python27Packages.mixpanel
      python27Packages.namebench
      python27Packages.ndg-httpsclient
      #|failed|python27Packages.nevow
      #|failed|python35Packages.nevow
      python27Packages.pillow
      python27Packages.pkginfo
      python27Packages.ply
      python27Packages.pycodestyle
      python27Packages.pycosat
      python27Packages.pyopengl
      #python27Packages.pyside
      python27Packages.python_mimeparse
      python27Packages.qutip
      python27Packages.s3fs
      python27Packages.sarge
      #python27Packages.simpleldap
      python27Packages.sphinxcontrib_httpdomain
      python27Packages.sphinxcontrib_plantuml
      python27Packages.sqlparse
      python27Packages.subdownloader
      python27Packages.wcwidth
      python35Packages.wcwidth
      python35Packages.future
      python35Packages.genshi
      python35Packages.grappelli_safe
      python35Packages.imageio
      python35Packages.Kajiki
      python35Packages.MDP
      python35Packages.ndg-httpsclient
      python35Packages.pillow
      python35Packages.pkginfo
      python35Packages.ply
      python35Packages.pycodestyle
      python35Packages.pycosat
      python35Packages.pyopengl
      #python35Packages.pyside
      python35Packages.python-editor
      python35Packages.python_mimeparse
      python35Packages.qutip
      python35Packages.s3fs
      python35Packages.sarge
      #python35Packages.simpleldap
      python35Packages.sqlparse
      #|not_supported|python35Packages.subdownloader
      #|cannot_build|python27Packages.PyXAPI
      #|cannot_build|python35Packages.PyXAPI
      python27Packages.brotlipy
      python27Packages.demjson
      python27Packages.cjson
      python27Packages.simplejson
      python27Packages.ujson
      python35Packages.ujson
      python27Packages.unidecode
      python35Packages.unidecode
      python27Packages.zbase32
      #|not_supported|python35Packages.zbase32
      python35Packages.brotlipy
      python35Packages.demjson
      python35Packages.simplejson
      python27Packages.dropbox
      python35Packages.dropbox
      python27Packages.urllib3
      python35Packages.urllib3
      python27Packages.slackclient
      python35Packages.slackclient
      #|failed|python27Packages.tunigo
      #|failed|python35Packages.tunigo
      python27Packages.reikna
      python35Packages.reikna
      python27Packages.tensorflowWithoutCuda
      python27Packages.TheanoWithoutCuda
      #python27Packages.tensorflowWithCuda
      #python27Packages.TheanoWithCuda
      #python35Packages.TheanoWithCuda
      #python27Packages.libgpuarray-cuda
      #python35Packages.libgpuarray-cuda
      #python27Packages.pycuda
      #python35Packages.pycuda
      python27Packages.pyopencl
      python35Packages.pyopencl
      python27Packages.pyftgl
      python35Packages.pyftgl
      python27Packages.pyopengl
      python35Packages.pyopengl
      python27Packages.cgkit
      python27Packages.pyqtgraph
      python35Packages.pyqtgraph
      python27Packages.reportlab
      python35Packages.reportlab
      python27Packages.itsdangerous
      python27Packages.django_compressor
      python35Packages.django_compressor
      python27Packages.flask_assets
      python27Packages.lz4
      python35Packages.lz4
      python35Packages.flask_assets
      python27Packages.epc
      python27Packages.pymacs
      python35Packages.epc
      python27Packages.semantic-version
      python35Packages.semantic-version
      python27Packages.Pweave
      python35Packages.Pweave
      python27Packages.cython
      python27Packages.llvmlite
      #|failed|python27Packages.pyscss
      python35Packages.cython
      python35Packages.llvmlite
      python35Packages.Nuitka
      #|failed|python35Packages.pyscss
      python27Packages.numba
      python35Packages.numba
      #python27Packages.nixpart()
      #python35Packages.nixpart()
      python27Packages.BTrees
      python27Packages.graphite_web
      #|er|python35Packages.graphite_web
      python27Packages.graphite_api
      python35Packages.graphite_api
      python35Packages.BTrees
      python35Packages.xgboost
      python27Packages.buttersink
      python27Packages.fs
      python27Packages.ftputil
      python27Packages.pathlib
      python27Packages.pathlib2
      python27Packages.pathtools
      python35Packages.pathtools
      python27Packages.pox
      python27Packages.pyinotify
      python35Packages.pyinotify
      python27Packages.pylibacl
      python27Packages.pyxattr
      python27Packages.watchdog
      python35Packages.watchdog
      python35Packages.fs
      python35Packages.pox
      python35Packages.pylibacl
      python35Packages.pyxattr
      python27Packages.numexpr
      python27Packages.simpleeval
      python35Packages.numexpr
      python35Packages.simpleeval
      python27Packages.Keras
      python35Packages.Keras
      python27Packages.tensorflow
      python35Packages.tensorflow
      #|failed|python27Packages.tflearn
      #|failed|python35Packages.tflearn
      python27Packages.closure-linter
      python27Packages.gcs-oauth2-boto-plugin
      python27Packages.gdata
      python27Packages.gflags
      python27Packages.gmusicapi
      python27Packages.goobook
      python27Packages.google_api_python_client
      python27Packages.google_apputils
      python27Packages.googlecl
      python27Packages.gplaycli
      python27Packages.gpsoauth
      python27Packages.gspread
      python27Packages.gsutil
      python27Packages.ipaddr
      python27Packages.protobuf
      python27Packages.jsbeautifier
      python35Packages.jsbeautifier
      python27Packages.facebook-sdk
      python27Packages.munch
      python35Packages.munch
      python27Packages.nototools
      python27Packages.pdfkit
      python35Packages.pdfkit
      python27Packages.wtforms
      python35Packages.wtforms


      # Haskell
      #haste
      #ihaskell
      lambdabot
      #leksah
      mueval
      multi-ghc-travis
      tinc
      #haskell-modules
      
      # OCaml
      ocaml
      ocaml-top
      ocaml_make
      orc
      #|coerce_set_to_string|ocaml-ng
      #ocamlPackages
      ocamlPackages.lambdaTerm
      ocamlPackages.astring
      ocamlPackages.containers
      ocamlPackages.otfm
      ocamlPackages.ptime
      ocamlPackages.xml-light
      ocamlPackages.zed
      ocamlPackages.vg
      ocamlPackages.otfm
      ocamlPackages.uucd
      ocamlPackages.xmlm
      ocamlPackages.jsonm
      ocamlPackages.ocaml_cairo2
      ocamlPackages.gg
      ocamlPackages.notty
      ocamlPackages.angstrom
      ocamlPackages.camlzip
      ocamlPackages.bitstring
      ocamlPackages.ott
      ocamlPackages.js_of_ocaml
      ocamlPackages.ppx_optcomp
      #|er|ocamlPackages.llvm
      ocamlPackages.ocpBuild
      ocamlPackages.fpath
      ocamlPackages.gapi_ocaml

      # Erlang
      erlang
      #hex
      rebar
      rebar3
      rebar3-open
      cl
      esdl
      cuter

      # Elixir
      elixir
      
      # Emscripten
      #|coerce_set_to_string|buildEmscriptenPackage
      emscripten
      emscriptenfastcomp
      emscriptenfastcomp-unwrapped
      #|do_not_exist|emscriptenfastcomp-wrapper
      emscriptenPackages.json_c
      #|cannot_build|emscriptenPackages.libxml2
      #|cannot_build|                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           emscriptenPackages.xmlmirror
      emscriptenPackages.zlib
      emscriptenStdenv

      
      # Elm
      elmPackages.elm
      elmPackages.elm-compiler
      elmPackages.elm-format
      elmPackages.elm-make
      elmPackages.elm-package
      elmPackages.elm-reactor
      elmPackages.elm-repl
      vimPlugins.elm-vim
      
      # Swift
      swift
      swiften
      
      # Idris
      #idris-modules
      
      # JSON
      jo
      jmespath
      jid
      jp
      jq
      json_glib

      # Kotlin
      kotlin
      
      # Java
      openjdk
      #jre
      visualvm
      ecj
      ant
      grails
      #javaPackages
      commonsBcel
      commonsBsf
      commonsCompress
      commonsFileUpload
      commonsLang
      commonsLogging
      commonsIo
      commonsMath
      fastjar
      httpunit
      gwtdragdrop
      gwtwidgets
      javaCup
      jdom
      jflex
      #|er|junit
      #|broken|junixsocket
      jzmq
      lombok
      lucene
      mockobjects
      saxon
      saxonb
      smack
      swt

      # Guile
      #|cannot_build|guile
      #|er|slibGuile
      #|cannot_build|guile-opengl
      #|cannot_build|guileCairo
      #|cannot_build|guileGnome
      #|er|guile_lib
      #|er|guile_ncurses
      #|er|mcron
      #g-wrap
      #guile-lint
      #guile-sdl
      #guile-sdl2
      #guile-xcb

      # XML
      tinyxml
      xmlindent

      # Isabelle
      isabelle

      # R
      R
      rWrapper
      #rPackages

      # Smalltalk
      squeak

      # Agda
      #|coerce_set_to_string|agda
      #|er|agdaBase
      #|er|agdaIowaStdLib
      agdaPrelude
      #|er|AgdaStdLib
      #|er|AgdaSheaves
      #|er|bitvector
      pretty
      #|er|TotalParserCombinators

      # Scheme
      #scheme
      chicken
      bigloo
      chez
      gambit
      microscheme

      # Pure
      pure
      purePackages.gl

      # Dart
      dart

      # Clojure
      boot
      #clojure
      #|wrong_hash|clooj
      leiningen

      # D
      dmd
      rdmd

      # Free Pascal
      fpc

      # Prolog
      gprolog
      swiProlog
      teyjus
      yap

      # Julia
      #|failed|julia
      #|failed|julia-git

      # Groovy
      groovy

      # Octave
      octaveFull

      # C / C++
      #|er|qt5.wayland
      agg
      fcppt
      clang_4
      clangSelf
      clang-tools
      chibi
      vmmlib
      vcg
      libqglviewer
      glm
      libclc
      glibc
      cxxtools
      bear
      stdman
      rtmidi
      rtaudio
      creduce
      cproto
      cppi
      complexity
      coccinelle
      cflow
      ctags
      gob2
      gengetopt
      boehmgc
      pmccabe
      unifdef
      universal-ctags
      omniorb
      rtags
      tradcpp
      xqilla
      check
      commoncpp2
      csdp
      libchamplain
      gnome3.libchamplain
      plotutils
      glew

      # HTML
      #pup
      wml
      
      # CSS
      libsass
      sass
      sassc
      less
      lessc
      lesspipe
      
      # LLVM
      llvm_4
      #llvm-dev
      #llvm-runtime
      #llvm_4
      #libllvm-ocaml-dev
      ghdl_llvm
      lld
      lldb_4
      lit
      souper
      
      # Lua
      lua
      luajit
      luarocks
      toluapp
      lua5_expat
      lua5_sec
      luabind
      luabind_luajit
      terra
      lua51Packages.luafilesystem
      lua52Packages.luafilesystem
      luajitPackages.luafilesystem
      lua51Packages.lgi
      lua52Packages.lgi
      luajitPackages.lgi
      lua51Packages.luabitop
      lua52Packages.luabitop
      luajitPackages.luabitop
      lua51Packages.cjson
      lua52Packages.cjson
      luajitPackages.cjson
      lua51Packages.luaexpat
      lua52Packages.luaexpat
      luajitPackages.luaexpat
      lua51Packages.lpeg
      lua52Packages.lpeg
      luajitPackages.lpeg
      lua51Packages.lpty
      lua52Packages.lpty
      luajitPackages.lpty
      #|er|lua51Packages.mpack
      lua52Packages.mpack
      #|er|luajitPackages.mpack
      lua51Packages.luaevent
      #|er|lua52Packages.luaevent
      luajitPackages.luaevent
      lua51Packages.luaposix
      lua52Packages.luaposix
      luajitPackages.luaposix
      lua51Packages.luasec
      lua52Packages.luasec
      luajitPackages.luasec
      lua51Packages.luasocket
      lua52Packages.luasocket
      luajitPackages.luasocket
      lua51Packages.luasqlite3
      lua52Packages.luasqlite3
      luajitPackages.luasqlite3
      lua51Packages.luastdlib
      lua52Packages.luastdlib
      luajitPackages.luastdlib
      lua51Packages.luazip
      #|er|lua52Packages.luazip
      luajitPackages.luazip
      lua51Packages.luazlib
      lua52Packages.luazlib
      luajitPackages.luazlib
      lua51Packages.luarocks
      lua52Packages.luarocks
      luajitPackages.luarocks
      lua51Packages.vicious
      lua52Packages.vicious
      luajitPackages.vicious
      
      # SQL
      tora
      
      # Shell
      checkbashisms
      
      # Lisp / Common Lisp
      asdf
      sbcl
      sbclBootstrap
      gcl
      clisp
      clisp-tip
      cl-launch
      abcl
      cmucl_binary
      #lisp
      acl2
      ecl
      eql
      librep
      lush2
      mkcl
      picolisp
      pixie
      lispPackages.chipz
      lispPackages.clwrapper
      lispPackages.alexandria
      lispPackages.babel
      lispPackages.bordeaux-threads
      lispPackages.cffi
      lispPackages.chunga
      #lispPackages.cl-ssl
      lispPackages.cl-base64
      lispPackages.cl-fad
      lispPackages.cl-fuse
      lispPackages.cl-fuse-meta-fs
      #lispPackages.cl-html-parse
      lispPackages.cl-ppcre
      lispPackages.cl-smtp
      lispPackages.cl-store
      lispPackages.cl-unification
      lispPackages.cl-utilities
      lispPackages.cl-vectors
      lispPackages.clsql
      lispPackages.clx
      lispPackages.clx-truetype
      lispPackages.clx-xkeyboard
      lispPackages.command-line-arguments
      lispPackages.drakma
      lispPackages.esrap
      lispPackages.esrap-peg
      lispPackages.flexi-streams
      lispPackages.ironclad
      lispPackages.md5
      lispPackages.nibbles
      lispPackages.pcall
      lispPackages.puri
      lispPackages.query-fs
      lispPackages.quicklisp
      lispPackages.trivial-backtrace
      lispPackages.trivial-features
      lispPackages.trivial-garbage
      lispPackages.trivial-gray-streams
      lispPackages.trivial-utf-8
      lispPackages.uffi
      lispPackages.usocket
      lispPackages.zpb-ttf
      lispPackages.stdenv

      
      # Ruby
      #chruby
      #rubocop
      #ruby-zoom
      jruby
      
      # Scala
      scala
      scalafmt
      #ammonite-repl

      # Nim
      #nrpl
      
      # Vala
      vala
      valadoc
      valum
      
      # Perl
      #LWP
      #LWPProtocolHttps
      #IPCRun
      #FileSlurp
      #perlPackages
      #perlPackages.classFactoryUtil
      perlXMLParser
      perlPackages.ack
      perlPackages.ArchiveCpio
      sqitchPg
      perlPackages.ClassStd
      perlPackages.ImageExifTool
      perlPackages.LWP
      perlPackages.LWPProtocolConnect
      perlPackages.LWPProtocolHttps
      perlPackages.LWPUserAgent
      perlPackages.ModuleRuntimeConflicts
      perlPackages.Test
      perlPackages.TestTime
      perlPackages.URI
      perlPackages.JSON
      perlPackages.TextUnidecode
      perlPackages.Cairo
      perlPackages.PodCoverageTrustPod
      #perlPackages.maatkit
      perlPackages.CompressBzip2
      perlPackages.CompressRawBzip2
      perlPackages.CompressRawZlib
      perlPackages.CompressUnLZMA
      perlPackages.CompressZlib
      perlPackages.PodLaTeX
      perlPackages.ApacheLogFormatCompiler
      perlPackages.BC
      perlPackages.InlineJava
      perlPackages.POSIXstrftimeCompiler
      perlPackages.Env
      perlPackages.I18NCollate
      perlPackages.Readonly
      perlPackages.ScalarListUtils
      perlPackages.ScalarString
      perlPackages.SetScalar
      perlPackages.TieCycle
      perlPackages.FilesysNotifySimple
      perlPackages.XMLXPath
      perlPackages.GoogleProtocolBuffers
      perlPackages.UriGoogleChart
      perlPackages.TemplatePluginJavaScript
      perlPackages.Pango
      perlPackages.HTMLFormFu

      ## Kubernetes ##
      kube-aws
      
      ## Pair-Programming ##
      leaps
      
      ## Signal Analysis & Processing ##
      libsigrok
      libsigrokdecode
      faust
      
      ## Literate-Programming ##
      eweb
      funnelweb
      noweb
      nuweb
      cwebbin
      
      ## Debian / RPM ##
      makerpm
      debianutils
      debian-devscripts
      
      ## WordPress ##
      wp-cli
      
      ## Libraries / Misc ##
      ### warning ###
      #|undefined|desktop-file-utils
      ebook_tools

      ### /warning ###
      libselinux
      utillinux
      usbutils
      keynav
      jack2Full
      libjack2Unstable
      dpkg
      dbus-map
      tcl
      tk
      libsigcxx
      thrift
      tbb
      jemalloc
      yi
      smc
      pari-unstable
      libcutl
      libcaca
      accelio
      wget
      whois
      simgrid
      libsForQt5.quazip
      mpfr
      lightning
      libmx
      libnfnetlink
      libnice
      liboggz
      libossp_uuid
      hwloc
      gst_all_1.gst-plugins-good
      gst_all_1.gst-editing-services
      granite
      vagrant
      compass
      clang-tools
      doctl
      #flamegraph
      galen
      gnulib
      #gtk-mac-bundler
      hexio
      imatix_gsl
      mdk
      minizinc
      arcanist
      astyle
      autoconf-archive
      autoconf
      autogen
      automoc4
      avarice
      avrdude
      awf
      babeltrace
      bashdb
      bin_replace_string
      binutils
      chrpath
      cgdb
      bossa
      doclifter
      dfu-programmer
      dfu-util
      dejagnu
      ddd
      dbench
      #d-feet
      hound
      help2man
      gtkdialog
      gperf
      global
      gede
      gdb
      fswatch
      epm
      elfutils
      eggdbus
      editorconfig-core-c
      drush
      msitools
      #md2man
      ltrace
      lttng-tools
      lttng-ust
      lttv
      loccount
      libtool
      #NetAmazonS3
      #IOCompress
      #icon-naming-utils
      indent
      inotify-tools
      intltool
      iozone
      itstool
      kconfig-frontends
      #dri2proto
      bison
      kmod
      procps
      ninka
      nixbang
      objconv
      opengrok
      openocd
      pahole
      pkgconfig
      prelink
      rman
      rolespec
      saleae-logic
      sipp
      sloccount
      #sqitch
      srecord
      stlink
      strace
      sysbench
      tcptrack
      teensy-loader-cli
      tet
      texi2html
      tokei
      trv
      uhd
      uisp
      usb-modeswitch
      xc3sprog
      xxdiff
      ycmd
      yodl
      #node-webkit-nw11
      packet
      parse-cli-bin
      postiats-utilities
      quilt
      rucksack
      sauce-connect
      sunxi-tools
      #gnome_vfs
      alsaLib
      #qtbase
      #qtx11extras
      rsync
      parallel
      #qt-5
      polkit
      pkcs11helper
      #gcov
      lcov
      libassuan
      libatomic_ops

      ## CSV ##
      textql

      ## Certificates ##
      sslmate

      ## Tools ##
      watchman
      xcbuild
      xib2nib

      ## Redis ##
      redis-dump

      ## MessagePack ##
      msgpack-tools

      ## Xorg Libs ##
      ##warning##
      ##/warning##
      xkbset
      xkb_switch
      xkblayout-state
      xxkb
      libdrm
      #libxcwm
      #libAppleWM
      #libICE
      #libSM
      #libXTrap
      #libXau
      #libXaw
      #libXaw3d
      #libXcomposite
      #libXcursor
      #libXdamage
      #libXdmcp
      #libXevie
      #libXext
      #libXfixes
      #libXfont
      #libXfontcache
      #libXft
      #libXi
      #ibXinerama
      #libXlg3d
      #libXmu
      #libXp
      #libXpm
      #libXpresent
      #libXprintAppUtil
      #libXprintUtil
      #libXt
      #libXtst
      #libXv
      #libXvMC
      #libXxf86dga
      #libXxf86misc
      #libXxf86rush
      #libXxf86vm
      #libdmx
      #libfontenc
      #liblbxutil
      #liboldX
      libxkbcommon
      #libxkbfile
      #libxkbui
      #libxshmfence
      #libxtrans
      remarshal
      reno
      nexus
      rhc
      ronn
      simavr

      ## Fonts ##
      ghostscript
      ghostscriptX
      ftgl
      font-manager
      gbdfed
      gnome3.gnome-font-viewer
      gtk2fontsel
      lxappearance
      ttmkfdir
      #ttfautohunt
      xfontsel
      #|coerce_set_to_string|openlilylib-fonts
      norwester-font
      tewi-font
      shrikhand
      fontconfig-penultimate
      andagii
      arc-icon-theme
      arkpandora_ttf
      aurulent-sans
      babelstone-han
      baekmuk-ttf
      caladea
      carlito
      comfortaa
      comic-neue
      dina-font
      dina-font-pcf
      cabin
      dosis
      eb-garamond
      faba-icon-theme
      faba-mono-icons
      #|er|emacs-all-the-icons-fonts
      emojione
      encode-sans
      envypn-font
      fantasque-sans-mono
      fira-code
      gentium-book-basic
      gohufont
      go-font
      hack-font
      helvetica-neue-lt-std
      #|er|hicolor-icon-theme
      hanazono
      inconsolata
      inconsolata-lgc
      #|failed_download_only_from_site_try_again_to_see|input-fonts
      junicode
      kawkab-mono-font
      #|er|liberation_ttf_v2_from_binary
      liberastika
      libre-franklin
      lmmath
      lmodern
      lobster-two
      maia-icon-theme
      marathi-cursive
      meslo-lg
      mononoki
      moka-icon-theme
      montserrat
      mph_2b_damase
      mro-unicode
      nafees
      numix-icon-theme
      numix-icon-theme-circle
      numix-icon-theme-square
      oldstandard
      oldsindhi
      open-dyslexic
      overpass
      oxygen-icons5
      paper-icon-theme
      pecita
      paratype-pt-mono
      paratype-pt-sans
      paratype-pt-serif
      poly
      profont
      sampradaya
      signwriting
      soundfont-fluid
      quattrocento
      quattrocento-sans
      raleway
      hasklig
      siji
      source-han-sans-japanese
      source-han-sans-korean
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
      source-han-serif-japanese
      source-han-serif-korean
      source-han-serif-simplified-chinese
      source-han-serif-traditional-chinese
      tango-icon-theme
      tai-ahom
      theano
      tempora_lgc
      terminus_font_ttf
      tipa
      ttf_bitstream_vera
      ubuntu_font_family
      uni-vga
      unifont
      unifont_upper
      vanilla-dmz
      wqy_microhei
      wqy_zenhei
      clearlyU
      crimson
      comic-relief

      # PostScript
      libspectre

      ## Diagrams ##
      diagrams-builder
      cfdg

      ## IPFS ##
      ipfs
      cpp-ipfs-api
      gx
      python35Packages.ipfsapi

      ## Keybase ##
      keybase
      keybase-gui
      kbfs

      ## WebAssembly ##
      wasm

      ## Audio ##
      multimon-ng
      audacity
      dfasma
      kid3
      quodlibet
      quodlibet-without-gst-plugins
      supercollider
      supercollider_scel

      ## HTTP ##
      libnghttp2
      nghttp2

      ## Networking ##
      ##warning##
      ##/warning##
      connect
      curlFull
      curl_unix_socket
      snabb
      vtun
      riemann
      riemann_c_client
      riemann-dash
      riemann-tools

      ## DNS ##
      dnschain

      ## Web Servers ##
      #caddy
      #apacheHttpd
      #darkhttpd
      #hiawatha
      #nginxMainline

      ## Databases ##
      #rocksdb
      #couchdb
      gdbm
      #leveldb
      #cassandra
      libmysqlconnectorcpp
      mysql-workbench
      redis-desktop-manager

      # MongoDB
      libmongo-client
      mongodb-tools
      robomongo

      ## Package Management ##
      opkg
      opkg-utils

      ## ASCII ##
      asciidoc
      asciidoc-full
      asciidoc-full-with-plugins

      ## AWS / Azure ##
      aws-sdk-cpp
      azure-cli

      ## Google ##
      gdata-sharp
      #|er|gcsfuse
      google-authenticator
      google-cloud-sdk

      ## Compression / Decompression ##
      brotliUnstable
      libbrotli
      lzma
      xz
      lz4
      lzo
      lzfse
      pxz
      snappy
      zstd
      advancecomp
      bzip2
      eq10q
      gsm
      gzip
      gnome3.gnome-autoar
      jbig2dec
      jbig2enc
      jbigkit
      lbzip2
      libarchive
      libmspack
      libxcomp
      lrzip
      lzip
      lzop
      ncompress
      nxproxy
      pixz
      rzip
      ucl
      unar
      unzipNLS
      unzip
      wavpack
      xdelta
      xdeltaUnstable
      zlib
      zlibStatic
      zopfli
      zpaqd
      zziplib
      libewf
      jpegrescan

      ## Cryptography / Encryption / Hash ##
      sops
      mcrypt
      libmhash

      ## Libraries ##
      fastJson
      vdpauinfo
      bridge-utils
      hal-flash
      pngpp
      pdf2xml
      libzip
      libxslt
      libyaml
      #libyaml-cpp
      libxmp
      libxmlxx
      #libxml2
      libxls
      #libxdg-basedir
      libwebp
      libwebsockets
      libvirt
      libviper
      libuv
      libtelnet
      libtar
      libssh2
      libspotify
      libressl
      librsync
      libs3
      librsvg
      libproxy
      libpipeline
      libpar2
      libnet
      libmsgpack
      libmpack
      libmpc
      libmpcdec
      libmongo-client
      libmicrohttpd
      libmemcached
      libmcrypt
      libjson
      libjson-rpc-cpp
      #libjpeg-drop
      #libjpeg-turbo
      #libindicator
      #libindicate
      libidn
      libidn2
      libicns
      libhttpseverywhere
      libgtop
      libgudev
      libguestfs
      libgumbo
      libgnurl
      libgcrypt
      libfprint
      libfm
      libfixposix
      libevent
      libevdev
      libdrm
      libdv
      libdvbpsi
      libdvdcss
      libdvdnav
      libdvdread
      libdwarf
      libdwg
      #libdbusmenu
      #libdbusmenu-qt
      libdbi
      #libdbi-drivers
      libdap
      libdaemon
      libasr
      kinetic-cpp-client
      #json-c
      #json-glib
      jsoncpp
      iniparser
      ip2location-c
      http-parser
      #gtkp
      #gtk-mac-integration
      gtk-sharp-beans
      #gtk-sharp
      gtkdatabox
      gtkimageview
      #gtkmathview
      #gtkmm
      #gtkspell
      gtkspellmm
      gts
      gstreamer
      gsl
      gtdialog
      gtest
      gsasl
      gpgme
      gperftools
      google-gflags
      goocanvas
      #gobject-introspection
      goffice
      gnome-sharp
      gnet
      globalplatform
      glibmm
      glib
      #glib-networking
      #git2
      gettext
      gf2x
      giblib
      giflib
      geoip
      gegl
      gecode
      geis
      #gdk-pixbuf
      gdcm
      ftgl
      freetype
      freetts
      freetds
      frame
      fontconfig-ultimate
      flatbuffers
      flann
      flint
      #fastjson
      expat
      epoxy
      dbus
      #dbus-sharp
      #dbus-sharp-glib
      #dbus-glib
      #dbus-cplusplus
      #dbm
      curlcpp
      cryptopp
      cre2
      cpp-hocon
      cpp-netlib
      cppcms
      cppdb
      cpptest
      cppunit
      #ccputest
      cppzmq
      cminpack
      cmocka
      clutter
      #clutter-gtk
      clutter-gst
      cloog
      #cloog-ppl
      catch
      box2d
      boringssl
      bootil
      breakpad
      caf
      boost
      #boost-process
      #boehm-gc
      beecrypt
      babl
      avro-cpp
      avahi
      #audio
      audiofile
      attr
      atkmm
      attica
      #at-spi2-atk
      #at-spi2-core
      appstream
      appstream-glib
      ace
      acl
      accountsservice
      accounts-qt
      #CGAL
      physfs
      lucenepp
      loki
      libtiff
      libpng
      icu
      harfbuzz
      mapnik
      libopus
      bctoolbox
      openssl
      libmatroska
      libupnp
      libvpx
      ortp
      libv4l
      libpcap
      srtp
      microsoft_gsl
      minixml
      minizip
      mongoc
      #|coerce_set_to_string|fetchzip
      perl
      libbson
      which
      ncurses
      cpio
      cdrkit
      flex
      qemu
      pcre
      augeas
      libcap
      libcap_ng
      libconfig
      fuse
      yajl
      hivex
      gmp
      #libintlperl
      #GetoptLong
      #SysVirt
      numactl
      xen
      libapparmor
      getopt
      libguestfs
      libgumbo
      stdenv
      libelf
      libdwg
      #libtorrent-rasterbar
      libtomcrypt
      libui
      libunique
      libunistring
      libunibreak
      libunwind
      libunity
      liburcu
      libusb
      libusb1
      libusbmuxd
      libutempter
      libvirt-glib
      libvisio
      libvisual
      libwpg
      libwmf
      libwps
      lirc
      lmdb
      log4cplus
      log4cpp
      log4cxx
      martyr
      menu-cache
      miniball
      mimetic
      mlt
      mono-addins
      mono-zeroconf
      motif
      muparser
      nanoflann
      nanomsg
      nco
      ndpi
      netcdf
      #netcdf-fortran
      #netcdf-cxx4
      nettle
      newt
      nix-plugins
      nlohmann_json
      nlopt
      notify-sharp
      #npapi-sdk
      npth
      nspr
      nss
      nss_wrapper
      ntdb
      ntl
      ntrack
      ocl-icd
      ode
      opal
      #openal-soft
      openbabel
      openmpi
      openslp
      opensubdiv
      openwsman
      #osip
      osm-gps-map
      #p11-kit
      pango
      pangomm
      #pangox-compat
      pangoxsl
      pcaudiolib
      pcl
      pcre
      pcre2
      pixman
      #polkit-qt-1
      popt
      portaudio
      portmidi
      #|coerce_set_to_string|postgis
      ppl
      prison
      proj
      psol
      ptlib
      pugixml
      #pupnp
      qca-qt5
      qca2
      qhull
      qimageblitz
      qjson
      qoauth
      qt-mobility
      qtkeychain
      qtscriptgenerator
      #qtwebkit-plugins
      qwt
      qxt
      re2
      readosm
      rep-gtk
      resolv_wrapper
      rlog
      safefile
      #|failed|shapelib
      serf
      slang
      #slib
      smpeg
      #snack
      socket_wrapper
      #sofia_sip
      #sonic
      #soprano
      soqt
      #spice-gtk
      #spice-protocol
      libffi
      libgksu

      ## Virtualization / VMs / Containers ##
      skopeo
      vndr
      spice
      open-vm-tools

      ## Cloud Providers ##
      vultr
      heroku

      ## Continuous Build Systems ##
      #|LATER_STUDY|hydra
      #|LATER_STUDY|travis

      ## Mind Mapping ##
      vym

      ## Metrics / Monitor / Stats / Trace / Profilers ##
      #NetStatsd
      #neoload
      #rq
      fatrace
      iptraf-ng
      libpfm
      libstatgrab
      logstalgia
      nuttcp
      oprofile
      pagemon
      sysprof
      time
      vnstat
      eventlog
      apitrace
      statsd
      ntopng
      ipv6calc
      logrotate
      dfc
      fsmon
      fam
      vmtouch
      haka

      ## Others ##
      lshw
      lsof
      lzma
      sysdig
      nix-prefetch-scripts
      libidn2
      bc
      file
      nixUnstable
      nixUnstable.perl-bindings
      unity3d

    ]; #/systemPackages
  }; #/environment


###############
#### FONTS ####
###############

  fonts = {
    enableDefaultFonts = true;
    enableGhostscriptFonts = true;
    enableFontDir = true;
    fontconfig = {
      useEmbeddedBitmaps = true;
      penultimate.enable = true;
      ultimate = {
        enable = true;
        substitutions = "combi";
      }; #/ultimate
    }; #/fontconfig
    fonts = with pkgs; [
      corefonts
      terminus_font
      kochi-substitute-naga10
      source-code-pro
      dejavu_fonts
      camingo-code
      gentium
      iosevka
      ipaexfont
      ipafont
      libre-baskerville
      noto-fonts
      noto-fonts-cjk
      oxygenfonts
      roboto
      roboto-mono
      roboto-slab
      culmus
      font-awesome-ttf
      font-droid
      google-fonts
      lato
      anonymousPro
      bakoma_ttf
      cantarell_fonts
      cm_unicode
      dejavu_fontsEnv
      dosemu_fonts
      xorg.fontschumachermisc
      xorg.fontscreencyrillic
      xorg.fontsonymisc
      xorg.fontsunmisc
      xorg.fontsproto
      freefont_ttf
      gyre-fonts
      kochi-substitute
      league-of-moveable-type
      liberation_ttf_v1_from_source
      liberation_ttf_v1_binary
      liberation_ttf_v2_from_source
      liberation_ttf
      liberationsansnarrow
      liberationsansnarrow_binary
      libre-bodoni
      libre-caslon
      libertine
      lohit-fonts.assamese
      lohit-fonts.bengali
      lohit-fonts.devanagari
      lohit-fonts.gujarati
      lohit-fonts.gurmukhi
      lohit-fonts.kannada
      lohit-fonts.kashmiri
      lohit-fonts.konkani
      lohit-fonts.maithili
      lohit-fonts.malayalam
      lohit-fonts.marathi
      lohit-fonts.nepali
      lohit-fonts.odia
      lohit-fonts.sindhi
      lohit-fonts.tamil
      lohit-fonts.tamil-classical
      lohit-fonts.telugu
      xorg.mkfontscale
      mplus-outline-fonts
      nerdfonts
      noto-fonts-emoji
      opensans-ttf
      orbitron
      powerline-fonts
      proggyfonts
      source-sans-pro
      source-serif-pro
      stix-otf
      stix-two
      ucs-fonts
      unscii
      vistafonts
      xits-math
      xlsfonts
      fira
      fira-mono
    ]; #/fonts
  }; #/fonts


##################
#### PROGRAMS ####
##################

  programs = {
    zsh.enable = true;
    wireshark.enable = true;
    #command-not-found.enable = true;
    #|BUGFAIL|cdemu.enable = true;
    adb.enable = true;
    #slock.enable = true;
    xonsh.enable = true;
    bash = {
      enableCompletion = true;
    }; #/bash
    ssh = {
      startAgent = true;
    }; #/ssh
    #venus = { ## @TODO: CONFIGURE ##
    #  enable = true;
    #};
  }; #/programs


##################
#### SERVICES ####
##################

  services = {
    transmission.enable = true;
    dbus.enable = true;
    uptimed.enable = true;
    printing.enable = true;
    #psd.enable = true;
    irqbalance.enable = true; #performance optimization
    thermald.enable = true; #temperature management
    upower.enable = true; #powermanagement for applications
    actkbd.enable = true; #enable global binding keys
    acpid.enable = true; #daemon used to handle events (e.g. closing lid, power button, etc.) @TODO: CONFIGURE
    #resolved.enable = true; @TODO: CONFIGURE
    timesyncd.enable = true;
    kmscon = {
      enable = true;
      hwRender = true;
    }; #/kmscon

    earlyoom = {
      enable = true;
      enableDebugInfo = true;
    }; #/earlyoom

    #hbase.enable = true; @TODO: CONFIGURE
    #influxdb.enable = true; @TODO: CONFIGURE
    #memcached.enable = true; @TODO: CONFIGURE
    #mongodb.enable = true; @TODO: CONFIGURE
    #mysql.enable = true; @TODO: CONFIGURE
    #neo4j.enable = true; @TODO: CONFIGURE
    #openldap.enable = true; @TODO: CONFIGURE
    #opentsdb.enable = true; @TODO: CONFIGURE
    #postgresql.enable = true; @TODO: CONFIGURE
    #redis.enable = true; @TODO: CONFIGURE
    #riak.enable = true; @TODO: CONFIGURE
    #riak-cs.enable = true; @TODO: CONFIGURE
    #stanchion.enable = true; @TODO: CONFIGURE
    #virtuoso.enable = true; @TODO: CONFIGURE
    #cassandra.enable = true; @TODO: CONFIGURE
    #couchdb.enable = true; @TODO: CONFIGURE
    #fourStore.enable = true; @TODO: CONFIGURE
    #fourStoreEndpoint.enable = true; @TODO: CONFIGURE
    #hoogle.enable = true; @TODO: CONFIGURE
    #emacs.enable = true; @TODO: CONFIGURE
    #psd.enable = true; @TODO: CONFIGURE (CHROMIUM AND FIREFOX NOT WORKING)
    #
    #
    #

    ## Backup ##

    #backup = {
    #  #tarsnap.enable = true; @TODO: CONFIGURE
    #  #znapzend.enable = true; @TODO: CONFIGURE (ZFS)
    #  #crashplan.enable = true; @TODO: CONFIGURE
    #};

    ## Logging ##
    fluentd.enable = true; #@TODO: CONFIGURE
    #graylog.enable = true; #@TODO: CONFIGURE
    journalbeat.enable = true; #@TODO: CONFIGURE
    #logcheck = { #@TODO: CONFIGURE
    #  enable = true;
    #  level = "workstation";
    #}; #/logcheck
    #|HIGH_MEMORY|logstash = {
    #|HIGH_MEMORY|  enable = true;
    #|HIGH_MEMORY|  enableWeb = true;
    #|HIGH_MEMORY|};

    ## Mail ##
    #postfix.enable = true; @TODO: CONFIGURE
    #dovecot2.enable = true; @TODO: CONFIGURE
    #exim.enable = true; @TODO: CONFIGURE
    #spamassassin.enable = true; @TODO: CONFIGURE
    #mlmmj.enable = true; @TODO: CONFIGURE (MAILING LIST)
    #offlineimap.enable = true; @TODO: CONFIGURE (FETCH TO PROVIDE OFFLINE ACCESS)
    #opendkim.enable = true; @TODO: CONFIGURE (SENDER AUTHENTICATION SYSTEM)
    #opensmtpd.enable = true; @TODO: CONFIGURE
    #postgrey.enable = true; @TODO: CONFIGURE (POSTFIX GREYLISTING POLICY SERVER)
    #postsrsd.enable = true; @TODO: CONFIGURE (SRS SERVER FOR POSTFIX)
    #rmilter.enable = true; @TODO: CONFIGURE
    #rspamd.enable = true; @TODO: CONFIGURE

    ## Irc ##
    irkerd.enable = true;
    quassel.enable = true;

    ## Git ##
    gitDaemon.enable = true;

    ## P2P / Torrent ##
    #jackett.enable = true; @TODO: CONFIGURE (TORRENT TRACKER API)

    ## File System ##
    #ipfs.enable = true; @TODO: CONFIGURE

    ## Cryptocurrency ##
    #rippled.enable = true; @TODO: CONFIGURE (ledger)

    ## Security ##
    #sssd.enable = true; @TODO: CONFIGURE

    ## VPN ##
    #openvpn.servers @TODO: CONFIGURE
    #softether.enable = true; @TODO: CONFIGURE
    #toxvpn.enable = true; @TODO: CONFIGURE

    ## DNS ##
    #powerdns.enable = true; @TODO: CONFIGURE
    #skydns.enable = true; @TODO: CONFIGURE
    #unbound.enable = true; @TODO: CONFIGURE

    ## Proxy ##
    #privoxy.enable = true; @TODO: CONFIGURE

    ## File Upload & Management (e.g. alternatives to Dropbox) ##
    #syncthing.enable = true; @TODO: CONFIGURE

    ## Communication ##
    #teamspeak3.enable = true; @TODO: CONFIGURE

    ## Misc ##
    #apache-kafka.enable = true; @TODO: CONFIGURE
    #bepasty.enable = true; @TODO: CONFIGURE
    #calibre-server.enable = true; @TODO: CONFIGURE
    #confd.enable = true; @TODO: CONFIGURE
    #couchpotato.enable = true; @TODO: CONFIGURE (MOVIES, ETC.)
    #dockerRegistry.enable = true; @TODO: CONFIGURE
    #emby.enable = true; (MEDIA SERVER)
    #errbot
    #etcd.enable = true; @TODO: CONFIGURE
    #leaps.enable = true; @TODO: CONFIGURE
    #plex.enable = true; @TODO: CONFIGURE (MEDIA SERVER)
    #radarr.enable = true; @TODO: CONFIGURE (MEDIA SERVER)
    #sonarr.enable = true; @TODO: CONFIGURE (MEDIA SERVER)
    #zookeeper.enable = true; @TODO: CONFIGURE

    #matrix-synapse.enable = true;
    packagekit.enable = true;
    nzbget.enable = true;
    geoip-updater.enable = true;

    #|LATER_STUDY|disnix = {
    #|LATER_STUDY|  enable = true;
    #|LATER_STUDY|  useWebServiceInterface = true;
    #|LATER_STUDY|};
    #dysnomia.enable = true; @TODO: CONFIGURE

    
    logind.extraConfig = "IdleAction=ignore\nHandleLidSwitch=ignore\nHandleSuspendKey=ignore\nHandleHibernateKey=ignore\nLidSwitchIgnoreInhibited=no";

    xserver = {
      enable = true;
      layout = "us_intl";
      xkbVariant = "alt-intl";
      videoDrivers = [ "amdgpu" "ati_unfree" ];
      
      displayManager = {
        gdm = {
          enable = true;
          autoLogin = {
            enable = true;
            user = "alexxnica";
          }; #/autoLogin
        }; #/gdm
      }; #/displayManager
      desktopManager = {
        gnome3 = {
          enable = true;
          #gvfs.enable = true;
        };
        default = "gnome3";
      }; #/desktopManager
      libinput = {
        enable = false;
      #  tapping = true;
      #  clickMethod = "clickfinger";
      #  tappingDragLock = true;
      }; #/libinput
      #multitouch = {
      #  enable = true;
      #  tapButtons = true;
      #}; #/multitouch
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        scrollDelta = -75;
        minSpeed = "1";
        maxSpeed = "1";
        accelFactor = "0.01";
        fingersMap = [ 1 3 2 ];
        additionalOptions = ''
          Option "CoastingSpeed" "0"
          Option "CoastingFriction" "0"
          Option "FingerLow" "40"
          Option "FingerHigh" "40"
          Option "HorizHysteresis" "50"
          Option "VertHysteresis" "50"
          Option "PalmDetect" "1"
          Option "PalmMinWidth" "5"
          Option "PalmMinZ" "40"
        '';
      }; #/synaptics
    }; #/xserver
    
    avahi = {
      enable = true;
      nssmdns = true;
    }; #/avahi
    
    locate = {
      enable = true;
    }; #/locate

  }; #/services


########################
#### VIRTUALISATION ####
########################

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    }; #/dockers
    rkt = {
      enable = true;
      gc = {
        automatic = true;
        dates = "03:15";
      }; #/gc
    }; #/rkt
    virtualbox = {
      guest.enable = true;
      host.enable = true;
      #enableExtensionPack = true;
    }; #/virtualbox
  }; #/virtualisation


##################
#### SECURITY ####
##################

  #security = {
  #  grsecurity.enable = true;
  #  hideProcessInformation = true;
  #  pam.enableSSHAgentAuth = true;
  #  chromiumSuidSandbox.enable = true;
  #}; #/security


#############
#### NIX ####
#############
  nix = {
    package = pkgs.nixUnstable;
    maxJobs = 4;
    buildCores = 0;
    #autoOptimiseStore = true;
    #gc = { # run "nix-store --optmise" for better optimization, removing and hard linking duplicated copies to a single one.
    #  automatic = true;
    #  dates = "03:15";
    #}; #/gc
    #optimise = {
    #  automatic = true;
    #  dates = [ "03:45" ];
    #}; #/optimise
    #extraOptions = ''
    #  gc-keep-outputs = true
    #  gc-keep-derivations = true
    #  env-keep-derivations = true;
    #'';
  }; #/nix


##################
#### HARDWARE ####
##################

  hardware = {
    trackpoint.emulateWheel = true;
    pulseaudio.support32Bit = true;
    bluetooth.enable = true;
    #tlp.enable = true;
    cpu = {
      amd.updateMicrocode = true;
    }; #/cpu
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
      ]; #/extraPackages
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libvdpau-va-gl
        vaapiVdpau
      ]; #/extraPackages32
    }; #/opengl
  }; #/hardware


##############
#### ZRAM ####
##############

  zramSwap = {
    enable = true;
    numDevices = 4;
    memoryPercent = 50;
  }; #/zramSwap


###############
#### USERS ####
###############

  users = {
    extraUsers.alexxnica = {
      description = "Alexandre Nicastro";
      group = "users";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "audio"
        "video"
        "vboxusers"
        "cdrom"
        "nzbget"
      ]; #/extraGroups
      home = "/home/alexxnica";
      createHome = true;
      #useDefaultShell = true;
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1000;
    }; #/extraUsers.alexxnica
  }; #/users


################
#### SYSTEM ####
################

  system = {
    autoUpgrade = {
      enable = true;
      channel = https://nixos.org/channels/nixos-unstable;
    }; #/autoUpgarde
    stateVersion = "unstable";
  }; #/system

  # The NixOS release to be compatible with for stateful data such as databases.
  #system.stateVersion = "17.09";

}
