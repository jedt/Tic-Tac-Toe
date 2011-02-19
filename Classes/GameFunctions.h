@interface GameFunctions : NSObject {
	int winner;
}
+ (GameFunctions *)instance;
-(void) setWinner: (int) value;
-(int) getWinner;
@end