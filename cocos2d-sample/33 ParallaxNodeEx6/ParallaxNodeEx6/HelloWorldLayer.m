//
//  HelloWorldLayer.m
//  ParallaxNodeEx6
//
//  Created by Lee Jaewhan on 11. 9. 3..
//  Copyright Gikimi-SW 2011년. All rights reserved.
//


#import "HelloWorldLayer.h"

#define IMG_WIDTH 1024

enum {
    kTag_Parallax = 0,
    kTag_ArrowButtonPressed = 1,
    kTag_ArrowButton = 2
};

@implementation HelloWorldLayer
@synthesize rightSprite;
@synthesize rightPressedSprite;
@synthesize leftSprite;
@synthesize leftPressedSprite;
@synthesize dragon;

- (void)dealloc
{
    [rightSprite release];
    [rightPressedSprite release];
    [leftSprite release];
    [leftPressedSprite release];
    [dragon release];
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
        
        
        // CCLayer가 터치이벤트를 처리할 수 있도록 활성화시킨다.
        self.isTouchEnabled = YES;
        
        // 화면의 픽셀 크기를 구합니다.
        winSize = [[CCDirector sharedDirector] winSize];
        
        // 배경을 만든다.
        [self createBackgroundParallax];
        
        // 메뉴버튼을 만든다.
        [self createArrowButtons];
        
        // 드래곤을 만든다.
        [self createDragon];
    }
    return self;
}

- (void)createBackgroundParallax
{
    
    // 이미지로 백그라운드에 쓰일 CCSprite를 만든다.
    CCSprite *bgSprite1 = [CCSprite spriteWithFile:@"background1.png"];
    CCSprite *bgSprite2 = [CCSprite spriteWithFile:@"background2.png"];
    
    // Transform 할 때 사용되는 anchorPoint를 왼쪽 아래(0, 0)로 잡는다. 
    bgSprite1.anchorPoint = ccp(0, 0);
    bgSprite2.anchorPoint = ccp(0, 0);
    
    // 이미지가 만나는 가장자리(edge)에 검은선이 생기는 현상을 방지하기 위하여
    // Anti-Aliasing을 끈다.
    [bgSprite1.texture setAliasTexParameters];
    [bgSprite2.texture setAliasTexParameters];
    
    // 위에서 만든 sprite를 담을 parent로 CCParallaxNode를 만든다.
    CCParallaxNode *voidNode = [CCParallaxNode node];
    
    // 배경 sprite를 Parallax에 넣는다.
    [voidNode addChild:bgSprite1 z:1 parallaxRatio:ccp(1.0f, 0) positionOffset:CGPointZero];
    [voidNode addChild:bgSprite2 z:1 parallaxRatio:ccp(1.0f, 0) positionOffset:ccp(512, 0)];
    
    [self addChild:voidNode z:kTag_Parallax tag:kTag_Parallax];
    
}

- (void)createArrowButtons
{
    // 왼쪽 화살표
    CCSprite *sprite = [[CCSprite alloc] initWithFile:@"b1.png"];
    self.leftSprite = sprite;
    
    self.leftSprite.position = ccp(180,30);
    
    [self addChild:self.leftSprite z:kTag_ArrowButton];
    [sprite release];
    
    // 눌렸을 때 쓰일 왼쪽 화살표 
    sprite = [[CCSprite alloc] initWithFile:@"b2.png"];
    self.leftPressedSprite = sprite;
    
    // self.leftSprite와 똑같은 위치에 표시한다.
    self.leftPressedSprite.position = self.leftSprite.position;
    
    // 눌렸을 때의 화살표를 하위 z-order로 넣는다. 그럼, 위에 같은 크기의 화살표가 
    // 똑같은 위치에 있으니까 가려서 화면상에 보이지 않게 된다.
    [self addChild:self.leftPressedSprite z:kTag_ArrowButtonPressed];
    [sprite release];
    
    
    // 오른쪽 화살표
    sprite = [[CCSprite alloc] initWithFile:@"f1.png"];
    self.rightSprite = sprite;
    
    self.rightSprite.position = ccp(300,30);
    
    [self addChild:self.rightSprite z:kTag_ArrowButton];
    [sprite release];
    
    // 눌렸을 때 쓰일 오른쪽 화살표 
    sprite = [[CCSprite alloc] initWithFile:@"f2.png"];
    self.rightPressedSprite = sprite;
    
    // self.rightSprite와 똑같은 위치에 표시한다.
    self.rightPressedSprite.position = self.rightSprite.position;
    
    // 눌렸을 때의 화살표를 하위 z-order로 넣는다. 그럼, 위에 같은 크기의 화살표가 
    // 똑같은 위치에 있으니까 가려서 화면상에 보이지 않게 된다.
    [self addChild:self.rightPressedSprite z:kTag_ArrowButtonPressed];
    [sprite release];
}

- (void)createDragon
{
    
    // 움직이는 드래곤 넣기 시작
    CCSprite *sprite = [CCSprite spriteWithFile:@"dragon_animation.png"];
    
    CCAnimation *animation = [[CCAnimation alloc] init];
    
    [animation setDelay:0.1];
    
    // 제일 첫번째 프레임으로 주인공 sprite를 만듭니다.
    self.dragon = [CCSprite spriteWithTexture:sprite.texture rect:CGRectMake(0, 0, 130, 140)];
    
    for(int i=0;i<6;i++){
        // 첫째 줄에 4개의 프레임이 있고, 5번째 부터는 두 번째 줄에 있으므로,
        // 5번째(idx==4)부터는 y 좌표의 값을 증가시켜야 한다.
        NSUInteger index    = i % 4;
        NSUInteger rowIndex = i / 4;
        
        [animation addFrameWithTexture:sprite.texture rect:CGRectMake(index*130, rowIndex*140, 130, 140)];
    }
    
    self.dragon.position = ccp(240,160);
    
    CCAnimate *animate=[CCAnimate actionWithAnimation:animation];
    animate=[CCRepeatForever actionWithAction:animate];
    [self.dragon runAction:animate];
    
    [self addChild:self.dragon];
    
}

#pragma mark -
#pragma mark Touch Event Handling

// 손가락이 닫는 순간 호출됩니다.
- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    UITouch *touch = [touches anyObject];
    
    // 아래 Boolean 변수 대신에 leftSprite와 rightSprite의 visible의 값을 직접 사용해도 무방합니다.
    isLeftPressed = NO;
    isRightPressed = NO;
    
    // 터치가 왼쪽 또는 오른쪽 화살표 안에 들어왔는지 확인합니다.
    if([self isTouchInside:self.leftSprite withTouch:touch] == YES) {
        // 왼쪽 화살표를 안보이게 합니다. 그럼 그 아래에 있던 눌릴 때 보여지는 이미지가 나타날 것입니다.
        self.leftSprite.visible = NO;
        
        isLeftPressed = YES;
    }else if([self isTouchInside:self.rightSprite withTouch:touch] == YES) {
        // 오른쪽 화살표를 안보이게 합니다.
        self.rightSprite.visible = NO;
        
        isRightPressed = YES;
    }
    
    // 버튼이 눌려졌으면 화면을 움직입니다.
    if(isLeftPressed == YES || isRightPressed == YES)
        [self startMovingBackground];
}

// 손가락을 떼는 순간 호출됩니다.
- (void)ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    // 배경화면을 멈춥니다.
    if(isLeftPressed == YES || isRightPressed == YES)
        [self stopMovingBackground];
    
    // 감춰졌던 버튼이미지를 다시 보이게 합니다.
    if(isLeftPressed == YES)
        self.leftSprite.visible = YES;
    
    if(isRightPressed == YES) 
        self.rightSprite.visible = YES;
}

// 손가락을 움직일 때 계속해서 호출됩니다.
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 손가락이 버튼을 벗어나면 움직임을 중단합니다.
    if(isLeftPressed == YES && [self isTouchInside:self.leftSprite withTouch:touch] == NO) {
        self.leftSprite.visible = YES;
        [self stopMovingBackground];
    }else if(isRightPressed == YES && [self isTouchInside:self.rightSprite withTouch:touch] == NO) {
        self.rightSprite.visible = YES;
        [self stopMovingBackground];
    }
}


#pragma mark -
#pragma mark Game Play

// 터치가 버튼 Sprite안에서 이루어졌는지 확인한다.
- (BOOL)isTouchInside:(CCSprite*)sprite withTouch:(UITouch*)touch
{
    // Cocoa 좌표 
    CGPoint location = [touch locationInView: [touch view]];
    
    // Cocoa 좌표를 cocos2d 좌표로 변환한다
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    CGFloat halfWidth = sprite.contentSize.height / 2.0;
    CGFloat halfHeight = sprite.contentSize.height / 2.0;
    
    if(convertedLocation.x > (sprite.position.x + halfWidth) ||
       convertedLocation.x < (sprite.position.x - halfWidth) ||
       convertedLocation.y < (sprite.position.y - halfHeight) ||
       convertedLocation.y > (sprite.position.y + halfHeight) ) {
        return NO;
    }
    
    return YES;
}

- (void)startMovingBackground
{
    // 만약 버튼 두개가 다 눌려졌으면 화면을 이동시키지 않는다.
    if(isLeftPressed == YES && isRightPressed == YES)
        return;
    
    NSLog(@"start moving");
    
    //schedule을 이용하여 매 프레임마다 배경화면을 움직인다.
    [self schedule:@selector(moveBackground)];
}

- (void)stopMovingBackground
{
    NSLog(@"stop moving");
    [self unschedule:@selector(moveBackground)];
}


- (void)moveBackground
{
    // 드래곤의 방향을 정한다.
    // flipX를 이용하여 하나의 이미지로 두 방향을 다 표현할 수 있다.
    if(isRightPressed == YES)
        self.dragon.flipX = YES;
    else
        self.dragon.flipX = NO;
    
    // GameLayer에 들어있는 parallax node를 받는다.
    CCNode *voidNode = [self getChildByTag:kTag_Parallax];
    
    // 매 프레임마다 움직일 거리
    CGPoint moveStep = ccp(3, 0);
    
    // 오른쪽 버튼이 눌려졌을 때는 반대로 움직임
    if(isRightPressed)
        moveStep.x = -moveStep.x;
    
    CGFloat bgParallaxRatio = 1.0f;
    
    CGPoint newPos = ccp(voidNode.position.x + moveStep.x, voidNode.position.y);
    
    // 배경이 양쪽 끝에 도달하면 더 이상 움직이지 않음
    if(isLeftPressed == YES && newPos.x > 0)
        newPos.x = 0;
    else if(isRightPressed == YES && newPos.x < -(IMG_WIDTH - winSize.width) / bgParallaxRatio)
        newPos.x = -(IMG_WIDTH - winSize.width) / bgParallaxRatio;
    
//    voidNode.position = newPos;
    
    
    // 드래곤이 화면 가운데 있을 경우에만 배경을 움직인다.
    CGFloat halfWinWidth = winSize.width / 2;
    if(self.dragon.position.x == halfWinWidth)
        voidNode.position = newPos;
    
    
    // 만약 드래곤이 화면 가운데 있지않을 경우에는 드래곤을 화면가운데까지
    // 이동하게 한다.
    
    if(isRightPressed == YES && self.dragon.position.x < halfWinWidth) {
        // moveStep.x의 부호를 바꾼 이유는 배경과 드래곤의 움직임 방향이 서로 반대이기 때문이다.
        self.dragon.position = ccp(self.dragon.position.x + (moveStep.x * -1),
                                         self.dragon.position.y);
        // 가운데 이상 움직이지 않도록 체크한다.
        if(self.dragon.position.x > halfWinWidth)
            self.dragon.position = ccp(halfWinWidth, self.dragon.position.y);
    }else if(isLeftPressed == YES && self.dragon.position.x > halfWinWidth) {
        // moveStep.x의 부호를 바꾼 이유는 배경과 주인공의 움직임 방향이 서로 반대이기 때문이다.
        self.dragon.position = ccp(self.dragon.position.x + (moveStep.x * -1),
                                         self.dragon.position.y);
        
        // 가운데 이상 움직이지 않도록 체크한다.
        if(self.dragon.position.x < halfWinWidth)
            self.dragon.position = ccp(halfWinWidth, self.dragon.position.y);
    }
    
    // 배경의 끝에 도달하면 배경은 움직이지 않고 드래곤을 화면 끝까지 이동시킨다.
    if(newPos.x == 0 || newPos.x == -(IMG_WIDTH - winSize.width)) {
        CGPoint newDragonPos = ccp(self.dragon.position.x + (moveStep.x * -1), self.dragon.position.y);
        
        // 드래곤이 화면의 왼쪽 또는 오른쪽 끝까지 도달했을 때는 더 이상 움직이지 않는다.
        CGFloat halfWidth = self.dragon.contentSize.width / 2;
        if(newDragonPos.x <= halfWidth)
            newDragonPos.x = halfWidth;
        else if(newDragonPos.x >= winSize.width - halfWidth)
            newDragonPos.x = winSize.width - halfWidth;
        
        self.dragon.position = newDragonPos;
    }
}

@end
