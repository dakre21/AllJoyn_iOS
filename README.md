# AllJoyn_iOS
This repository contains a build script for alljoyn's iOS IoT Framework. 

## Installation steps for building and running Alljoyn's samples in Objective C
1. Run the script "sudo ./alljoyn-steup.sh" will do the trick-- Note: this script will take awhile due to pulling in a large amount of data over the network; so be prepaired to wait approximately 5-10 minutes depending on the network conditions.
2. Afterwards navigate to the samples directory (the path will look something similar to this: /alljoyn-sdk/core/alljoyn/alljoyn_objc/samples/iOS). If there's any problems opening the project due to permissions, recursively change the files permissions to read and write for everyone by running "sudo chmod 777 [file_name]".
3. After selecting a sample project change the openssl linker tag from— "$(OPENSSL_ROOT)/build/$(CONFIGURATION)-$(PLATFORM_NAME)” to "${SRCROOT}/../../../../../../openssl/build/$(CONFIGURATION)-$(PLATFORM_NAME)". The reason for this is that iOS versions later than iOS 7 cannot recognize the OPENSSL_ROOT global variable within xcode; so we chose to use SRCROOT and re-direct the path to the openssl folder.
4. Change the latest iOS Deployment Target under the project to the latest iOS version (currently iOS 9.2)— Note: this should remove depreciated warnings throughout the sample project

## Instructions to building your own project using AllJoyn
1. Follow step 1 above
2. Create a new project in Objective C (Unfortunately Swift Bridge Header Files cannot be used with Alljoyn's framework in ObjC and ObjC++)
3. Make sure the project is save in the same hierarchical project level as the alljoyn-sdk (it's okay if it's not but the path to directories in the project settings will have to be modified) 
4. Perform the following steps in the project settings:
  a) In the "Other Linker Flags" field add the following flags:
    i) -lalljoyn
    ii) -lajrouter
    iii) -lssl
    iv) -lcrypto
  b) In the header search paths field(s) add to debug/release:
    i) "$(SRCROOT)/../alljoyn-sdk/core/alljoyn/build/darwin/$(CURRENT_ARCH)/$(PLATFORM_NAME)/$(CONFIGURATION)/dist/cpp/inc"
    ii) "$(SRCROOT)/../alljoyn-sdk/core/alljoyn/build/darwin/arm/$(PLATFORM_NAME)/$(CONFIGURATION)/dist/cpp/inc"
    iii) "$(SRCROOT)/../alljoyn-sdk/core/alljoyn/build/darwin/arm/$(PLATFORM_NAME)/$(CONFIGURATION)/dist/cpp/inc/alljoyn"
  c) In the library search paths field(s) add to debug/release:
    i) $(inherited)
    ii) "${SRCROOT}/../alljoyn-sdk/openssl/build/$(CONFIGURATION)-$(PLATFORM_NAME)"
    iii) "$(SRCROOT)/../alljoyn-sdk/core/alljoyn/build/darwin/$(CURRENT_ARCH)/$(PLATFORM_NAME)/$(CONFIGURATION)/dist/cpp/lib"
    iv) "$(SRCROOT)/../alljoyn-sdk/core/alljoyn/build/darwin/arm/$(PLATFORM_NAME)/$(CONFIGURATION)/dist/cpp/lib"
  d) Finally in the custom compiler flags section under "Other C Flags" add to debug:
    i) -DQCC_OS_GROUP_POSIX
    ii) -DQCC_OS_DARWIN
  e) Same as above except for release add:
    i) -DQCC_OS_GROUP_POSIX
    ii) -DQCC_OS_DARWIN
    iii) -DNS_BLOCK_ASSERTIONS=1
5. Next add the AllJoynFramework files to the new project (path directory will be similar to this: alljoyn-sdk/core/alljoyn/alljoyn_objc/AllJoynFramework/AllJoynFramework). Note: Make sure to copy items if needed, this will actually add the files to the project to be compiled instead of referencing them.
6. Disable bitcode (Bitcode is an intermediate representation of a compiled program which enables Apple to resize the application if necessary in the app store)
7. Change the architectures to $(ARCHS_STANDARD_32_BIT)
8. Lastly under the section language C++ change the following:
  a) Enable C++ Exceptions to NO
  b) Enable C++ Runtime Types to NO

## StarterAlljoyn Project
- This is a blank project that utilizes Alljoyn's IoT framework
- Feel free to use it as a reference to get started or fork the project and hack at it. 
- ** Remember to run the alljoyn script to generate the appropraite AllJoyn files (must have alljoyn-sdk in the same project hierarchy as the StarterAllJoyn project to work... otherwise you're going to have to make some modifications to the project settings)

## Acknowledgements
- Special thanks to Jeff Blayney for creating the alljoyn script. Details of what the script does can be found at this location: https://allseenalliance.org/framework/documentation/develop/building/ios-osx. We slimmed it out to exclude some of the pre-existing shell commands (ie. OPENSSL_ROOT command does not exist inside of the shell script).
- AllJoyn is an open source IoT software solution and their licensing can be found here: https://allseenalliance.org/license

## Contributors
- Jeff Blayney and David Akre
