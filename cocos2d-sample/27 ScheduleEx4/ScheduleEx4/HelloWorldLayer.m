//
//  HelloWorldLayer.m
//  ScheduleEx4
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
        
        
        // Menu 구성
        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doClick:)];
        
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(doClick:)];
        
        item1.tag = 1;
        item2.tag = 2;
        
        CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
        
        [menu alignItemsVertically];
        
        [self addChild:menu];
        
        
    }
    return self;
}

- (void)doClick:(id)sender
{
    
    CCMenuItem *item = (CCMenuItem *)sender;
    
    if(item.tag==1){
        // 일시 정지한다.
        [[CCDirector sharedDirector] pause];
    }
    
    if(item.tag==2){
        // 다시 시작한다.
        [[CCDirector sharedDirector] resume];
    }
    
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
