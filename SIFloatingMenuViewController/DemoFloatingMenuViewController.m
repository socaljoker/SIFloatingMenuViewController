//
//  DemoFloatingMenuViewController.m
//  SIFloatingMenuViewController
//
//  Created by Shawn Irvin on 4/25/15.
//  Copyright (c) 2015 Shawn Irvin. All rights reserved.
//

#import "DemoFloatingMenuViewController.h"

@interface DemoFloatingMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation DemoFloatingMenuViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMenuItems];
}

-(void)loadMenuItems {
    SIMenuItem *menuItem1 = [SIMenuItem menuItemWithTitle:@"View 1" image:[UIImage imageNamed:@"Image1"]];
    SIMenuItem *menuItem2 = [SIMenuItem menuItemWithTitle:@"View 2" image:[UIImage imageNamed:@"Image2"]];
    SIMenuItem *menuItem3 = [SIMenuItem menuItemWithTitle:@"View 3" image:[UIImage imageNamed:@"Image3"]];
    
    [self.menuTableView setMenuItems:@[menuItem1, menuItem2, menuItem3]];
    
    UIViewController *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 1"];
    UIViewController *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 2"];
    UIViewController *vc3 = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"View 3"];
    
    self.viewControllers = @[vc1, vc2, vc3];
}

@end
