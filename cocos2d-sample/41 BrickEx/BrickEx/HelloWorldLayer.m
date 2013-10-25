//
//  HelloWorldLayer.m
//  BrickEx
//
//  Created by Lee Jaewhan on 11. 9. 17..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "GameOver.h"


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
        
        // 터치 활성화
        self.isTouchEnabled = YES;

        // 어레이 초기화
        targets = [[NSMutableArray alloc] init];

        BRICKS_HEIGHT = 4;
        BRICKS_WIDTH = 5;

        // 벽돌 초기화
        [self initializeBricks];
        
        // 공 초기화
        [self initializeBall];
        
        // 패들 초기화
        [self initializePaddle];
        
        // 2초후 게임 시작
        [self performSelector:@selector(startGame) withObject:self afterDelay:2.0];
    
    }
    return self;
}

- (void)initializeBricks
{
    int count = 0;
    
    for (int y = 0; y < BRICKS_HEIGHT; y++) {
        for (int x = 0; x < BRICKS_WIDTH; x++) {
            
            CCSprite *bricks = [CCSprite node];
            [bricks setTextureRect:CGRectMake(0, 0, 64, 40)];
            switch (count++ %4) {
                case 0:
                    [bricks setColor:ccc3(255, 255, 255)];
                    break;
                case 1:
                    [bricks setColor:ccc3(255, 0, 0)];
                    break;
                case 2:
                    [bricks setColor:ccc3(255, 255, 0)];
                    break;
                case 3:
                    [bricks setColor:ccc3(75, 255, 0)];
                    break;
                    
                default:
                    break;
            }
            
            bricks.position = ccp(x*64+32,(y * 40) + 280);
            
            // 화면에 추가
            [self addChild:bricks];
            
            // 배열에 추가
            [targets addObject:bricks];
        }
    }    
}

- (void)initializeBall
{
    ball = [CCSprite node];
    [ball setTextureRect:CGRectMake(0, 0, 16, 16)];
    [ball setColor:ccc3(0, 255, 255)];
    ball.position = ccp(160,240);
    [self addChild:ball];
}

- (void)initializePaddle
{
    paddle = [CCSprite node];
    [paddle setTextureRect:CGRectMake(0, 0, 80, 10)];
    [paddle setColor:ccc3(255, 255, 0)];
    paddle.position = ccp(160,50);
    [self addChild:paddle];
}

- (void)startGame
{
    ball.position = ccp(160, 240);
    
    ballMovement = CGPointMake(4,4);
    if (arc4random() % 100 < 50)
        ballMovement.x = -ballMovement.x;
    
    isPlaying = YES;
    
    [self schedule:@selector(gameLogic:) interval:2/60 ];

}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isPlaying) {
        return;
    }
    
    // 멀티터치를 껐으므로 하나의 터치이벤트만 가져온다.
    UITouch *touch = [touches anyObject];
    // 터치된 위치를 Cocoa 좌표 값으로 받는다.
    CGPoint location = [touch locationInView: [touch view]];
    // Cocoa 좌표값을 cocos2D 좌표값으로 변환한다. CCDirector가 사용된다.  
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    
    // 패들을 터치했는지 체크한다.

    // 패들 sprite의 사이즈의 반을 계산합니다.
    CGFloat halfWidth = paddle.contentSize.width / 2.0;
    CGFloat halfHeight = paddle.contentSize.height / 2.0;
    
    // 터치된 위치가 패들 안에 들어오는 지 계산합니다.
    if (convertedLocation.x > (paddle.position.x + halfWidth) ||
        convertedLocation.x < (paddle.position.x - halfWidth) ||
        convertedLocation.y < (paddle.position.y - halfHeight) ||
        convertedLocation.y > (paddle.position.y + halfHeight) ) 
    {
        isPaddleTouched = NO;
    } else {
        // 패들이 터치되었음을 체크.
        isPaddleTouched = YES;
    }

}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(isPaddleTouched) {

        // 현재 위치를 cocos2d 좌표값으로 계산한다.
        UITouch *touch = [touches anyObject];
        // 터치된 위치를 Cocoa 좌표 값으로 받는다.
        CGPoint location = [touch locationInView: [touch view]];
        // Cocoa 좌표값을 cocos2D 좌표값으로 변환한다. CCDirector가 사용된다.  
        CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];

        // 패들이 좌우로만 움직이게 y값은 바꾸지 않는다.
        // 또한 패들이 화면 바깥으로 나가지 않도록 한다.
        if (convertedLocation.x < 40) {
            convertedLocation.x = 40;
        }
        if (convertedLocation.x > 280) {
            convertedLocation.x = 280;
        }
        
        CGPoint newLocation = ccp(convertedLocation.x,paddle.position.y);
        paddle.position = newLocation;
    }
    
}

- (void)gameLogic:(ccTime)dt
{
    // ballMovement.y가 음수이면 볼이 내려오고 있는 것.
    // ballMovement.y가 양수이면 볼이 올라가고 있는 것.
    //NSLog(@"tick..%f",ballMovement.y);

    // 볼의 현재위치
    ball.position = ccp(ball.position.x+ballMovement.x, ball.position.y+ballMovement.y);
    

    
    // 볼과 패들 충돌여부
    BOOL paddleCollision = 
    ball.position.y <= paddle.position.y + 13 &&
    ball.position.x >= paddle.position.x - 48 &&
    ball.position.x <= paddle.position.x + 48;
    
    // 패들과 충돌시 처리
    if(paddleCollision) {
        
        if (ball.position.y <= paddle.position.y + 13 && ballMovement.y < 0) {
            ball.position = ccp(ball.position.x, paddle.position.y + 13);
        }

        // 내려오던거 위로 올라가게 공의 상하 진행방향 바꾸기
        ballMovement.y = -ballMovement.y;
    }
    

    
    // 블록과 충돌 파악
    BOOL there_are_solid_bricks = NO;
    
    for(CCSprite *brick in targets) {
        
        if (255 == brick.opacity) {
            
            there_are_solid_bricks = YES;
            
            if ( CGRectIntersectsRect(ball.boundingBox, brick.boundingBox) ) {
                // 블록과 충돌 처리
                [self processCollision:brick];
            }
        }
        
    }
    
    // 블록이 없을 때 - 게임 종료 상태
    if (!there_are_solid_bricks) {
        isPlaying = NO;
        ball.opacity = 0;
        
        [self unscheduleAllSelectors];

        // 게임에 이겼다. 새로운 게임 대기 화면...
        NSLog(@"You win !!!");
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionRadialCW transitionWithDuration:0.5f scene:[GameOver scene]]];
    }
    
    // 벽면 충돌 체크
    if (ball.position.x > 312 || ball.position.x < 8)
        ballMovement.x = -ballMovement.x;
    
    if (ball.position.y > 450)
        ballMovement.y = -ballMovement.y;
    
//    if (ball.position.y < 10) {
//        ballMovement.y = -ballMovement.y;
//    }

    // 페달을 빠져 나갈 때
    if (ball.position.y < (50+5+8)) {
        isPlaying = NO;
        ball.opacity = 0;
        
        [self unscheduleAllSelectors];

        // 게임에 졌다. 새로운 게임 대기 화면...
        NSLog(@"You lose..");
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionRadialCW transitionWithDuration:0.5f scene:[GameOver scene]]];
    }


}

- (void)processCollision:(CCSprite *)brick
{
    
    if (ballMovement.x > 0 && brick.position.x < ball.position.x)
        ballMovement.x = -ballMovement.x;
    else if (ballMovement.x < 0 && brick.position.x < ball.position.x)
        ballMovement.x = -ballMovement.x;
    
    if (ballMovement.y > 0 && brick.position.y > ball.position.y)
        ballMovement.y = -ballMovement.y;
    else if (ballMovement.y < 0 && brick.position.y < ball.position.y)
        ballMovement.y = -ballMovement.y;
    

    brick.opacity = 0;
    
}


@end
