//
//  FOLKExplorerViewController.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

import UIKit

protocol FOLKHierarchyDelegate {
    func viewHierarchyDidDismiss(_ selectedView:UIView)
}

protocol FOLKExplorerViewControllerDelegate {
    func explorerViewControllerDidFinish(_ explorerViewController:FOLKExplorerViewController)
}

class FOLKExplorerViewController : UIViewController, FOLKHierarchyDelegate, UIAdaptivePresentationControllerDelegate {
    func viewHierarchyDidDismiss(_ selectedView: UIView) {
        print("HI")
    }
    var delegate:FOLKExplorerViewControllerDelegate?
    private var viewsAtTapPoint: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectionTap(_:))))
    }
    @objc private func handleSelectionTap(_ sender: UITapGestureRecognizer) {
        let tapPointInView = sender.location(in: self.view)
        let tapPointInWindow = self.view.convert(tapPointInView, to: nil)
        self.updateOutlineViewsForSelectionPoint(tapPointInWindow)
    }
    
    private func updateOutlineViewsForSelectionPoint(_ selectionPointInWindow: CGPoint) {
        print("The views selected...")
        let views:NSArray = self.viewsAtPoint(selectionPointInWindow, false)
        
        for view in views {
            let t = type(of: view)
            print(t)
        }
        
        
    }
    
    private func viewsAtPoint(_ tapPointInWindow: CGPoint, _ skipHidden: Bool) -> NSArray {
        var views = NSMutableArray()
        for window in FOLKUtility.allWindows {
            if(window != self.view.window && window.point(inside: tapPointInWindow, with: nil)) {
                views.add(window)
                views.addObjects(from: self.recursiveSubviewsAtPoint(tapPointInWindow, window, skipHidden) as! [Any])
                
            }
        }
        return views
    }
    
    private func recursiveSubviewsAtPoint(_ pointInView: CGPoint, _ view:UIView, _ skipHidden:Bool) -> NSArray {
        var subviewsAtPoint = NSMutableArray()
        for subview in view.subviews {
            let isHidden = subview.isHidden || subview.alpha < 0.01
            if skipHidden && isHidden {
                continue
            }
            
            let subviewContainsPoint = subview.frame.contains(pointInView)
            if subviewContainsPoint {
                subviewsAtPoint.add(subview);
            }
            
            if(subviewContainsPoint || !subview.clipsToBounds) {
                let pointInSubview = view.convert(pointInView, to: subview)
                subviewsAtPoint.addObjects(from: self.recursiveSubviewsAtPoint(pointInSubview, subview, skipHidden) as! [Any])
            }
            
        }
        return subviewsAtPoint
    }
    
}
