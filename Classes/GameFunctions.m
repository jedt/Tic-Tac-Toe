#import "GameFunctions.h"

@implementation GameFunctions
+ (GameFunctions *)instance  {
	static GameFunctions *instance;
	
	@synchronized(self) {
		if(!instance) {
			instance = [[GameFunctions alloc] init];
		}
	}
	
	return instance;
}
-(void) setWinner:(int)value {
	winner = value;
}
-(int) getWinner {
	return winner;
}
@end