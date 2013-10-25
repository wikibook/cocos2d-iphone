//
//  HelloWorldLayer.m
//  MenuEx2
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
        
        // 메뉴레이어  <-- 눈에 보이지 않는다.
        // 디폴트앵커포인트 : (0,0)
        // 디폴트포인트 : (240,160)  --> (0,0)으로 바꾸어준다.

        
        CCMenuItem *item1 = [CCMenuItemImage itemFromNormalImage:@"btn-play-normal.png"
                                                   selectedImage:@"btn-play-selected.png"
                                                          target:self
                                                        selector:@selector(doClick1)];
        item1.position = ccp(100,100);

        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1, nil];
        
        menu.position = ccp(0,0);
        
        
        [self addChild:menu];

    
    
    
    
    }
    return self;
}

- (void)doClick1
{
    NSLog(@"메뉴1이 눌렸음...");
}


@end
