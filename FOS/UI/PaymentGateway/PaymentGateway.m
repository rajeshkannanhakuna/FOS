//  PaymentGateway.m
//  FOS
//

#import "PaymentGateway.h"
#import "UIConstants.h"
#import "LanguageConstants.h"

@interface PaymentGateway ()

@end

@implementation PaymentGateway
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *strLang;
    lblScreenName.font = [[UIConstants returnInstance] returnCharcoalCY:16];
    btnGoBack.titleLabel.font = [[UIConstants returnInstance] returnArvoBold:12];
    if ([[UIConstants returnInstance] isItEnglish]) {
        lblScreenName.text = OnlinePaymentScreenName_English;
        strLang = code_lang_English;
    }else{
        strLang = code_lang_Arabic;
        lblScreenName.text = OnlinePaymentScreenName_Arabic;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.229.122.177:8080/fosmobile/Mobile.do?fun=paymentDetails&orderNumber=%@&lang=%@",[[UIConstants returnInstance] strOrderNumber],strLang]];
    NSLog(@"URL for checkout:%@", url);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webViewPaymentGateway loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action Methods

-(void)OnClickGoBackButton:(id)sender
{
    [[UIConstants returnInstance] setIsBackFromPaymentOrMobileVerify:YES];
    [self.delegate commonBack];
}

-(void)OnClickGoHomeButton:(id)sender
{
    [self.delegate GoHome];
}

#pragma mark - WebView Delegate Methods

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Inside Did fail with error: %@", error.description);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Inside Did Finish Load");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Inside Should Start Load method.");
    return YES;
}

@end
