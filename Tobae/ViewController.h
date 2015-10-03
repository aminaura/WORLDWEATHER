//
//  ViewController.h
//  Tobae
//
//  Created by 菅野楓 on 2015/08/17.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VerticalTableViewCell.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *verticalTableView;

@end