//
//  HelloWorldLayer.m
//  TouchEx2
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

- (void)onEnter
{
    // 만약 특정 Layer가 먼저 터치이벤트를 받도록 하기 위해서는 priority를 높이면 된다.
    // swallowsTouches는 핸들링 된 터치이벤트를 array에서 지우겠다는 뜻이다.
    // ccTouchBegan에서 터치이벤트를 핸들링하고 YES를 리턴하게되면 나머지 메소드
    // (ccTouchMoved, ccTouchEnded, ccTouchCancelled) 에는 ccTouchBegan에서 
    // 핸들링 된 터치이벤트만 들어오게 되므로, multi-touch에서 각각의 터치이벤트를 체크할 필요가
    // 없게 된다.

    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

// 단지 UITouch 이벤트가 NSSet으로 들어오는 것이 아니라,
// 하나의 UITouch로만 들어온다는 것이 큰 차이라고 할 수 있다.

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    // 터치된 위치를 Cocoa 좌표 값으로 받는다.
    CGPoint location = [touch locationInView: [touch view]];
    // Cocoa 좌표값을 cocos2D 좌표값으로 변환합니다. CCDirector가 사용된다.  
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    NSLog(@"Began..%f..%f",convertedLocation.x,convertedLocation.y);

    return TRUE;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // 현재 위치를 cocos2d 좌표값으로 계산합니다.
    CGPoint location = [touch locationInView: [touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    NSLog(@"Move..%f..%f",convertedLocation.x,convertedLocation.y);
}


@end
