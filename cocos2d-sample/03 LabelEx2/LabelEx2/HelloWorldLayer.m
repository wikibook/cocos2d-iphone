//
//  HelloWorldLayer.m
//  LabelEx2
//
//  Created by Lee Jaewhan on 11. 8. 5..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "FontManager.h"

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
        
        
        // System Default Font
        
        CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Arial" fontSize:64];
    
        label1.position =  ccp( size.width /2 , 200 );
        
        [self addChild: label1];

        
        
        
        
        // True Type Font

        
        // Macintosh HD / Library/ Fonts 디렉터리에 있는 Apple Chancery.ttf 파일을
        // 프로젝트 resources 디렉터리 로 복사합니다.
        // 그리고 복사.한 파일을 Xcode 프로젝트의 Resources 그룹에 추가합니다.
        
        // 리소스로 추가한 폰트는 cocos2d에 별도로 들어 있는 FontManager를 사용해야 합니다.
        // #import "FontManager.h"
        
        NSString *fontName = [NSString stringWithString:@"Brush Script"];
        BOOL wasSucceeded = [[FontManager sharedManager] loadFont:fontName];
        // 실패했을 경우 사용할 시스템 폰트를 사용합니다
        if (wasSucceeded == NO) {
            fontName = [NSString stringWithString:@"Arial"];
        }
        
        
        
        
        CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Hello World" fontName:fontName fontSize:64];
        
        label2.position =  ccp( size.width /2 , 100 );
        
        [self addChild: label2];

    
    }
    return self;
}

@end
