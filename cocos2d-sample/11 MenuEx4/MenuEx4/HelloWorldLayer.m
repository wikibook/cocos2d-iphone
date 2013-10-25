//
//  HelloWorldLayer.m
//  MenuEx4
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
                                                        selector:@selector(buttonPushed:)];
        
        CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"btn-highscores-normal.png"
                                                   selectedImage:@"btn-highscores-selected.png"
                                                          target:self
                                                        selector:@selector(buttonPushed:)];
        
        item1.tag = 1;
        item2.tag = 2;
        
        
        // 메뉴 구성
        CCMenu *menu = [CCMenu menuWithItems:item1,item2, nil];
        
        [menu alignItemsVertically];

        [self addChild:menu];

    
    }
    return self;
}

-(void)buttonPushed:(id)sender
{
    
    CCMenuItem *item = (CCMenuItem *)sender;

    if(item.tag==1){        // 1번메뉴가 눌렸고, child 스프라잇을 추가시킨다
        CCSprite *child=[CCSprite spriteWithFile:@"grossini.png"];
        child.position=ccp(100,160);
        child.tag=11;
        [self addChild:child];
        
    }
    if(item.tag==2){        // 2번메뉴가 눌렸고 추가시켰던 차일드를 제거해준다.
        CCSprite *child=(CCSprite*)[self getChildByTag:11];      //태그로차일드얻기
        [self removeChild:child cleanup:YES];                    //차일드를 제거하기
        
        //[parent removeChildByTag:11 cleanup:YES];                //태그로 차일드제거하기
    }
    
}


@end
