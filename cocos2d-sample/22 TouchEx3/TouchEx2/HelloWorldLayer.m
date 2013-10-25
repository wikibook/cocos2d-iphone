//
//  HelloWorldLayer.m
//  TouchEx2
//
//  Created by Lee Jaewhan on 11. 8. 2..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//

// 처음 손가락이 화면에 닿았을 때의 시간을 저장한 후,
// 만일 거리가 40픽셀 이상 났을 때 특정 시간안에 들어오는 것만
// 제대로 된 제스쳐로 간주를 해 보겠습니다.

#import "HelloWorldLayer.h"

#define SLIDE_DIFF 40
#define SLIDE_TIME_IN_SECONDS 0.2

@implementation HelloWorldLayer

@synthesize touchBeganTime = _touchBeganTime;

- (void)dealloc
{
    [_touchBeganTime release];
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

        self.isTouchEnabled = YES;

        self.touchBeganTime = [NSDate date];
        
        _targets = [[NSMutableArray alloc] init];

        
        // 1.5초 간격으로 새로운 공을 만듭니다.
//        [self schedule:@selector(makeNewBall:) interval:1.5f];
        [self makeNewBall:1.5];
    
    }
    return self;
}

- (void)makeNewBall:(ccTime)dt
{
    NSLog(@"1:");
    CCSprite *baseBall = [CCSprite spriteWithFile:@"basketball.png"];
    baseBall.position = ccp(50, 160);
    baseBall.tag = 1;
    [_targets addObject:baseBall];
    [self addChild:baseBall];
    
    id actionMove = [CCMoveTo actionWithDuration:3.5  
                                        position:ccp( 430 , 160)];
    id moveDone = [CCCallFuncN actionWithTarget:self selector:@selector(moveFinished:)];                 
    
    NSLog(@"2:");
    [baseBall runAction:[CCSequence actions:actionMove, moveDone, nil]];
    NSLog(@"3:");
}

- (void)moveFinished:(id)sender
{
    CCSprite *sprite = (CCSprite *)sender;
    if (sprite.tag == 1) {
        [_targets removeObject:sprite];
    }
    
    [self removeChild:sprite cleanup:YES];

    NSLog(@"4:");

}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    // 멀티터치를 껐으므로 하나의 터치이벤트만 가져옵니다.
    UITouch *touch = [touches anyObject];
    // 터치된 위치를 Cocoa 좌표 값으로 받습니다.
    CGPoint location = [touch locationInView: [touch view]];
    // Cocoa 좌표값을 cocos2D 좌표값으로 변환합니다. CCDirector가 사용됩니다.  
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];

    
    
    // 공을 터치했는지 체크합니다.
    for(CCSprite *ballSprite in _targets) {

        // 공 sprite의 사이즈의 반을 계산합니다.
        CGFloat halfWidth = ballSprite.contentSize.width / 2.0;
        CGFloat halfHeight = ballSprite.contentSize.height / 2.0;
        
        // 터치된 위치가 공 안에 들어오는 지 계산합니다.
        if (convertedLocation.x > (ballSprite.position.x + halfWidth) ||
            convertedLocation.x < (ballSprite.position.x - halfWidth) ||
            convertedLocation.y < (ballSprite.position.y - halfHeight) ||
            convertedLocation.y > (ballSprite.position.y + halfHeight) ) 
        {

        } else {
            // 터치된 공을 기억합니다.
            touchedBallSprite = ballSprite;
            
            // touch된 시간을 기록합니다.
            self.touchBeganTime = [NSDate date];
            
            // 터치된 공을 찾았으므로, for문을 빠져나옵니다.
            break;
        }
    }

}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    // 만일 위에서 터치된 공이 이미 화면 밑을 지나가서 clear된 상태인 지 확인합니다.
    if(touchedBallSprite != nil) {
        
        // 현재 위치를 cocos2d 좌표값으로 계산합니다.
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView: [touch view]];
        CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
        
        // 움직인 Y 좌표의 차이를 계산합니다.        
        if( abs(convertedLocation.y - 160) >= SLIDE_DIFF) {
            
            // 정해진 시간 안에 빠르게 움직였는 지 계산합니다.
            NSTimeInterval elapsedTime = 0 - [self.touchBeganTime timeIntervalSinceNow];
            if(elapsedTime <= SLIDE_TIME_IN_SECONDS) {
                
                id moveOut;
                if ((convertedLocation.y - 160) > 0) {
                    moveOut = [CCMoveBy actionWithDuration:0.5 position:ccp(40,100)];
                } else {
                    moveOut = [CCMoveBy actionWithDuration:0.5 position:ccp(40,-100)];
                }

//                id moveDone = [CCCallFuncN actionWithTarget:self selector:@selector(moveFinished:)];                 
                id moveDone = [CCCallFuncN actionWithTarget:self selector:@selector(hiddenBall:)];                 
                
                NSLog(@"A:");

                [touchedBallSprite runAction:[CCSequence actions:moveOut, moveDone, nil]];
//                [touchedBallSprite runAction:moveOut];
                
                NSLog(@"B:");
            }
        }
    }
    
}

- (void)hiddenBall:(id)sender
{
//    touchedBallSprite.visible = NO;
//    
//    touchedBallSprite = nil;
    
    NSLog(@"C:");
    
}




@end
