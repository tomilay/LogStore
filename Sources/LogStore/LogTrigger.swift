//
//  File.swift
//  
//
//  Created by Thomas Nyongesa on 4/12/24.
//

import UIKit
import CoreMotion

public class LogTrigger {
    
    let window: UIWindow?
    let motionManager = CMMotionManager()
    
    public init(in window: UIWindow?) {
        self.window = window
        
        motionManager.startAccelerometerUpdates(to: .main) {
            [weak self] data, error in
            
            guard let data = data else { return }
            let now = self?.displayTimeStamp()
            if data.acceleration.x < -5 {
                printLog("\(now!): x acceleration: \(data.acceleration.x)")
                self?.presentLog()
            }
        }
    }
    
    func displayTimeStamp() -> String {
        let date = NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970)
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        return formatter.string(from: date as Date)
    }

    func presentLog() {
      let visible = visibleViewController(from: window?.rootViewController)
      let logViewController = LogViewController()
      visible?.present(logViewController, animated: true)
    }
    
    func visibleViewController(
      from viewController: UIViewController?) -> UIViewController? {

      if let navigationController =
        viewController as? UINavigationController {

        return visibleViewController(
          from: navigationController.topViewController)
      }
      if let tabBarController =
        viewController as? UITabBarController {

        return visibleViewController(
          from: tabBarController.selectedViewController)
      }
      if let presentedViewController =
        viewController?.presentedViewController {

        return visibleViewController(
          from: presentedViewController)
      }

      return viewController
    }
}

