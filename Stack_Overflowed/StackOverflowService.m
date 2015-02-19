//
//  StackOverflowService.m
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/17/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "StackOverflowService.h"
#import "Question.h"
#import "User.h"

@implementation StackOverflowService

+(id)sharedService {
  static StackOverflowService *mySharedService;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    mySharedService = [[StackOverflowService alloc] init];
  });
  return mySharedService;
}

-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error)) completionHandler {
  
  NSString *urlString = @"https://api.stackexchange.com/2.2/";
  urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
  urlString = [urlString stringByAppendingString:searchTerm];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
  if (token) {
    urlString = [urlString stringByAppendingString:@"&access_token="];
    urlString = [urlString stringByAppendingString:token];
    urlString = [urlString stringByAppendingString:@"&key=eByCR*OYinRmcBCqW2XeqQ(("];
  }
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      completionHandler(nil,@"Couldn't connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          NSArray *results = [Question questionsFromJSON:data];
          
          dispatch_async(dispatch_get_main_queue(), ^{
            if (results) {
              completionHandler(results,nil);
            } else {
              completionHandler(nil,@"Search sucked");
            }
          });
          break;
        }
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }
    }
  }];
  [dataTask resume];
}

-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler {
  
  dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
  dispatch_async(imageQueue, ^{
    NSURL *url = [NSURL URLWithString:avatarURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(image);
    });
  });
}

-(void)fetchUser:(void (^)(NSArray *results, NSString *error)) completionHandler {

  NSString *urlString = @"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow";
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults objectForKey:@"token"];
  if (token) {
    urlString = [urlString stringByAppendingString:@"&access_token="];
    urlString = [urlString stringByAppendingString:token];
    urlString = [urlString stringByAppendingString:@"&key=eByCR*OYinRmcBCqW2XeqQ(("];
  }
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
  urlRequest.HTTPMethod = @"GET";
  
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      completionHandler(nil, @"couldn't connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      switch (statusCode) {
        case 200 ... 299: {
          NSLog(@"%ld",(long)statusCode);
          break;
        }
        default:
          NSLog(@"Crap! Status code %ld",(long)statusCode);
          break;
      }
    }
  }];
  [dataTask resume];
}


@end
