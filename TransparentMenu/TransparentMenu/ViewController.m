//
//  ViewController.m
//  TransparentMenu
//
//  Created by Vincent Ngo on 3/7/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import "ViewController.h"
#import "VVNTransparentView.h"
#import "CompanyCell.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *companylist;

//Key: companyName Value: awesomeFont \u{Code}
@property (nonatomic, strong) NSDictionary *companyDict;

@property (nonatomic, strong) VVNTransparentView *transparentView;

@property (nonatomic, assign) NSInteger selectedCell;

@property (nonatomic, strong) UIBarButtonItem *menuBarButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Keep track of the order this should be in.
    self.companylist = @[@"Apple", @"Linux", @"Twitter", @"Facebook", @"Github", @"Linkedin", @"Android", @"Instagram"];
    
    //Stores the awesomefont id that cooresponds to the company name. 
    self.companyDict = @{@"Apple": @"\uf179", @"Linux" : @"\uf17c", @"Twitter" : @"\uf099", @"Facebook" : @"\uf09a", @"Github" : @"\uf113", @"Linkedin" : @"\uf0e1", @"Android" : @"\uf17b", @"Instagram" : @"\uf16d"};
    
//    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.hidesBackButton = YES;
//    self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;

    //Add Ellipse Menu Button
    self.menuBarButton = [[UIBarButtonItem alloc] initWithTitle:@"^_^"
                                                          style:UIBarButtonItemStyleDone target:self action:@selector(showMenu)];
    UIFont *font = [UIFont fontWithName:@"fontawesome" size:20];
    [self.menuBarButton setTitleTextAttributes:@{NSFontAttributeName: font} forState:UIControlStateNormal];
    [self.menuBarButton setTitle:@"\uf142"];
    self.navigationItem.rightBarButtonItem = self.menuBarButton;
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu
{
    self.transparentView = [[VVNTransparentView alloc]initWithFrame:self.view.frame];
    [self.transparentView showView];
    
    // Add a tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.transparentView.frame.size.width, self.transparentView.frame.size.height - 64 - 150)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.transparentView addSubview:self.tableView];

    
}

#pragma mark - TableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companylist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyCell *cell;
    static NSString *cellId = @"companyCell";
    
    UINib *nib = [UINib nibWithNibName:@"CompanyCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellId];
    cell = (CompanyCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSString *companyName = self.companylist[indexPath.row];
    NSString *companyCode = self.companyDict[companyName];
    UIFont *awesomeFont = [UIFont fontWithName:@"FontAwesome" size:25.0f];
    UIFont *biggerFont = [UIFont fontWithName:@"HelveticaNeue-bold" size:17.0f];
    UIFont *currentFont = cell.titleLabel.font;
    
    cell.titleLabel.text = companyName;
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.iconLabel.font = awesomeFont;
    cell.iconLabel.text = companyCode;
    cell.iconLabel.textAlignment = NSTextAlignmentCenter;
    cell.iconLabel.textColor = [UIColor whiteColor];
    
    cell.titleLabel.font = (self.selectedCell == indexPath.row) ? biggerFont : currentFont;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = 0;
    
    [UIView beginAnimations:@"opacity" context:nil];
    [UIView setAnimationDuration:0.8];
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyCell *cell = (CompanyCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [tableView setUserInteractionEnabled:NO];
    [cell animateCellWithStyle:CCAnimationStyleRubberBand completion:^(BOOL finished) {
        [tableView setUserInteractionEnabled:YES];
        self.selectedCell = indexPath.row;
        [self.transparentView closeView];
    }];
}


//Code to transition to another view.
//UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AppleViewController"];
//[vc setModalPresentationStyle:UIModalPresentationFullScreen];
////    [self presentViewController:vc animated:NO completion:nil];
//[self.navigationController pushViewController:vc animated:NO];



@end
