{ lib, config, ... }:
let
  cfg = config.qm.programs.aria2;
in
{
  options.qm.programs.aria2 = {
    enable = lib.mkEnableOption "Enable configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.aria2 = {
      enable = true;
      settings = {
        ### Basic ###
        # The directory to store the downloaded file.
        dir = "${config.home.homeDirectory}/Downloads";
        # Downloads the URIs listed in FILE.
        input-file = "${config.home.homeDirectory}/.aria2/aria2.session";
        # Save error/unfinished downloads to FILE on exit.
        save-session = "${config.home.homeDirectory}/.aria2/aria2.session";
        # Save error/unfinished downloads to a file specified by --save-session option every SEC seconds. If 0 is given, file will be saved only when aria2 exits. Default: 0
        save-session-interval = 60;
        # Set the maximum number of parallel downloads for every queue item. See also the --split option. Default: 5
        max-concurrent-downloads = 5;
        # Continue downloading a partially downloaded file.
        continue = true;
        # Set max overall download speed in bytes/sec. 0 means unrestricted. Default: 0
        max-overall-download-limit = 0;
        # Set max download speed per each download in bytes/sec. 0 means unrestricted. Default: 0
        max-download-limit = 0;
        # Make aria2 quiet (no console output). Default: false
        quiet = true;

        ### Advanced ###
        # Restart download from scratch if the corresponding control file doesn't exist. Default: false
        allow-overwrite = true;
        # If false is given, aria2 aborts download when a piece length is different from one in a control file. If true is given, you can proceed but some download progress will be lost. Default: false
        allow-piece-length-change = true;
        # Always resume download. If true is given, aria2 always tries to resume download and if resume is not possible, aborts download. If false is given, when all given URIs do not support resume or aria2 encounters N URIs which does not support resume, aria2 downloads file from scratch. Default: true
        always-resume = true;
        # Enable asynchronous DNS. Default: true
        async-dns = false;
        # Rename file name if the same file already exists. This option works only in HTTP(S)/FTP download. Default: true
        auto-file-renaming = true;
        # Handle quoted string in Content-Disposition header as UTF-8 instead of ISO-8859-1, for example, the filename parameter, but not the extended version filename. Default: false
        content-disposition-default-utf8 = true;
        # Enable disk cache. If SIZE is 0, the disk cache is disabled. This feature caches the downloaded data in memory, which grows to at most SIZE bytes. SIZE can include K or M. Default: 16M
        disk-cache = "64M";
        # Specify file allocation method. none doesn't pre-allocate file space. prealloc pre-allocates file space before download begins. This may take some time depending on the size of the file. If you are using newer file systems such as ext4 (with extents support), btrfs, xfs or NTFS(MinGW build only), falloc is your best choice. It allocates large(few GiB) files almost instantly. Don't use falloc with legacy file systems such as ext3 and FAT32 because it takes almost same time as prealloc and it blocks aria2 entirely until allocation finishes. falloc may not be available if your system doesn't have posix_fallocate(3) function. trunc uses ftruncate(2) system call or platform-specific counterpart to truncate a file to a specified length. Possible Values: none, prealloc, trunc, falloc. Default: prealloc
        file-allocation = "falloc";
        # No file allocation is made for files whose size is smaller than SIZE. Default: 5M
        no-file-allocation-limit = "8M";
        # Set log level to output to console. LEVEL is either debug, info, notice, warn or error. Default: notice
        # console-log-level=notice
        # Set log level to output. LEVEL is either debug, info, notice, warn or error. Default: debug
        # log-level=debug
        # The file name of the log file. If - is specified, log is written to stdout. If empty string("") is specified, or this option is omitted, no log is written to disk at all.
        # log=

        ### RPC ###
        # Enable JSON-RPC/XML-RPC server. Default: false
        enable-rpc = true;
        # Pause download after added. This option is effective only when --enable-rpc=true is given. Default: false
        # pause=false
        # Save the uploaded torrent or metalink meta data in the directory specified by --dir option. If false is given to this option, the downloads added will not be saved by --save-session option. Default: true
        # rpc-save-upload-metadata=true
        # Add Access-Control-Allow-Origin header field with value * to the RPC response. Default: false
        rpc-allow-origin-all = true;
        # Listen incoming JSON-RPC/XML-RPC requests on all network interfaces. If false is given, listen only on local loopback interface. Default: false
        rpc-listen-all = false;
        # Specify a port number for JSON-RPC/XML-RPC server to listen to. Possible Values: 1024 -65535 Default: 6800
        # rpc-listen-port=50100
        # Set RPC secret authorization token.
        # rpc-secret=
        # Use the certificate in FILE for RPC server. The certificate must be either in PKCS12 (.p12, .pfx) or in PEM format. When using PEM, you have to specify the private key via --rpc-private-key as well. Use --rpc-secure option to enable encryption.
        # rpc-certificate=
        # Use the private key in FILE for RPC server. The private key must be decrypted and in PEM format. Use --rpc-secure option to enable encryption.
        # rpc-private-key=
        # RPC transport will be encrypted by SSL/TLS. The RPC clients must use https scheme to access the server. For WebSocket client, use wss scheme. Use --rpc-certificate and --rpc-private-key options to specify the server certificate and private key.
        # rpc-secure=false

        ### HTTP/FTP/SFTP ###
        # The maximum number of connections to one server for each download. Default: 1
        max-connection-per-server = 16;
        # aria2 does not split less than 2*SIZE byte range. Possible Values: 1M -1024M. Default: 20M
        min-split-size = "8M";
        # Download a file using N connections. The number of connections to the same host is restricted by the --max-connection-per-server option. Default: 5
        split = 32;
        # Set user agent for HTTP(S) downloads. Default: aria2/$VERSION, $VERSION is replaced by package version.
        user-agent = "Transmission/2.77";

        ### BitTorrent ###
        # Save meta data as ".torrent" file. Default: false
        # bt-save-metadata=false
        # Set TCP port number for BitTorrent downloads. Multiple ports can be specified by using ',' and '-'. Default: 6881-6999
        listen-port = "50101-50109";
        # Set max overall upload speed in bytes/sec. 0 means unrestricted. Default: 0
        # max-overall-upload-limit=256K
        # Set max upload speed per each torrent in bytes/sec. 0 means unrestricted. Default: 0
        # max-upload-limit=0
        # Specify share ratio. Seed completed torrents until share ratio reaches RATIO. Specify 0.0 if you intend to do seeding regardless of share ratio. Default: 1.0
        seed-ratio = 0.1;
        # Specify seeding time in (fractional) minutes. Specifying --seed-time=0 disables seeding after download completed.
        seed-time = 0;
        # Enable Local Peer Discovery. If a private flag is set in a torrent, aria2 doesn't use this feature for that download even if true is given. Default: false
        # bt-enable-lpd=false
        # Enable IPv4 DHT functionality. It also enables UDP tracker support. If a private flag is set in a torrent, aria2 doesn't use DHT for that download even if true is given. Default: true
        enable-dht = true;
        # Enable IPv6 DHT functionality. If a private flag is set in a torrent, aria2 doesn't use DHT for that download even if true is given.
        enable-dht6 = true;
        # Set UDP listening port used by DHT(IPv4, IPv6) and UDP tracker. Default: 6881-6999
        dht-listen-port = "50101-50109";
        # Set host and port as an entry point to IPv4 DHT network.
        dht-entry-point = "dht.transmissionbt.com:6881";
        # Set host and port as an entry point to IPv6 DHT network.
        dht-entry-point6 = "dht.transmissionbt.com:6881";
        # Change the IPv4 DHT routing table file to PATH. Default: $HOME/.aria2/dht.dat if present, otherwise $XDG_CACHE_HOME/aria2/dht.dat.
        dht-file-path = "${config.home.homeDirectory}/.aria2/dht.dat";
        # Change the IPv6 DHT routing table file to PATH. Default: $HOME/.aria2/dht6.dat if present, otherwise $XDG_CACHE_HOME/aria2/dht6.dat.
        dht-file-path6 = "${config.home.homeDirectory}/.aria2/dht6.dat";
        # Enable Peer Exchange extension. If a private flag is set in a torrent, this feature is disabled for that download even if true is given. Default: true
        enable-peer-exchange = true;
        # Specify the prefix of peer ID. Default: A2-$MAJOR-$MINOR-$PATCH-. For instance, aria2 version 1.18.8 has prefix ID A2-1-18-8-.
        peer-id-prefix = "-TR2770-";
        # Specify the string used during the bitorrent extended handshake for the peer’s client version. Default: aria2/$MAJOR.$MINOR.$PATCH, $MAJOR, $MINOR and $PATCH are replaced by major, minor and patch version number respectively. For instance, aria2 version 1.18.8 has peer agent aria2/1.18.8.
        peer-agent = "Transmission/2.77";
        # Comma separated list of additional BitTorrent tracker's announce URI. Reference: https://github.com/ngosang/trackerslist/
        # bt-tracker=udp://tracker.coppersurfer.tk:6969/announce,udp://tracker.open-internet.nl:6969/announce,udp://tracker.leechers-paradise.org:6969/announce,udp://tracker.opentrackr.org:1337/announce,udp://9.rarbg.to:2710/announce,udp://9.rarbg.me:2710/announce,udp://tracker.openbittorrent.com:80/announce,udp://exodus.desync.com:6969/announce,http://tracker3.itzmx.com:6961/announce,http://tracker1.itzmx.com:8080/announce,udp://retracker.lanta-net.ru:2710/announce,udp://tracker.tiny-vps.com:6969/announce,udp://bt.xxx-tracker.com:2710/announce,udp://tracker2.itzmx.com:6961/announce,udp://tracker.torrent.eu.org:451/announce,udp://tracker.cyberia.is:6969/announce,http://tracker4.itzmx.com:2710/announce,http://open.acgnxtracker.com:80/announce,udp://explodie.org:6969/announce,http://retracker.mgts.by:80/announce
        # bt-tracker=udp://tracker.coppersurfer.tk:6969/announce,udp://tracker.leechers-paradise.org:6969/announce,udp://tracker.opentrackr.org:1337/announce,udp://9.rarbg.to:2710/announce,udp://exodus.desync.com:6969/announce,udp://tracker.openbittorrent.com:80/announce,udp://tracker.tiny-vps.com:6969/announce,udp://retracker.lanta-net.ru:2710/announce,udp://tracker.torrent.eu.org:451/announce,udp://tracker.cyberia.is:6969/announce,udp://torrentclub.tech:6969/announce,udp://open.stealth.si:80/announce,udp://denis.stalker.upeer.me:6969/announce,udp://tracker.moeking.me:6969/announce,udp://open.demonii.si:1337/announce,udp://ipv4.tracker.harry.lu:80/announce,udp://tracker3.itzmx.com:6961/announce,udp://explodie.org:6969/announce,udp://valakas.rollo.dnsabr.com:2710/announce,udp://tracker.nyaa.uk:6969/announce,udp://tracker.iamhansen.xyz:2000/announce,udp://tracker.filepit.to:6969/announce,udp://tracker-udp.gbitt.info:80/announce,udp://retracker.netbynet.ru:2710/announce,udp://retracker.akado-ural.ru:80/announce,udp://opentor.org:2710/announce,udp://tracker.yoshi210.com:6969/announce,udp://tracker.filemail.com:6969/announce,udp://tracker.ds.is:6969/announce,udp://newtoncity.org:6969/announce,udp://bt2.archive.org:6969/announce,udp://bt1.archive.org:6969/announce,https://tracker.fastdownload.xyz:443/announce,https://opentracker.xyz:443/announce,https://opentracker.co:443/announce,http://tracker.bt4g.com:2095/announce,http://opentracker.xyz:80/announce,http://open.trackerlist.xyz:80/announce,http://h4.trakx.nibba.trade:80/announce,udp://xxxtor.com:2710/announce,udp://tracker.uw0.xyz:6969/announce,udp://tracker.tvunderground.org.ru:3218/announce,udp://tracker.nextrp.ru:6969/announce,udp://tracker.msm8916.com:6969/announce,udp://tracker.lelux.fi:6969/announce,udp://retracker.sevstar.net:2710/announce,udp://npserver.intranet.pw:4201/announce,https://tracker.nanoha.org:443/announce,https://tracker.hama3.net:443/announce,http://www.proxmox.com:6969/announce,http://tracker.tvunderground.org.ru:3218/announce,http://tracker.opentrackr.org:1337/announce,http://tracker.bz:80/announce,http://torrentclub.tech:6969/announce,http://t.nyaatracker.com:80/announce,http://retracker.sevstar.net:2710/announce,http://open.acgtracker.com:1096/announce,http://explodie.org:6969/announce,udp://tracker4.itzmx.com:2710/announce,udp://tracker2.itzmx.com:6961/announce,udp://tracker.swateam.org.uk:2710/announce,udp://tr.bangumi.moe:6969/announce,udp://qg.lorzl.gq:2710/announce,udp://chihaya.toss.li:9696/announce,https://tracker.vectahosting.eu:2053/announce,https://tracker.lelux.fi:443/announce,https://tracker.gbitt.info:443/announce,https://opentracker.acgnx.se:443/announce,http://www.loushao.net:8080/announce,http://vps02.net.orel.ru:80/announce,http://tracker4.itzmx.com:2710/announce,http://tracker3.itzmx.com:6961/announce,http://tracker2.itzmx.com:6961/announce,http://tracker1.itzmx.com:8080/announce,http://tracker01.loveapp.com:6789/announce,http://tracker.yoshi210.com:6969/announce,http://tracker.torrentyorg.pl:80/announce,http://tracker.lelux.fi:80/announce,http://tracker.gbitt.info:80/announce,http://tracker.frozen-layer.net:6969/announce,http://sukebei.tracker.wf:8888/announce,http://pow7.com:80/announce,http://opentracker.acgnx.se:80/announce,http://open.acgnxtracker.com:80/announce,http://newtoncity.org:6969/announce,http://mail2.zelenaya.net:80/announce,http://bt-tracker.gamexp.ru:2710/announce,http://acg.rip:6699/announce
      };
    };
  };
}
