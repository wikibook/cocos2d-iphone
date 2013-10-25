//
//  HelloWorldLayer.m
//  LabeEx
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
        // 주의 : 폰트 크기는 너무 크고 레이블의 크기가 상대적으로 작을 때 글자가 잘리는 현상이
        // 발생할 수 있다. 이럴 때는 레이블의 크기를 더 늘리든지, 폰트 크기를 줄여 본다.
        
        // 0.995 부터 ... 이전은 CCLabel
        // 내용이 길면 자동개행이 되지 않고 중앙정렬만 된다.

//        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World"
//                                               fontName:@"Marker Felt"
//                                               fontSize:64];
/*
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세."
                                               fontName:@"Marker Felt"
                                               fontSize:24];
*/
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세."
                                             dimensions:CGSizeMake(300, 100)
                                              alignment:UITextAlignmentLeft
                                          lineBreakMode:UILineBreakModeCharacterWrap
                                               fontName:@"Marker felt"
                                               fontSize:24];
        label.position = ccp(240,160);
        //label.color = ccc3(255, 0, 0);
        //label.opacity = 100.0;
        
        // add the label as a child to this Layer
        [self addChild: label];

        
        
    }
    return self;



}


@end
