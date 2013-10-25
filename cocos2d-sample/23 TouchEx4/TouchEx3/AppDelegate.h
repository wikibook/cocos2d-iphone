//
//  AppDelegate.h
//  TouchEx3
//
//  Created by Lee Jaewhan on 11. 8. 3..
//  Copyright __MyCompanyName__ 2011년. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
