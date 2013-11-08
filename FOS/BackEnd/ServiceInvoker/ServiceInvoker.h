//
//  ServiceInvoker.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingView.h"
@interface ServiceInvoker : NSObject<UIAlertViewDelegate>
{
 LoadingView *ctrlLoadingScreen;
}
-(NSDictionary *)InvokingAPI:(NSString *)baseUrl Parameters:(NSString *) param;
- (NSDictionary *) CheckStatusCode:(NSDictionary *)Dictionary;
@end
