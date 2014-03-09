//
//  AppleViewController.m
//  TransparentMenu
//
//  Created by Vincent Ngo on 3/8/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import "AppleViewController.h"

@interface AppleViewController ()

@end

@implementation AppleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
        [self.navigationController popViewControllerAnimated:NO];
}
@end
