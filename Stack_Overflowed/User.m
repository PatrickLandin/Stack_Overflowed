//
//  User.m
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/18/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "User.h"

@implementation User

+(NSArray *)userInfoFromJSON:(NSData *)jsonData {
  
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (error) {
    NSLog(@"%@", error.localizedDescription);
    return nil;
  }
  NSArray *items = [jsonDictionary objectForKey:@"items"];
  NSMutableArray *temp = [[NSMutableArray alloc] init];
  
  for (NSDictionary *item in items) {
    User *user = [[User alloc] init];
    user.location = item[@"location"];
    user.displayName = item[@"display_name"];
    
    [temp addObject:user];
  }
  NSArray *final = [[NSArray alloc] initWithArray:temp];
  return final;
}

@end
