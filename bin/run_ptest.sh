ORIGINAL_TOOLCHAIN="$TOP/../toolchain-builds"
TMP_TOOLCHAIN="/home/tallen/tchain.tmp"
SYMLINK_LOC="$TOP/../toolchain-builds"
SYMLINK_CMD="ln -s /mnt/toolchain-builds $SYMLINK_LOC"

mv $ORIGINAL_TOOLCHAIN $TMP_TOOLCHAIN
$SYMLINK_CMD
python -u $TOP/qa/tools/ptest/ptest.py -I \
  $HOME/.ssh/ptest_local_key -o "-V -R $1"
rm $SYMLINK_LOC
cp $TMP_TOOLCHAIN $ORIGINAL_TOOLCHAIN
