pushd $TOP

$options="BUILD_TESTS=0 CMAKE_CUSOM_BUILD_TESTS=0 NOS_RELEASE=master"

make $options force_cmake && make $options && make $options installer && make $options media && echo ALL GOOD

sshpass -p nutanix/4u scp $TOP/build/phoenix/images/svm/master/nutanix_installer_package.tar nutanix@$1:/home/nutanix

echo FINISHED
popd
