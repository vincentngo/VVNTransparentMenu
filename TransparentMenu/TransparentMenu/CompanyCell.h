//
//  CompanyCell.h
//  TransparentMenu
//
//  Created by Vincent Ngo on 3/8/14.
//  Copyright (c) 2014 Vincent Ngo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CCAnimationStyle) {
    CCAnimationStyleRubberBand = 0,
    CCAnnimationStyleScale = 1,
};

@interface CompanyCell : UITableViewCell

-(void)animateCellWithStyle: (CCAnimationStyle)style completion:(void (^)(BOOL finished))completed;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *iconLabel;


@end
