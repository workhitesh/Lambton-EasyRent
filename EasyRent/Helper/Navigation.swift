//
//  Navigation.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import UIKit
import SideMenu

class Navigation:NSObject {
    // shared instance
    static let instance = Navigation()
    private override init() {
        
    }
    
    func setupHomeScreen(navVC:UINavigationController){
        // check if already logged in
//        if let isLogin = Utility.getUD(.isLogin) as? Bool, isLogin {
//
//        } else {
            // not logged in, show user the screen to sign in first
        
//        }
        
        
        // Define the menus
        guard let sideMenuVC = grabController(name: .SideMenuVC) as? SideMenuVC else {
            return
        }
//        let menuNav = UINavigationController(rootViewController: sideMenuVC)
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: sideMenuVC)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.menuWidth = UIScreen.main.bounds.width - 90

        // Setup gestures: the left and/or right menus must be set up (above) for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navVC.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navVC.view)

        // (Optional) Prevent status bar area from turning black when menu appears:
        leftMenuNavigationController.statusBarEndAlpha = 0
//        navVC.isNavigationBarHidden = false
        navVC.present(leftMenuNavigationController, animated: true)
        
    }
    
    func grabController(name:Controllers) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name.rawValue)
        return vc
    }
    
    func pop(vc:UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
    
    func push(to vc:Controllers, from:UIViewController){
        let vcToPush = grabController(name: vc)
        from.navigationController?.pushViewController(vcToPush, animated: true)
    }
}
