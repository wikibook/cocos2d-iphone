//
//  HelloWorldLayer.m
//  SoundEx
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
        
        [menu alignItemsVertically];
        
        [self addChild:menu];


        
        // 심플오디오엔진 로딩
        sae = [SimpleAudioEngine sharedEngine];
        
        sae.effectsVolume = 0.9;
        
        if (sae != nil) { 
            [sae preloadBackgroundMusic:@"bgm.mp3"]; 
            if (sae.willPlayBackgroundMusic) { 
                sae.backgroundMusicVolume = 0.5f; 
            } 
        }

        
//        sae.isBackgroundMusicPlaying
//        sae.pauseBackgroundMusic
//        sae.resumeBackgroundMusic
//        sae.stopBackgroundMusic
//        sae.willPlayBackgroundMusic
//        sae.rewindBackgroundMusic
        

    }
    return self;
}

- (void)doClick:(id)sender
{
    CCMenuItem *tmenu = (CCMenuItem *)sender;
    
    switch (tmenu.tag) {
        case 1:
            //배경음악 재생    
            [sae playBackgroundMusic:@"bgm.mp3" loop:YES];
            break;
        case 2:
            // 사운드재생
            [sae playEffect:@"dp1.caf"];
            break;
        case 3:
            // 배경음악멈춤
            [sae stopBackgroundMusic];
            break;
            
        default:
            break;
    }

    NSLog(@"메뉴%d이 눌렸음...",tmenu.tag);
}



@end
