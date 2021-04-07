import Flutter
import UIKit
import Security

public class SwiftKeychainReaderPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "keychain_reader", binaryMessenger: registrar.messenger())
        let instance = SwiftKeychainReaderPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        var query = [String: Any]()
        query[kSecReturnData as String] = true
        query[kSecReturnAttributes as String] = true
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = "flutter_keychain"
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        
        var keyResult: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &keyResult)
        
        if status == errSecSuccess {
            let item = keyResult as! [[String:Any]]
            var results:[[String:Any]] = []
            for result in item {
                var resultItem:[String:Any] = [:]
                resultItem["data"] = String(decoding: (result[kSecValueData as String] as! Data), as: UTF8.self)
                for (key, value) in result {
                  if let data = value as? String {
                    resultItem[key] = data
                  }
                }
                results.append(resultItem)
            }
            result(results)
        } else {
            result([])
        }
    }
}
