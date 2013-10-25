//
//  HelloWorldLayer.m
//  SimpleGameEx
//
//  Created by Lee Jaewhan on 11. 9. 11..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
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
    if( (self=[super init] )) {
        
        
        // 화면 사이즈 구하기
        winSize = [CCDirector sharedDirector].winSize;

        // 터치 활성화
        self.isTouchEnabled = YES;
        

        // 게임에 사용할 배열 초기화
        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];

        
        // 게임에 사용할 스프라이트 배치노드 읽고 화면 만들기
        [self spriteAllLoad];
    
        // 1초마다 적을 만드는 메서드를 호출한다.
        [self schedule:@selector(addTarget:) interval:1.0];
        
        // 매프레임마다 게임의 상태를 체크한다.
        [self schedule:@selector(update:)];
        
        
        // Start up the background music
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.caf"];

    }
    return self;
}

- (void)spriteAllLoad
{

    // 디폴트 이미지 세로형 화면에 추가하기
    CCSprite *defaultImage = [CCSprite spriteWithFile:@"DefaultLandscape.png"];
    defaultImage.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:defaultImage z:10];        

    
    // 스프라이트 배치노드의 위치정보 파일을 읽어들인다.
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];

    
    // 메인 백그라운드 이미지 추가
    CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"Level_bkgrnd.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:background z:0];

    
    // 탐 이미지 추가
    tom = [CCSprite spriteWithSpriteFrameName:@"Level_Tom.png"];
    tom.position = ccp(tom.contentSize.width/2 + 20,
                       winSize.height/2);
    [self addChild:tom z:1];

    
    // 탐이 눈 깜박이게 애니메이션. 1.0초마다 0.1초 사이에 눈 깜박이기
    NSMutableArray *blinkAnimFrames = [NSMutableArray array];    
    [blinkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]
                                spriteFrameByName:@"Level_Tom.png"]];
    [blinkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]
                                spriteFrameByName:@"Level_Tom_blink.png"]];
    [blinkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache]
                                spriteFrameByName:@"Level_Tom.png"]];
    
    CCAnimation *blinkAnimation = [CCAnimation animationWithFrames:blinkAnimFrames delay:0.1f];
    
    [tom runAction:[CCRepeatForever actionWithAction:
                    [CCSequence actions:
                     [CCAnimate actionWithAnimation:blinkAnimation restoreOriginalFrame:NO],
                     [CCDelayTime actionWithDuration:1.0f],
                     nil]]];
 
    
    // 시작할 때 로딩한 디폴트 이미지를 지운다. (메모리 절약)
    [self removeChild:defaultImage cleanup:YES];
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{    
    // 터치된 위치 정보 구하기
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Play a sound!
    [[SimpleAudioEngine sharedEngine] playEffect:@"shoot.wav"];

    // 탐이 바라보는 곳 변경하기 시작 ------------------------------------------------

    // 탐과 터치된 곳의 각도를 구한다.
    CGPoint shootVector = ccpSub(location, tom.position);
    CGFloat shootAngle = ccpToAngle(shootVector);
    CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle);
    
    // 회전 각도를 구한다.
    CGFloat curAngle = tom.rotation;
    CGFloat rotateDiff = cocosAngle - curAngle;
    if (rotateDiff > 180)
        rotateDiff -= 360;
    if (rotateDiff < -180)
        rotateDiff += 360;
    // 회전하는데 0.5초 걸린다.
    CGFloat rotateSpeed = 0.5f / 180;
    CGFloat rotateDuration = fabsf(rotateDiff * rotateSpeed);
    
    // 터치된 곳을 바라보도록 탐의 각도를 변경한다.
    [tom runAction:[CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle]];

    // 탐이 바라보는 곳 변경하기 끝   ------------------------------------------------

    
    
    
    // 탄환의 초기 위치 정하기
    CCSprite *projectile = [CCSprite spriteWithSpriteFrameName:@"Level_bullet.png"];

    // 다음 한줄 코드가 방향 전환된 탐의 총구에서 탄환이 발사되도록 위치를 정하는 코드임
    projectile.position = [tom convertToWorldSpace:ccp(tom.contentSize.width,
                                                       tom.contentSize.height/2)];
    // 화면에 탄환을 추가한다.
    [self addChild:projectile];
    
    
    // 탐과 같은 방향으로 탄환의 방향 정하기
    projectile.rotation = cocosAngle;
    
    // 화면 바깥으로 탄환을 이동시킨다. 420으로 조정.
    ccTime delta = 1.0f;
    CGPoint normalizedShootVector = ccpNormalize(shootVector);
    CGPoint overshotVector = ccpMult(normalizedShootVector, 420);
    
    [projectile runAction:[CCSequence actions:
                               [CCMoveBy actionWithDuration:delta position:overshotVector],
                               [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
    

    // 배열에 탄환을 추가한다.
    projectile.tag = 2;
    [_projectiles addObject:projectile];
    

}

- (void)spriteMoveFinished:(id)sender
{

    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    
    if (sprite.tag == 1) { // target
        [_targets removeObject:sprite];
        
        NSLog(@"You lose...");
        
        // 게임에 졌다. 새로운 게임 대기 화면...
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionRadialCW transitionWithDuration:0.5f scene:[GameOver scene:@"You Lose :["]]];

    } else if (sprite.tag == 2) { // projectile
        [_projectiles removeObject:sprite];
    }
    
}

- (void)addTarget:(ccTime)dt
{
    CCSprite *target = [CCSprite spriteWithSpriteFrameName:@"Level_person1.png"];
    
    // 적이 Y축을 랜덤하게 어디에서 생성될지 결정한다.
    int minY = target.contentSize.height/2;
    int maxY = winSize.height - target.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // 화면의 오른쪽 끝 안보이는 곳부터에 걸쳐서 적이 생성되도록 위치를 정한다.
    target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
    [self addChild:target];
    
    // 적의 속도를 랜덤하게 정한다.
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // 적의 액션을 만들어준다. 오른쪽에서 왼쪽으로 끝까지 오게 만든다.
    id actionMove  = [CCMoveTo actionWithDuration:actualDuration
                                         position:ccp(20, actualY)];
    id actionPause = [CCDelayTime actionWithDuration:0.5f];
    id actionBack  = [CCMoveTo actionWithDuration:actualDuration
                                         position:ccp(target.position.x,actualY)];
    
    // 정상적으로 적의 액션이 끝나면 게임이 끝나는 메서드를 호출하게 한다.
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
    
    [target runAction:[CCSequence actions:actionMove,actionPause,actionBack, actionMoveDone, nil]];
    

    // 생성된 적을 배열에 저장한다.
    target.tag = 1;
    [_targets addObject:target];
    
    
}


- (void)update:(ccTime)dt
{

    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    
    for (CCSprite *projectile in _projectiles) {
        CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), 
                                           projectile.position.y - (projectile.contentSize.height/2), 
                                           projectile.contentSize.width, 
                                           projectile.contentSize.height);
        
        // 적과 탄환의 충돌 검사
        
        // 죽여야 할 적의 배열 초기화
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        
        for (CCSprite *target in _targets) {
            CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2), 
                                           target.position.y - (target.contentSize.height/2), 
                                           target.contentSize.width, 
                                           target.contentSize.height);
            
            // 두개의 스프라이트가 겹치는지 조사
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                // 탄환과 적이 겹치므로 죽여야 할 배열에 추가
                [targetsToDelete addObject:target];                

                [[SimpleAudioEngine sharedEngine] playEffect:@"femaleHit.wav"];
            }                        
        }
        
        // 적과 부딪힌 탄환이므로 화면과 배열에서 없애기 위해 저장
        if (targetsToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }

        // 충돌이 일어난 것으로 판단된 적들 화면과 배열에서 지우기
        for (CCSprite *target in targetsToDelete) {
            [_targets removeObject:target];
            [self removeChild:target cleanup:YES];                                    
            
            // 맞혀서 없앤 적들의 숫자 증가
            _projectilesDestroyed++;
            
            // 30개를 없앴다면 승리!!!
            if (_projectilesDestroyed > 30) {
                NSLog(@"You win!");
                
                // 게임에 이겼다. 새로운 게임 대기 화면...
                [[CCDirector sharedDirector] replaceScene:
                 [CCTransitionRadialCW transitionWithDuration:0.5f scene:[GameOver scene:@"You Win! ^^"]]];
            }
        }
        
        
        [targetsToDelete release];
    }
    
    // 충돌이 일어난 것으로 판단된 탄환들 화면과 배열에서 지우기
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    
    [projectilesToDelete release];

}

@end