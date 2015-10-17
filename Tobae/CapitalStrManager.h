//
//  CapitalStrManager.h
//  Tobae
//
//  Created by 菅野楓 on 2015/10/03.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CapitalStrManager: NSObject

@property (nonatomic, strong) NSString *capitalstr;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *rainfall;
@property (nonatomic, strong) NSString *sunrise;
@property (nonatomic, strong) NSString *sunset;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *dayoftheweek;


+ (CapitalStrManager *)sharedManager;


@end