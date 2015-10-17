//
//  VerticalTableViewCell.h
//  Tobae
//
//  Created by 菅野楓 on 2015/08/17.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalTableViewCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *horizontalTableView;
@property(nonatomic, strong) NSMutableArray *weather_capital;
@property int row_num;
@property (nonatomic,strong) NSString * capitalstr;
- (void)buildHorizontalTableView;
@end