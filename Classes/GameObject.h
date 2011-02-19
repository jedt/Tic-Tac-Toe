//
//  GameObject.h
//  tictactoe
//
//  Created by Jed Tiotuico on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface GameObject : CCSprite {
	@public int mark;
}
-(void)onChangedSprite: (int) type;
@end
