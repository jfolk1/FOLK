//
//  FOLKManager.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

import Foundation


class FOLKManager : FOLKExplorerViewControllerDelegate, FOLKWindowEventDelegate {
    internal func shouldHandleTouch(at pointInWindow: CGPoint) -> Bool {
        return true
    }
    
    internal func canBecomeKeyWindow() -> Bool {
        return true
    }
    
    internal func explorerViewControllerDidFinish(_ explorerViewController: FOLKExplorerViewController) {
        
    }
    private var folkExplorerWindow: FOLKWindow?
    private var folkExplorerViewController: FOLKExplorerViewController?
    
    public static let shared = FOLKManager()
    
    private init(){}
    
    private func explorerViewController() -> FOLKExplorerViewController {
        if(self.folkExplorerViewController == nil) {
            self.folkExplorerViewController = FOLKExplorerViewController();
            self.folkExplorerViewController!.delegate = self
        }
        return self.folkExplorerViewController!
    }
    
    public func showExplorer() {
        let folk = self.explorerWindow();
        folk.isHidden = false
        
        guard #available(iOS 13, *) else {
            return
        }
        
        if nil == folk.windowScene {
            folk.windowScene = FOLKUtility.appKeyWindow.windowScene;
        }
    }
    
    private func explorerWindow() -> FOLKWindow {
        assert(Thread.isMainThread, "You must use \(NSStringFromClass(type(of: self))) from the main thread only.")
        
        if nil == folkExplorerWindow {
            let w : FOLKWindow = FOLKWindow.init(frame: FOLKUtility.appKeyWindow.bounds)
            w.eventDelegate = self
            w.rootViewController = self.explorerViewController()
            
            folkExplorerWindow = w
        }
        return folkExplorerWindow!
    }
}
