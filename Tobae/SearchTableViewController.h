//
//  SearchTableViewController.h
//  Tobae
//
//  Created by 菅野楓 on 2015/09/09.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *searchtableview;
@property (nonatomic,strong) UITableViewCell *searchcell;

@end
