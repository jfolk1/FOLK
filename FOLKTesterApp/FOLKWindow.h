//
//  FOLKWindow.h
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

#ifndef FOLKWindow_h
#define FOLKWindow_h

#import <UIKit/UIKit.h>

@protocol FOLKWindowEventDelegate //<NSObject>

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow;
- (BOOL)canBecomeKeyWindow;

@end

#pragma mark -
@interface FOLKWindow : UIWindow

@property (nonatomic, weak) id <FOLKWindowEventDelegate> eventDelegate;

/// Tracked so we can restore the key window after dismissing a modal.
/// We need to become key after modal presentation so we can correctly capture input.
/// If we're just showing the toolbar, we want the main app's window to remain key
/// so that we don't interfere with input, status bar, etc.
@property (nonatomic, readonly) UIWindow *previousKeyWindow;

@end

#endif /* FOLKWindow_h */
