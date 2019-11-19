//
//  UIApplication+KMNameSpace.swift
//  KMNameSpace
//
//  Created by MAC  on 2019/11/18.
//  Copyright © 2019 KM. All rights reserved.
//

import UIKit

extension AppDelegate: KMKitNamespaceWrappable {}

let NightViewTag = 98765

let UserDefaultFirstInstallKey = "TJKMHFirstInstall"


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == AppDelegate {
    
    private func getVisableViewController() -> UIViewController? {
        
        guard var vc = self.kmWrappedValue.window?.rootViewController else {
            return nil
        }
        while vc.presentingViewController != nil {
            vc = vc.presentingViewController!
        }
        
        if vc.isKind(of: UINavigationController.classForCoder()) {
            let nav = vc as! UINavigationController
            guard let navVisableVC = nav.visibleViewController else {
                return nil
            }
            vc = navVisableVC
        }
        
        if  vc.isKind(of: UITabBarController.classForCoder()) {
            let tab = vc as! UITabBarController
            guard let tabVisableVC = tab.selectedViewController else
            {
                return nil
            }
            vc = tabVisableVC
        }
        
        return vc
    }
    
    static func getVisableView() -> UIView{
        guard let vc = getVisableViewController() else {
            return UIApplication.shared.keyWindow!
        }
        return vc.tabBarController?.view ?? vc.view
    }
    
    static func getVisableViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.km.getVisableViewController()
    }
    
    static func getRootViewController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window?.rootViewController
    }
    
    static func getNavigationController(closure: @escaping (UINavigationController?) -> Void) {
       
        var tmpVC: UIViewController = self.getVisableViewController()!
        
        if (tmpVC is UITabBarController) {
            tmpVC = (tmpVC as! UITabBarController).selectedViewController!
        }
        
        
        if tmpVC.isKind(of: NSClassFromString("UISnapshotModalViewController")!){
            tmpVC = tmpVC.value(forKey:"parentController") as! UIViewController
        }
        
        if tmpVC is UINavigationController{
            closure(tmpVC as? UINavigationController)
            return
        }
        
        if let navc = tmpVC.navigationController {
            closure(navc)
            return
        }
        
        if tmpVC.presentingViewController != nil {
            tmpVC.dismiss(animated: true) {
                self.getNavigationController(closure: closure)
            }
        }
        return
    }
    
    
    
    
}




extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == AppDelegate {
        

    private static func chooseRootViewController() -> UIViewController {
//        return KMHNavigationViewController(rootViewController: KMHTabBarViewController())
//        let version = AppInfoManager.appVersion
//        if let lastVersion = GPGET("KMHCurVersion") as? String, lastVersion == version {
//            return KMHNavigationViewController(rootViewController: KMHTabBarViewController())
//        } else {
//            ///显示引导
//            GPSET(version, "KMHCurVersion")
//            return KMHNavigationViewController(rootViewController: KMHTabBarViewController())
//            return PageGuideViewController()
//        }
        return UINavigationController(rootViewController: UIViewController())
    }
        
    static func updateRootViewController() {
        self.shared.window?.rootViewController = self.chooseRootViewController()
    }
        
    static let shared = UIApplication.shared.delegate as! AppDelegate
        
    static func gotoHomeWithSelectedIndex(selectedIndex:Int,resetValue:Dictionary<String,Any>?){
        
        if let vc = self.getRootViewController(){
            if vc.isKind(of: UINavigationController.self){
                let rootNav = vc as! UINavigationController
                
                getNavigationController { nav in
                    
                    if rootNav == nav {
                        
                        if rootNav.viewControllers.count > 1{
                            rootNav.popToRootViewController(animated: true)
                        }
                        
                        if rootNav.viewControllers.first!.isKind(of: UITabBarController.self){
                            let tabbar = rootNav.viewControllers.first as! UITabBarController
                            if selectedIndex < tabbar.viewControllers!.count{
                                tabbar.selectedIndex = selectedIndex
                            }
                        }
                                                
                    } else {
                        
                        if (nav?.presentingViewController != nil) {
                            nav?.dismiss(animated: false, completion: {
                                self.gotoHomeWithSelectedIndex(
                                    selectedIndex: selectedIndex,
                                    resetValue: nil
                                )
                            })
                        }
                    }
                    
                }

            }
            
        }
    }
    
}



extension UIApplication: KMKitNamespaceWrappable {}


extension KMKitNamespaceWrapper where KMKitNameSpaceWrapperType == UIApplication {
    

    var documentsURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    var documentsPath: String {
        NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    

    
    
    var cachesURL: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last!
    }
    
    var cachesPath: String {
        NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    


    var libraryURL: URL {
        FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last!
    }
    
    var libraryPath: String {
        NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    }
    
    
    
    /// Application's Bundle Name (show in SpringBoard).
    var bundleName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    /// Application's Bundle ID.  e.g. "com.km.kmh"
    var bundleID: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }
    
    /// Application's Version.  e.g. "1.2.0"
    var appVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// Application's Build number. e.g. "123"
    var appBuildVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    /// 该应用是否是盗版应用？？？ 正版是从App store下载的
    var isPirated: Bool {
        
//        if UIDevice.current.isSimulator return true

        
        /// process ID shouldn't be root
        if getgid() <= 10 {
            return true
        }
        
        if let _ = Bundle.main.infoDictionary?["SignerIdentity"] {
            return true
        }
        
        return false
        

//        if (![self _yy_fileExistInMainBundle:@"_CodeSignature"]) {
//            return YES;
//        }
//
//        if (![self _yy_fileExistInMainBundle:@"SC_Info"]) {
//            return YES;
//        }
//
//        //if someone really want to crack your app, this method is useless..
//        //you may change this method's name, encrypt the code and do more check..
//        return NO;
    }
}







