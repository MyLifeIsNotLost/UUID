//
//  copye.swift
//  SQLITE
//

import UIKit
import KeychainStore

public struct UUIDManager {
    //单例类
    fileprivate static let p = UDCV(uuidStr: "")
    
    //获取设备UUID
    static func ValueStr() -> String{
        return p.obtainObjecValue()
    }
    
    fileprivate init() {
        
    }
}

private class UDCV: NSObject,NSCoding {
    private var uuidStr : String?
    
    public func obtainObjecValue() -> String {
        let store = try? KeychainStore<UDCV>(account: Bundle.main.bundleIdentifier ?? "")
        do {
            let obj = try store?.object(forKey: "A9DB8708-3989-43F2-9D26-8E6B788FB6EB-20170506\(Bundle.main.bundleIdentifier ?? "")")
            //判断Keychain是否存储UUID,若没有生成并存储
            if (obj?.uuidStr?.isEmpty) ?? true {
                let uuid_string = UIDevice.current.identifierForVendor?.uuidString
                uuidStr = uuid_string
                try? store?.set(object: self, forKey: "A9DB8708-3989-43F2-9D26-8E6B788FB6EB-20170506\(Bundle.main.bundleIdentifier ?? "")")
                return uuid_string ?? "Access error"
            }else
            {
                return obj?.uuidStr ?? "Access error"
            }
            
        } catch  {
            print(error)
        }
        return "Access error"
    }
    init(uuidStr: String) {
        self.uuidStr = uuidStr
    }
    
    /***
     *实现 NSCoding protocol
     */
    required convenience init?(coder aDecoder: NSCoder) {
        guard let uuidStr = aDecoder.decodeObject(forKey: "uuidStr") as? String else { return nil }
        self.init(uuidStr: uuidStr)
    }
    
    fileprivate  func encode(with aCoder: NSCoder) {
        aCoder.encode(uuidStr, forKey: "uuidStr")
    }
}
