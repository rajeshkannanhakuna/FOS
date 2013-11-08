//
//  LoadingView.m
//  OneLead
//


#import "LoadingView.h"
#import "UIConstants.h"
#import "LanguageConstants.h"
@implementation LoadingView

- (id)initWithFrame:(CGRect)frame {
  //  CGFloat hight = 568;
//    if ([[[UIConstants initObject]strScreenHight] isEqualToString:[NSString stringWithFormat:@"%f",hight]]) {
//        frame = CGRectMake(0,0,320,hight);
//    }else{
//        frame = CGRectMake(0,0,320,480);
//    }
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
		// BG image
		UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"transparent_bg.png"]];
        imgView.frame = CGRectMake(0,0,320,frame.size.height);
		imgView.backgroundColor = [UIColor clearColor];
        imgView.alpha = 0.5;
		[self addSubview:imgView];
		[imgView release],imgView = nil;
		
		// Inner bg image
		UIImageView *innerimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"innerbox.png"]];
		innerimgView.frame = CGRectMake(75.5,197.5,169,65);
		innerimgView.backgroundColor = [UIColor clearColor];
		[self addSubview:innerimgView];
		[innerimgView release],innerimgView = nil;
		
		// Activity controller
		UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(90,215,30,30)];
		[activity startAnimating];
		activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		[self addSubview:activity];
		[activity release],activity = nil;
		
		// Loading Text
		UILabel *loadingTxt = [[UILabel alloc] initWithFrame:CGRectMake(120,197.5,139,65)];
		loadingTxt.text = @"Loading...";
		loadingTxt.textColor = [UIColor whiteColor];
		loadingTxt.backgroundColor = [UIColor clearColor];
		loadingTxt.textAlignment = NSTextAlignmentCenter;
		loadingTxt.font = [UIFont boldSystemFontOfSize:17];
		[self addSubview:loadingTxt];
		[loadingTxt release],loadingTxt = nil;
		
    }
    return self;
	
}

- (id) initLoading {
	//[[UIApplication sharedApplication] keyWindow].userInteractionEnabled = NO;
	UIView *lViewobj = [self  initWithFrame:CGRectZero];
	UIWindow* mWindow = [[UIApplication sharedApplication] keyWindow];
    mWindow.userInteractionEnabled = NO;
	[mWindow addSubview:lViewobj];
	return (id)lViewobj;
}

- (void) removeLoadingView {
	[[UIApplication sharedApplication] keyWindow].userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

@end
