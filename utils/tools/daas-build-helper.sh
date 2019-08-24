#!/bin/sh

[ -n "$DAAS_DEBUG" ] && set -x

[ -z "$DATADIR" ] && DATADIR=.
[ -z "$SRCDIR" ] && SRCDIR=${DATADIR}/src
[ -z "$SOURCE" ] && SOURCE=${DATADIR}/source.tar
[ -z "$BUILD_USER" ] && BUILD_USER=builder

case $1 in
    prepare)
        if [ "$UID" == "0" ]; then
            su - -c "mkdir -p $SRCDIR" $BUILD_USER
            su - -c "tar xf $SOURCE -C $SRCDIR" $BUILD_USER
        else
            mkdir -p $SRCDIR
            tar xf $SOURCE -C $SRCDIR
        fi

        exit $?
    ;;

    exec)
		[ -z "$DAAS_EXEC" ] && echo "Unknown exec command. Use DAAS_EXEC=''" && exit 1
		exec $DAAS_EXEC
    ;;

    *)
        echo "Unknown command. Use [prepare]"
        exit 1
    ;;
esac
