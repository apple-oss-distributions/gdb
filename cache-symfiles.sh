#! /bin/sh

if [ `id -u` != "0" ]; then
    echo "This program must be run as root."
    exit 1
fi

dir=/usr/libexec/gdb/symfiles
gdb=/usr/bin/gdb

echo -n "Removing current cache ... "
rm -rf "$dir"
mkdir -p "$dir"
echo "done"

echo -n "Finding libraries ... "

libs="/usr/lib/dyld"

for i in \
    /System/Library/Frameworks/*.framework \
    /System/Library/PrivateFrameworks/*.framework \
    /System/Library/Frameworks/*.framework/Frameworks/*.framework \
    /System/Library/PrivateFrameworks/*.framework/Frameworks/*.framework \
    ; do
    name=`basename $i .framework`
    if [ -f $i/$name ]; then
	libs="$libs $i/$name"
    fi
done 

for i in \
    `find /usr/lib -name lib\*.dylib -type f` \
    /System/Library/Frameworks/*.framework/Libraries/*.dylib \
    ; do
    name=`basename $i .dylib`
    name=`echo $name | sed -e 's/\.[ABC]$//' -e 's/^lib//'`
    libs="$libs $i"
done 

echo "done"

for i in $libs; do
    echo "sharedlibrary cache-symfile $i $dir" >> /tmp/syms_$$.gdb
done

echo -n "Processing libraries ... "
$gdb -nx --batch --command=/tmp/syms_$$.gdb
echo "done"

rm "/tmp/syms_$$.gdb"
rm "${dir}/dyld.syms"
