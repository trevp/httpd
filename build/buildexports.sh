#! /bin/sh

if test -z "$1"; then
    echo "USAGE: $0 SRCLIB-DIRECTORY"
    echo ""
    echo "for example: $0 ../srclib"
    exit 1
fi

echo "/* This is an ugly hack that needs to be here, so that libtool will"
echo " * link all of the APR functions into server regardless of whether"
echo " * the base server uses them."
echo " */"
echo ""

cur_dir="`pwd`"
for dir in $1/apr/include $1/apr-util/include
do
    cd $dir
    for file in *.h; do
        echo "#include \"$file\""
    done
    cd "$cur_dir"
done

echo ""
echo "const void *ap_ugly_hack;"
echo ""

# convert export files (on STDIN) into a series of declarations
my_dir="`dirname $0`"
awk -f "$my_dir/buildexports.awk"
