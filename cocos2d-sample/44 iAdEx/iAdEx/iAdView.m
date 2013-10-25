//
//  iAdView.m
//  PoorBallboy
//
//  Created by mac on 10. 11. 4..
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iAdView.h"


@implementation iAdView

- (id)init
{
    if ( (self=[super init]) ) {

		UIViewController *controller = [[UIViewController alloc]init];
		
		controller.view.frame = [[UIScreen mainScreen]bounds];
		
		ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 430, 320, 50)];
		
		adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
		
		adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
		
		[controller.view addSubview:adView];

		[[[CCDirector sharedDirector] openGLView] addSubview:controller.view];

	}
	return self;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		
	// assumes the banner view is at the top of the screen.
		
	banner.frame = CGRectOffset(banner.frame, 0, -50);
		
	[UIView commitAnimations];
}

@end
