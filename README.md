# AllJoyn_iOS
This repository contains a build script for alljoyn's iOS IoT Framework. 

## Installation steps for building and running Alljoyn's samples in Objective C
1. Run the script "sudo ./alljoyn-steup.sh" will do the trick-- Note: this script will take awhile due to pulling in a large amount of data over the network; so be prepaired to wait approximately 5-10 minutes depending on the network conditions.
2. Afterwards navigate to the samples directory (the path will look something similar to this: /alljoyn-sdk/core/alljoyn/alljoyn_objc/samples/iOS).
3. After selecting a sample project change the openssl linker tag from— "$(OPENSSL_ROOT)/build/$(CONFIGURATION)-$(PLATFORM_NAME)” to "${SRCROOT}/../../../../../../openssl/build/$(CONFIGURATION)-$(PLATFORM_NAME)". The reason for this is that iOS versions later than iOS 7 cannot recognize the OPENSSL_ROOT global variable within xcode; so we chose to use SRCROOT and re-direct the path to the openssl folder.
4. Change the latest iOS Deployment Target under the project to the latest iOS version (currently iOS 9.2)— Note: this should remove depreciated warnings throughout the sample project
