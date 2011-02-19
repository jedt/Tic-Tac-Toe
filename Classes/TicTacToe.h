//
//  HelloWorldLayer.h
//  tictactoe
//
//  Created by Jed Tiotuico on 2/11/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameObject.h"
#import "GameTitle.h"
#import "CCTouchDispatcher.h"
#import "GameFunctions.h"

@interface TicTacToe : CCLayer
{
	int lastY;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void) displaySquare: (NSString *) text;
-(void) displaySprite: (CCSprite *) sprite atIndex: (int) index;
-(int) getTouchedSquare:(CGPoint) location;
-(void) changeSprite: (int)typevar index:(int)indexvar;
-(int) isGameOver;
-(int) checkValue: (int) index;
-(int) checkIfWin: (int) type;
-(void) setLabel:(NSString *)text;

@end
