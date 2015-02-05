//
//  USHService.h
//  UsherClient
//
//  Created by Adam Gluck on 2/4/15.
//  Copyright (c) 2015 Usher. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const USHServiceRestaurantsUpdated;
extern NSString * const USHServiceRestaurantsInfoKey;

@interface USHService : NSObject

#define USHServiceSharedInstance ((USHService *)[USHService sharedInstance])

+ (id)sharedInstance;
- (void)start;

@end
