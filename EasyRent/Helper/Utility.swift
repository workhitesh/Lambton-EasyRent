//
//  Utility.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import UIKit

final class Utility {
    static var appDel = UIApplication.shared.delegate as! AppDelegate
    
    class func isPostalCodeValid(_ code:String) -> Bool {
        var isValidArr = [Bool]() // array where we will add all results and use to determine at the end if validation is true or not
        for i in 0..<code.count {
            let char = code[i]
            // check if even
            if i%2 == 0 {
                // check if all alphabets
                isValidArr.append(char.isOnlyAlphabet)
            } else {
                // check if all numbers
                isValidArr.append(char.isOnlyNumbers)
            }
        }
        // array should not contain any false && postal code count should be 6
        return !isValidArr.contains(false) && isValidArr.count == 6
    }
    
    
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
    /*
    class func showAlert(with message:String, on controller:UIViewController) {
        let alertVC = UIAlertController(title: Messages.APPNAME, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(ok)
        controller.present(alertVC, animated: true, completion: nil)
    }
    */
    
    class func showLoader(){
//        SVProgressHUD.show()
    }
    
    class func hideLoader(){
//        SVProgressHUD.dismiss()
    }
    
    class func saveUD(_ value:Any?, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getUD(_ key:UserDefaultKeys) -> Any?{
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    class func removeUD(_ key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class var currentTimestamp: Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
}
