//
//  HelloWorldLayer.m
//  MenuEx
//
//  Created by Lee Jaewhan on 11. 7. 31..
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

        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doClick1)];
        
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(doClick2)];
    
        CCMenuItem *item3 = [CCMenuItemImage itemFromNormalImage:@"btn-about-normal.png"
                                                   selectedImage:@"btn-about-selected.png"
                                                          target:self
                                                        selector:@selector(doClick3)];
        
        
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        
        // 메뉴 배치
        [menu alignItemsVertically];
        
        [self addChild:menu];
    
    }
    return self;
}

- (void)doClick1
{
    NSLog(@"메뉴1이 눌렸음...");
}

- (void)doClick2
{
    NSLog(@"메뉴2이 눌렸음...");
}

- (void)doClick3
{
    NSLog(@"메뉴3이 눌렸음...");
}


@end
