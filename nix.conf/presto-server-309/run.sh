launcher run --etc-dir=/home/op/my-env/nix.conf/presto-server-309 \
             --node-config=/home/op/my-env/nix.conf/presto-server-309/node.properties \
             --config=/home/op/my-env/nix.conf/presto-server-309/config.properties \
             --data-dir=/tmp/tgz.presto-server-309.d/run/data \
             --pid-file=/tmp/tgz.presto-server-309.d/run/launcher.pid \
             --launcher-log-file=/tmp/tgz.presto-server-309.d/run/log/launcher.log \
             --server-log-file=/tmp/tgz.presto-server-309.d/run/log/server.log


  -v, --verbose         Run verbosely
  --etc-dir=DIR         Defaults to INSTALL_PATH/etc
  --launcher-config=FILE
                        Defaults to INSTALL_PATH/bin/launcher.properties
  --node-config=FILE    Defaults to ETC_DIR/node.properties
  --jvm-config=FILE     Defaults to ETC_DIR/jvm.config
  --config=FILE         Defaults to ETC_DIR/config.properties
  --log-levels-file=FILE
                        Defaults to ETC_DIR/log.properties
  --data-dir=DIR        Defaults to INSTALL_PATH
  --pid-file=FILE       Defaults to DATA_DIR/var/run/launcher.pid
  --launcher-log-file=FILE
                        Defaults to DATA_DIR/var/log/launcher.log (only in
                        daemon mode)
  --server-log-file=FILE
                        Defaults to DATA_DIR/var/log/server.log (only in
                        daemon mode)
  -D NAME=VALUE         Set a Java system property

