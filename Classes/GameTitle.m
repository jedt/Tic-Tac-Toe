//
//  Title.m
//  tictactoe
//
//  Created by Jed Tiotuico on 2/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameTitle.h"

@implementation GameTitle

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.T
	GameTitle *layer = [GameTitle node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{	
	NSLog(@"here:init");
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	
	if( (self=[super init] )) {
		[self setUpMenus];		

		if ([[GameFunctions instance] getWinner] > 0) {
			NSString *text;
			if ([[GameFunctions instance] getWinner] == 1) {
				text = @"You win!!";
			}
			else {
				text = @"You lose!!";
			}

			CCLabel *label = [CCLabel labelWithString:text fontName:@"Marker Felt" fontSize:48];
			label.color = ccc3(255,255,0);
			
			CGSize size = [[CCDirector sharedDirector] winSize];
			
			
			label.position =  ccp( size.width/2 , size.height/2 + 48 );
			[self addChild: label];				
		}
		
		
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];		
	}
	
	self.isTouchEnabled = YES;	
	return self;
}
	
-(void)setUpMenus {
	CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage:@"play.png"
														 selectedImage: @"play-selected.png"
																target:self
															  selector:@selector(play:)];	
	CCMenu *myMenu = [CCMenu menuWithItems:menuItem1, nil];
	[myMenu alignItemsVertically];
	[self addChild:myMenu];
	
}
- (void) play: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [CCFadeTransition transitionWithDuration:0.5f scene:[TicTacToe scene]]];
	
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	return YES;
}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
