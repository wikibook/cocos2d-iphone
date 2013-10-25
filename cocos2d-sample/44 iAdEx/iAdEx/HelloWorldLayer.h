//
//  HelloWorldLayer.h
//  iAdEx
//
//  Created by Lee Jaewhan on 11. 9. 18..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "cocos2d.h"
#import "iAdView.h"
#import <iAd/iAd.h>

@interface HelloWorldLayer : CCLayer
{
	iAdView *iadScene;
}

@property (nonatomic, retain) iAdView *iadScene;

+ (CCScene *)scene;

@end
