//
//  GameObject.m
//  tictactoe
//
//  Created by Jed Tiotuico on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

-(void) onChangedSprite: (int) type {
	if (type==0) {
		mark = 1;
	}
	else {
		mark = 2;
	}

}

@end
