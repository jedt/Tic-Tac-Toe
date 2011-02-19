//
//  HelloWorldLayer.m
//  tictactoe
//
//  Created by Jed Tiotuico on 2/11/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

// Import the interfaces
#import "TicTacToe.h"

@implementation TicTacToe

CCSprite *blank;
CCSprite *background;
NSMutableArray *gameObjects;

int blockHeight;
int blockWidth;

int marginTop;
int marginLeft;

int lastTurn = 0;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TicTacToe *layer = [TicTacToe node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	blockHeight = 79;
	blockWidth = 74;
	
	marginTop = -150;
	marginLeft = -70;
	
	gameObjects = [[NSMutableArray alloc] init];
	
	int i;
	for (i = 0; i < 9; i++) {
		GameObject *gameObject = [[GameObject alloc] init];
		gameObject = [GameObject spriteWithFile:@"square.png"];
		[gameObjects addObject:gameObject];
	}

	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	lastY = 0;
	
	if( (self=[super init] )) {
		//CGSize size = [[CCDirector sharedDirector] winSize];		
		background = [[CCSprite alloc] init];
		background = [CCSprite spriteWithFile:@"background.png"];	
		background.position = ccp(160,240);
		[self addChild:background];
		
		GameObject *sprite;
		for (i = 0; i < 9; i++) {
			sprite = [gameObjects objectAtIndex:i];
			[self displaySprite:sprite atIndex:i];
		}
	}
	
	[self setLabel:@"Your Turn"];	
	
	self.isTouchEnabled = YES;
	
	return self;
}

-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];
	//mark the board
	NSLog(@"x/y: %f/%f",location.x,location.y);
	int touched=0;
	touched = [self getTouchedSquare:location];
	if (touched >= 0) {
		GameObject *gameObject = [gameObjects objectAtIndex:touched];

		int mark = 1;
		if (lastTurn == 0) {
			mark = 0;
		}	

		if (gameObject->mark == 0) {
			[self changeSprite:mark index:touched];
			[gameObject onChangedSprite:mark];
			int result = [self isGameOver];
			if (result > 0) {
				[[GameFunctions instance] setWinner: result];
				[[CCDirector sharedDirector] replaceScene: [CCFadeTransition transitionWithDuration:0.5f scene:[GameTitle scene]]];
			}
			else {
				if (mark==1) {
					[self setLabel:@"Your Turn"];
				}
				else {
					[self setLabel:@"My Turn"];
				}

			}
		}
	}
}
-(void) setLabel: (NSString *)text {
	CCNode *nodeObj = [self getChildByTag:-10];
	[self removeChild:nodeObj cleanup:YES];
	
	CCLabel *label = [CCLabel labelWithString:text fontName:@"Marker Felt" fontSize:48];
	CGSize size = [[CCDirector sharedDirector] winSize];				
	
	label.position =  ccp( size.width/2 , size.height/2 + 128 );
	label.color = ccc3(255,255,255);
	[self addChild:label z:0 tag:-10];	
}
-(int) isGameOver {

	if ([self checkIfWin:1]==1) {
		return 1;
	}
	else if ([self checkIfWin:2]==2)
	{
		return 2;
	}
	
	//check if Y has winning sequence.
	//check if
	return 0;
}
-(int) checkIfWin:(int)type {
	//check if X has winning sequence.
	
	// 0 1 2
	// 3 4 5
	// 6 7 8
	
	//check if horizontal i.e. 0 1 2 are same
	//0 1 2
	if ([self checkValue:0]==type) {
		if ([self checkValue:1]==type) {
			if ([self checkValue:2]==type) {
				return type;
			}
		}
	}
	//3 4 5
	if ([self checkValue:3]==type) {
		if ([self checkValue:4]==type) {
			if ([self checkValue:5]==type) {
				return type;
			}
		}
	}
	// 6 7 8
	if ([self checkValue:6]==type) {
		if ([self checkValue:7]==type) {
			if ([self checkValue:8]==type) {
				return type;
			}
		}
	}
	
	//vertical
	//0 3 6
	if ([self checkValue:0]==type) {
		if ([self checkValue:3]==type) {
			if ([self checkValue:6]==type) {
				return type;
			}
		}
	}
	
	//1 4 7
	if ([self checkValue:1]==type) {
		if ([self checkValue:4]==type) {
			if ([self checkValue:7]==type) {
				return type;
			}
		}
	}
	
	//2 5 8
	if ([self checkValue:2]==type) {
		if ([self checkValue:5]==type) {
			if ([self checkValue:8]==type) {
				return type;
			}
		}
	}
	
	//slant
	if ([self checkValue:0]==type) {
		if ([self checkValue:4]==type) {
			if ([self checkValue:8]==type) {
				return type;
			}
		}
	}
	
	if ([self checkValue:2]==type) {
		if ([self checkValue:4]==type) {
			if ([self checkValue:6]==type) {
				return type;
			}
		}
	}	
	
	return 0;
}
-(int) checkValue: (int) index {
	//X = 1, O = 2, blank = 0;
	GameObject *gameObject;
	
	gameObject = [gameObjects objectAtIndex:index];
	int output = gameObject->mark;
//	[gameObject release];
	
	return output;
}
-(void) changeSprite: (int) typevar index: (int) index {
	CCNode *nodeObj = [self getChildByTag:index];
	[self removeChild:nodeObj cleanup:YES];
	CCSprite *sprite = [[CCSprite alloc] init];
	
	if (typevar == 0) {
		sprite = [CCSprite spriteWithFile:@"mark-x.png"];	
		lastTurn = 1;
	}
	else {
		sprite = [CCSprite spriteWithFile:@"mark-o.png"];			
		lastTurn = 0;
	}
//	NSLog(@"lastTurn:%i",lastTurn);
	
	[self displaySprite:sprite atIndex:index];
}
-(int) getTouchedSquare: (CGPoint) location {
	
	NSLog(@"location x/y: %f/%f",location.x,location.y);
	
	int adjustX = 40;
	int adjustY = 285;
	int x = ((int) location.x) - adjustX;
	int y = ((int) (adjustY)) - ((int) location.y);
	int outputX = -1;
	int outputY = -1;
	
	if ((x >= 1) && (x < blockWidth)) {
		outputX = 0;
	}
	else if ((x >= (blockWidth + 6) + 9) && x < (blockWidth * 2) + 9) {
		outputX = 1;
	}
	else if ((x >= (blockWidth * 2) + 18) && x < (blockWidth * 3) + 18) {
		outputX = 2;
	}
	
	if (y >= 1 && (y < blockHeight)) {
		outputY = 0;
	}
	else if (y >= (blockHeight) && y < ((blockHeight * 2) + 6)) {
		outputY = 1;
	}
	else if (y >= ((blockHeight * 2) + 12) && y < ((blockHeight * 3) + 12)) {
		outputY = 2;
	}

	if (outputX == 0 && outputY == 0) {
		return 0;
	}
	else if (outputX == 1 && outputY == 0) {
		return 1;
	}
	else if (outputX == 2 && outputY == 0) {
		return 2;		
	}
	else if (outputX == 0 && outputY == 1) {
		return 3;		
	}
	else if (outputX == 1 && outputY == 1) {
		return 4;		
	}
	else if (outputX == 2 && outputY == 1) {
		return 5;		
	}
	else if (outputX == 0 && outputY == 2) {
		return 6;		
	}
	else if (outputX == 1 && outputY == 2) {
		return 7;		
	}
	else if (outputX == 2 && outputY == 2) {
		return 8;		
	}	
		
	return -1;
}
-(void) displaySprite: (CCSprite *) sprite atIndex: (int) index {
	//display the board.
	// 0 1 2
	// 3 4 5
	// 6 7 8

	CGSize size = [[CCDirector sharedDirector] winSize];
	
	//determine the position of Y
	int spriteY, spriteX;
	
	spriteY = marginTop;
	spriteX = marginLeft;
	
	if (index < 3) {
		spriteY = spriteY + (size.height - blockHeight); 
	}
	else if (index >= 3 && index < 6) {
		spriteY = spriteY + (size.height - (blockHeight * 2)) - 6;
	}
	else {
		spriteY = spriteY + (size.height - (blockHeight * 3)) - 12;
	}
	//the x
	if (index == 0 || index == 3 || index == 6) {
		spriteX = spriteX + (blockWidth * 2);
	}
	else if (index == 1 || index == 4 || index == 7){
		spriteX = spriteX + (blockWidth * 3) + 9;
	}
	else {
		spriteX = spriteX + (blockWidth * 4) + 18;
	}

//	NSLog(@"index:%i SpriteX:%i/SpriteY:%i",index,spriteX,spriteY);
	
	sprite.position = ccp(spriteX,spriteY);
	[self addChild:sprite z:0 tag:index];
}

-(void) displayText: (NSString *) text {
	CCLabel *label = [CCLabel labelWithString:text fontName:@"Arial" fontSize:14];
	CGSize size = [[CCDirector sharedDirector] winSize];
	
	if (lastY==0) {
		lastY = size.height;
	}
	lastY = lastY - marginTop;
	
	label.position =  ccp( marginLeft , lastY );
	[self addChild: label];	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
