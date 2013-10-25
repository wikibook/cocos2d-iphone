//
//  HelloWorldLayer.m
//  MenuEx3
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
                                                        selector:@selector(doClick:)];
        
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(doClick:)];
        
        CCMenuItem *item3 = [CCMenuItemImage itemFromNormalImage:@"btn-about-normal.png"
                                                   selectedImage:@"btn-about-selected.png"
                                                          target:self
                                                        selector:@selector(doClick:)];
        
        item1.tag = 1;
        item2.tag = 2;
        item3.tag = 3;

        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2,item3, nil];
        
        [menu alignItemsHorizontally];
        
        
        [self addChild:menu];

    
    }
    return self;
}

- (void)doClick:(id)sender
{
    CCMenuItem *tmenu = (CCMenuItem *)sender;
    
    
    NSLog(@"메뉴%d이 눌렸음...",tmenu.tag);
}


@end
