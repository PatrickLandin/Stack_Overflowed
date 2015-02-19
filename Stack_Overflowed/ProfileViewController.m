//
//  ProfileViewController.m
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/18/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "ProfileViewController.h"
#import "StackOverflowService.h"
#import "User.h"

@interface ProfileViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLocationLabel;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *userInfo;
@property (strong, nonatomic) User* theUser;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSLog(@"View did loaded!");
  
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  self.scrollView.contentSize = CGSizeMake(1999, 1999);
  [self.view addSubview:self.scrollView];
  
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 1000, 100, 50)];
  textField.backgroundColor = [UIColor purpleColor];
  [self.scrollView addSubview:textField];
  [textField release];
  self.scrollView.delegate = self;
 
 [[StackOverflowService sharedService] fetchUser:^(NSArray *results, NSString *error) {
   self.userInfo = results;
   self.theUser = self.userInfo.lastObject;
   self.displayNameLabel.text = self.theUser.displayName;
   self.userLocationLabel.text = self.theUser.location;
 }];
  
  // Do any additional setup after loading the view.
}

-(void)dealloc {
  [self.scrollView release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
