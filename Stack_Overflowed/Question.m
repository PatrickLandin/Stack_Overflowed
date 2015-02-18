//
//  Question.m
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/17/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "Question.h"

@implementation Question

+(NSArray *)questionsFromJSON:(NSData *)jsonData {
  
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (error) {
    NSLog(@"%@", error.localizedDescription);
    return nil;
  }
  NSArray *itmes = [jsonDictionary objectForKey:@"items"];
  NSMutableArray *temp = [[NSMutableArray alloc] init];
  
  for (NSDictionary *item in itmes) {
    Question *question = [[Question alloc] init];
    question.title = item[@"title"];
    NSDictionary *userInfo = item[@"owner"];
    question.avatarURL = userInfo[@"profile_image"];
    
    [temp addObject:question];
  }
  NSArray *final = [[NSArray alloc] initWithArray:temp];
  return final;
}

@end
