//
//  iAdView.h
//  PoorBallboy
//
//  Created by mac on 10. 11. 4..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <iAd/iAd.h>

@protocol ADBannerViewDelegate;

@interface iAdView : CCScene
                    <ADBannerViewDelegate>
{

}

@end
