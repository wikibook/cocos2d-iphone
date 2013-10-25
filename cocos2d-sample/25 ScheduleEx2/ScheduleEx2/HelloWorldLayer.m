//
//  HelloWorldLayer.m
//  ScheduleEx2
//
//  Created by Lee Jaewhan on 11. 8. 28..
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
    if ( (self=[super init]) ) {
        
        
    }
    return self;
}

-(void) onEnter 
{ 
    [super onEnter]; 
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick1:) userInfo:nil repeats:YES]; 
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick2:) userInfo:nil repeats:YES]; 
} 

-(void) onExit 
{ 
    [timer1 invalidate]; 
    [timer2 invalidate]; 
    
    [super onExit]; 
} 

- (void)tick1:(ccTime)dt
{
    NSLog(@"tick1");
}

- (void)tick2:(ccTime)dt
{
    NSLog(@"tick2");
}

@end
