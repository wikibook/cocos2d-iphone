//
//  AppDelegate.h
//  ParallaxNodeEx3
//
//  Created by Lee Jaewhan on 11. 9. 3..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow			*window;
    RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
