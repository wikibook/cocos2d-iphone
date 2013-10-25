//
//  HelloWorldLayer.m
//  LabelEx3
//
//  Created by Lee Jaewhan on 11. 8. 5..
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
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        

        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];
        label1.position =  ccp( size.width /2 , 250 );
        [self addChild: label1];
    
    
        // 비트맵 폰트 파일 사용법
        // 사용하려면 같은 이름의 .fnt 파일과 png 파일이 필요합니다
        
        CCLabelBMFont *label2 = [CCLabelBMFont labelWithString:@"Hello World" fntFile:@"futura-48.fnt"];
        label2.position =  ccp( size.width /2 , 150 );
        [self addChild: label2];

    
        // 캐릭터맵 폰트 파일 사용법
        
        // itemWidth와 itemHeight는 같은 크기의 이미지로 된 sprite sheet를 이용하여
        // CCSpriteSheet를 만들 때와 마찬가지로 글자 하나에 해당하는 크기를 나타냅니다
        // startCharMap은 가장 첫 번째 이미지에 해당하는 ASCII 값을 말합니다 char 형태의 값을 사용하세요
        
        CCLabelAtlas *label3 = [CCLabelAtlas labelWithString:@"1234"
                                                 charMapFile:@"fps_images.png"
                                                   itemWidth:16 itemHeight:24
                                                startCharMap:'.'];
        label3.position =  ccp( size.width /2 , 50 );
        [self addChild:label3];

    }
    return self;
}

@end
