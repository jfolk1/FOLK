//
//  FOLKUtility.h
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

#ifndef FOLKUtility_h
#define FOLKUtility_h

#import <Availability.h>
#import <AvailabilityInternal.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface FOLKUtility : NSObject

@property (nonatomic, readonly, class) UIWindow *appKeyWindow;
@property (nonatomic, readonly, class) NSArray<UIWindow *> *allWindows;

@end

#endif /* FOLKUtility_h */
