#/bin/bash

echo "======================================="
echo "===== AllJoyn installation script ====="
echo "===== Created By Jeffrey Blayney ======"
echo "======================================="
echo "Documentation Link 1: https://allseenalliance.org/framework/documentation/develop/building/ios-osx"
echo "Documentation Link 2: http://andreamazz.github.io/blog/2014/01/25/configuring-alljoyn-on-ios/"

echo ""
echo "Downloading AllJoyn Controlpanel 14.12"
echo ""
curl -LOk https://allseenalliance.org/releases/alljoyn/14.12/alljoyn-controlpanel-service-framework-14.12.00-ios-sdk-rel.zip

echo ""
echo "Downloading AllJoyn Core 15.04"
echo ""
curl -LOk https://allseenalliance.org/releases/alljoyn/15.04/alljoyn-15.04.00b-osx_ios-sdk.zip

echo ""
echo "Downloading AllJoyn Onboarding Framework 14.12"
echo ""
curl -LOk https://allseenalliance.org/releases/alljoyn/14.12/alljoyn-onboarding-service-framework-14.12.00-ios-sdk-rel.zip

echo ""
echo "Downloading AllJoyn Config Service Framework 14.12"
echo ""
curl -LOk https://allseenalliance.org/releases/alljoyn/14.12/alljoyn-config-service-framework-14.12.00-ios-sdk-rel.zip

echo ""
echo "Downloading AllJoyn Notification Service Framework 14.12"
echo ""
curl -LOk https://allseenalliance.org/releases/alljoyn/14.12/alljoyn-notification-service-framework-14.12.00-ios-sdk-rel.zip

echo ""
echo "Extracting Files"
echo ""
mkdir alljoyn-ios
mkdir alljoyn-ios/core
unzip alljoyn-15.04.00b-osx_ios-sdk.zip
mv alljoyn-15.04.00b-osx_ios-sdk alljoyn-ios/core/alljoyn
unzip alljoyn-config-service-framework-14.12.00-ios-sdk-rel.zip
unzip alljoyn-controlpanel-service-framework-14.12.00-ios-sdk-rel.zip
unzip alljoyn-notification-service-framework-14.12.00-ios-sdk-rel.zip
unzip alljoyn-onboarding-service-framework-14.12.00-ios-sdk-rel.zip

rm alljoyn-15.04.00b-osx_ios-sdk.zip
rm alljoyn-config-service-framework-14.12.00-ios-sdk-rel.zip
rm alljoyn-controlpanel-service-framework-14.12.00-ios-sdk-rel.zip
rm alljoyn-notification-service-framework-14.12.00-ios-sdk-rel.zip
rm alljoyn-onboarding-service-framework-14.12.00-ios-sdk-rel.zip 

echo ""
echo "Configuring OpenSSL"
echo ""
pushd alljoyn-ios
git clone https://github.com/openssl/openssl.git
git clone https://github.com/sqlcipher/openssl-xcode.git
cp -r openssl-xcode/openssl.xcodeproj openssl
pushd openssl
git checkout tags/OpenSSL_1_0_1f #replace this with a newer version as available
sed -ie 's/\(ONLY_ACTIVE_ARCH.*\)YES/\1NO/' openssl.xcodeproj/project.pbxproj
xcodebuild -configuration Release -sdk iphonesimulator
xcodebuild -configuration Release -sdk iphoneos
xcodebuild -configuration Release
xcodebuild -configuration Debug -sdk iphonesimulator
xcodebuild -configuration Debug -sdk iphoneos
xcodebuild -configuration Debug
popd
popd

# This is necessary to allow XCODE to view the Environment variables that are set.
defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO

mv alljoyn-ios alljoyn-sdk
pushd alljoyn-sdk
pushd openssl
export OPENSSL_ROOT=`pwd`
launchctl setenv OPENSSL_ROOT `pwd`
popd
popd

echo ""
echo "Setting up default paths"
echo ""
cd alljoyn-sdk
launchctl setenv ALLJOYN_SDK_ROOT `pwd`
cd services
launchctl setenv ALLSEEN_BASE_SERVICES_ROOT `pwd`

chmod -R 777 ~/AllJoyn

echo "============================================================="
echo "AllJoyn dependent libraries are now fully setup in ~/AllJoyn!"
echo "============================================================="
