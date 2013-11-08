//
//  ResponseValidator.h

//
//  Created by segate on 13/06/13.
//  Copyright (c) 2013 noworries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIConstants.h"

@interface ResponseValidator : NSObject

- (BOOL) validatingResponse :(NSDictionary *) dic :(apistate)apiType ;
@end
