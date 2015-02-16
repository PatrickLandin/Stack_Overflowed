//
//  BurgerContainerViewController.m
//  Stack_Overflowed
//
//  Created by Patrick Landin on 2/16/15.
//  Copyright (c) 2015 pLandin. All rights reserved.
//

#import "BurgerContainerViewController.h"

@interface BurgerContainerViewController ()

@property (strong, nonatomic) UINavigationController *searchVC;
@property (strong, nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;


@end

@implementation BurgerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self addChildViewController:self.searchVC];
  self.searchVC.view.frame = self.view.frame;
  [self.view addSubview:self.searchVC.view];
  [self.searchVC didMoveToParentViewController:self.searchVC];
  self.topViewController = self.searchVC;
  
  UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
  [burgerButton setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
  [burgerButton addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.searchVC.view addSubview:burgerButton];
  self.burgerButton = burgerButton;


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)burgerButtonPressed {
  NSLog(@"burger");
  self.burgerButton.userInteractionEnabled = false;
  __weak BurgerContainerViewController *weakSelf = self;
  
  [UIView animateWithDuration:0.33 animations:^{
    weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x +250, weakSelf.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
  }];
}

#pragma mark - Property Getters
-(UINavigationController *)searchVC {
  if (!_searchVC) {
    _searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SEARCH_VC"];
  }
  return _searchVC;
}

@end
