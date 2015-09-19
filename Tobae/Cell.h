//
//  Cell.h
//  Tobae
//
//  Created by 菅野楓 on 2015/08/29.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UIImageView *weather_icon_image;

+ (id)loadFromNib;

@end
