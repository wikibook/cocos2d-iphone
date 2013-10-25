//
//  AppDelegate.h
//  GameCenterEx
//
//  Created by Lee Jaewhan on 11. 9. 9..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@class GameCenterView;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow			*window;
    RootViewController	*viewController;
    GameCenterView      *gameCenterView;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GameCenterView *gameCenterView;

@end
