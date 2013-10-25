//
//  HelloWorldLayer.m
//  TouchEx3
//
//  Created by Lee Jaewhan on 11. 8. 3..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//

// CCTargetedTouchDelegate를 사용하기 위해서는 먼저
// - (void)registerWithTouchDispatcher 메소드를 override하여야 합니다.
// 이 메소드는 CCLayer의 인스턴스 메소드이며, 기본은 StandardTouchDelegate를 사용합니다.


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

        self.touchBeganTime = [NSDate date];
        
        _targets = [[NSMutableArray alloc] init];
        
        
        // 1.5초 간격으로 새로운 공을 만듭니다.
        [self schedule:@selector(makeNewBall:) interval:1.5f];

        
        // 만약 특정 Layer가 먼저 터치이벤트를 받도록 하기위해서는 priority를 높이면 되겠습니다.
        // swallowsTouches는 핸들링 된 터치이벤트를 array에서 지우겠다는 뜻 입니다.
        // ccTouchBegan에서 터치이벤트를 핸들링하고 YES를 리턴하게되면 나머지 메소드
        // (ccTouchMoved, ccTouchEnded, ccTouchCancelled) 에는 ccTouchBegan에서 
        // 핸들링 된 터치이벤트만 들어오게되므로, multi-touch에서 각각의 터치이벤트를 체크할 필요가
        // 없게됩니다.

        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        
    }
    return self;
}

- (void)makeNewBall:(ccTime)dt
{
    CCSprite *baseBall = [CCSprite spriteWithFile:@"basketball.png"];
    baseBall.position = ccp(50, 160);
    baseBall.tag = 1;
    [_targets addObject:baseBall];
    [self addChild:baseBall];
    
    id actionMove = [CCMoveTo actionWithDuration:3.5  
                                        position:ccp( 430 , 160)];
    id moveDone = [CCCallFuncN actionWithTarget:self selector:@selector(moveFinished:)];                 
    
    [baseBall runAction:[CCSequence actions:actionMove, moveDone, nil]];
}

- (void)moveFinished:(id)sender
{
    CCSprite *sprite = (CCSprite *)sender;
    if (sprite.tag == 1) {
        [_targets removeObject:sprite];
    }
    
    [self removeChild:sprite cleanup:YES];
}


// 단지 UITouch 이벤트가 NSSet으로 들어오는 것이 아니라,
// 하나의 UITouch로만 들어온다는 것이 큰 차이라고 할 수 있겠습니다.

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
        
    touchedBallSprite = nil;
    
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
    
    return TRUE;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {

    // 만일 위에서 터치된 공이 이미 화면 밑을 지나가서 clear된 상태인 지 확인합니다.
    if(touchedBallSprite != nil) {
        
        // 현재 위치를 cocos2d 좌표값으로 계산합니다.
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
                
                [touchedBallSprite runAction:[CCSequence actions:moveOut, moveDone, nil]];
                
            }
        }
    }
    
}

- (void)hiddenBall:(id)sender
{
    touchedBallSprite.visible = NO;

    touchedBallSprite = nil;
    
}



@end
