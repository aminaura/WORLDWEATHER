//
//  CapitalStrManager.m
//  Tobae
//
//  Created by 菅野楓 on 2015/10/03.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import "CapitalStrManager.h"

@implementation CapitalStrManager

static CapitalStrManager *sharedData_ = nil;

+ (CapitalStrManager *)sharedManager{
    if (!sharedData_) {
        sharedData_ = [CapitalStrManager new];
    }
    return sharedData_;
}

- (id)init
{
    self = [super init];
    if (self) {
        //Initialization
    }
    return self;
}
@end
