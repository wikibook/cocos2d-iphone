//
//  HelloWorldLayer.m
//  ScheduleEx
//
//  Created by Lee Jaewhan on 11. 8. 2..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

- (void)dealloc
{
    [super dealloc];
}

+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];

    HelloWorldLayer *layer = [HelloWorldLayer node];

    [scene addChild: layer];

    return scene;
}

- (id)init
{
    if( (self=[super init])) {

        [self schedule:@selector(callEveryFrame:) ];
        [self schedule:@selector(tick:) interval:1.0 ];

    }
    return self;
}

- (void)callEveryFrame:(ccTime)dt
{
    NSLog(@"fps");
}

- (void)tick:(ccTime)dt
{
    NSLog(@"tick");
}


@end
