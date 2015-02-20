//
//  User.h
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/18/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(NSArray *)userFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSString *displayName;

@end
