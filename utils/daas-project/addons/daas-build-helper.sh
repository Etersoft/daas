#!/bin/sh

[ -n "$DAAS_DEBUG" ] && set -x

[ -z "$DATADIR" ] && DATADIR=.
[ -z "$SRCDIR" ] && SRCDIR=${DATADIR}/src
[ -z "$SOURCE" ] && SOURCE=${DATADIR}/source.tar
[ -z "$BUILD_USER" ] && BUILD_USER=builder

case $1 in
    prepare)
        mkdir -p $SRCDIR
        chown $BUILD_USER:$BUILD_USER $SRCDIR

        if [ "$UID" == "0" ]; then
            su - -c "tar xf $SOURCE -C $SRCDIR" $BUILD_USER
        else
            tar xf $SOURCE -C $SRCDIR
        fi
        exit $?
    ;;

    *)
        echo "Unknown command. Use [prepare]"
        exit 1
    ;;
esac
