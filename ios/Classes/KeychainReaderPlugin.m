#import "KeychainReaderPlugin.h"
#if __has_include(<keychain_reader/keychain_reader-Swift.h>)
#import <keychain_reader/keychain_reader-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "keychain_reader-Swift.h"
#endif

@implementation KeychainReaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftKeychainReaderPlugin registerWithRegistrar:registrar];
}
@end
