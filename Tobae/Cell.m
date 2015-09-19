//
//  Cell.m
//  Tobae
//
//  Created by 菅野楓 on 2015/08/29.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)loadFromNib{
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

@end
