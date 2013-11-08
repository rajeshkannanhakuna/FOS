
//
//  ServiceInvoker.m

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import "ServiceInvoker.h"
#import "UIConstants.h"
#import "APIConstants.h"
#import "LanguageConstants.h"
#import "JSON.h"

UIAlertView *alert1;

@implementation ServiceInvoker

// Server downloading
-(NSDictionary *)InvokingAPI:(NSMutableString *)baseUrl Parameters:(NSString *) param
{
    NSString *_strLanguage = nil;
    NSString *_strAlertService;
//    if ([[UIConstants returnInstance] strLanguage] == lang_Arabic) {
    if(![[UIConstants returnInstance] isItEnglish]){
        _strLanguage = code_lang_Arabic;
        _strAlertService = Alert_ServiceIsNotAvailable_Arabic;
    }else{
        _strLanguage = code_lang_English;
        _strAlertService = Alert_ServiceIsNotAvailable_English;
    }
    int statuscode = 0;
    if ([self checkInternet]) {
        [self performSelectorInBackground:@selector(invokeLoadingScreen) withObject:nil];
    
        NSData *postData = [param dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
       // NSData *postData = [[NSData dataWithData:param];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSLog(@"%@  %@",baseUrl,param);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseUrl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField: @"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField: @"content-type"];
        //[request setValue:@"application/json" forHTTPHeaderField:@"GG-MOBILE-APP"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"FOS" forHTTPHeaderField:@"tenant-code"];
        [request setValue:_strLanguage forHTTPHeaderField:@"language"];
        [request setValue:@"FCC-VEDNAR125487" forHTTPHeaderField:@"access-key"];
        [request setValue:@"ADSB234CDJKKLRR112" forHTTPHeaderField:@"pass-key"];

        [request setHTTPBody:postData];
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        [self disableLoadingScreen];
        statuscode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"statuscode: %i",statuscode);
        
        NSString *str = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"Server Response : %@",str);
        
        if(nil != responseData && statuscode == 200){
            // JSON Conversion
            return [str JSONValue];
        }else{
            return [NSDictionary dictionaryWithObjectsAndKeys:@"1000", key_StatusCode,_strAlertService, key_StatusMessage, nil];
        }
    }else{
        return [NSDictionary dictionaryWithObjectsAndKeys:@"2000", key_StatusCode,@"No Internet Connection.", key_StatusMessage, nil];
    }
    return nil;
}

-(void)invokeLoadingScreen{
    ctrlLoadingScreen=[[LoadingView alloc]init];
    [ctrlLoadingScreen initLoading];
}
-(void)disableLoadingScreen{
    [ctrlLoadingScreen removeLoadingView];
    [ctrlLoadingScreen removeFromSuperview];
    [ctrlLoadingScreen release];
    ctrlLoadingScreen = Nil;
}

-(NSDictionary *)CheckStatusCode:(NSDictionary *)Dictionary
{
//#warning status code shouldn't be null
//    if ([Dictionary valueForKey:key_StatusCode] == [NSNull null]) {
//        return Dictionary;
//    }
    if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 200) {
        return Dictionary;
    }else if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 405) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Service is not available", key_StatusMessage, nil];
    }else if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 500) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Content type is not supported", key_StatusMessage, nil];
    }else if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 401) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Authentication Failed", key_StatusMessage, nil];
    }else if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 404) {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"Internal server Error, Contact Administrator", key_StatusMessage, nil];
//    }else if ([[Dictionary valueForKey:key_StatusCode] integerValue] == 400) {
//        return [NSDictionary dictionaryWithObjectsAndKeys:@"Internal server Error, Contact Administrator", key_StatusMessage, nil];
    }else{
        return Dictionary;
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"Server Down, Please try again later.", key_StatusMessage, nil];
}

-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
//    for (UIWindow* window in [UIApplication sharedApplication].windows) {
//        NSArray* subviews = window.subviews;
//        for (UIView *view in subviews) {
//            if ([view isKindOfClass:[UIAlertView class]])
//                [(UIAlertView *)view dismissWithClickedButtonIndex:0 animated:YES];
//        }
//    }
    [[UIConstants returnInstance] RemoveAlertView];
	if(![[UIConstants returnInstance] connectedToNetwork])
	{
//        alert1 = [[UIAlertView alloc] initWithTitle:@"No Network Connection"
//                                            message:@"No network connection found.Internet connection is required. Please enable your WiFi or 3G connection and reopen the application."
//                                           delegate:self
//                                  cancelButtonTitle:nil
//                                  otherButtonTitles:nil];
//        alert1.delegate = self;
//        [alert1 show];
//        [alert1 release];
		return NO;
	}else {
		return YES;
	}
}
@end
