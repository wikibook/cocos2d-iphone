//
//  HelloWorldLayer.m
//  TouchEx1
//
//  Created by Lee Jaewhan on 11. 8. 2..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


/*
 CCLayer의 헤더 파일을 보시면, 세개의 프로토콜을 implement하고 있습니다.
 CCLayer는 전에도 설명드렸듯이 Accelorometer와 터치이벤트를 처리할 수 있습니다.
 
 @interface CCLayer : CCNode <UIAccelerometerDelegate, CCStandardTouchDelegate, CCTargetedTouchDelegate>
 
 터치이벤트를 처리하기위해 이제 CCLayer가 필요합니다.
 우리가 원하는 바대로 터치 이벤트를 처리하기 위해 CCLayer를 상속하는 클래스를 만들어 봅니다.

 */


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
    if( (self=[super init])) {

        // cocos2D에서는 두 가지의 터치 이벤트 처리 방법
        // 1.CCStandardTouchDelegate를 이용하는 방법
        // 2.CCTargetedTouchDelegate를 이용하는 방법
        
        // CCStandardTouchDelegate는 아이폰 시스템에서 넘겨주는 터치이벤트를 받아서 그대로 넘겨주는 방법이고,
        // CCTargetedTouchDelegate는 직접 터치이벤트를 받는 오브젝트를 등록시킨 후 사용하는 방법으로
        // cocos2D 자체에서 처리하는 방법
        

        
        // CCLayer가 시스템으로 부터 넘어온 터치 이벤트에 대해 프로토콜의 메소드를 호출하도록 합니다.
        // 만일 NO로 설정하시면, 터치 이벤트가 발생해도 터치 이벤트를 핸들링하는 메소드가 호출되지 않습니다.
        self.isTouchEnabled = YES;
    }
    return self;
}

//- (void)onEnter
//{
//    [[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
//    [super onEnter];
//}

// 처음 손가락이 화면에 닿는 순간 호출됩니다.
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Began");
}

// 손가락을 화면에서 떼지않고 이리저리 움직일 때 계속해서 호출됩니다.
// 얼마나 자주 호출되느냐는 전적으로
// 이벤트를 핸들링하는 애플리케이션의 Run Loop에 달려있습니다.
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Moved");
}

// 손가락을 화면에서 떼는 순간 호출되는 함수입니다.
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Ended");
}

// 왠만해서는 거의 쓸 필요가 없는 메소드입니다.
// 이 메소드가 호출되는 경우는 갑자기 아이폰 자체에 어떤 문제가 생겨서,
// 시스템이 터치를 중지시키는 경우에 호출됩니다. 
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touches Cancelled");
}

@end
