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
    
    class func showAlert(with message:Messages, on controller:UIViewController) {
        let alertVC = UIAlertController(title: APP_NAME, message: message.rawValue, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(ok)
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    class func showLoader(on:UIViewController){
        let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loader.frame.origin.x = on.view.center.x - 20
        loader.frame.origin.y = on.view.center.y - 20
        loader.style = .large
        loader.color = .black
        loader.tag = 999
        loader.hidesWhenStopped = true
        on.view.addSubview(loader)
        loader.startAnimating()
    }
    
    class func hideLoader(from:UIViewController){
        for case let loader as UIActivityIndicatorView in from.view.subviews {
            if loader.tag == 999 {
                loader.stopAnimating()
                loader.removeFromSuperview()
            }
        }
    }
    
    class func saveUD(_ value:Any?, key:UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
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
