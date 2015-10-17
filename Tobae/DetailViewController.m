//
//  DetailViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/10/03.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import "DetailViewController.h"
#import "VerticalTableViewCell.h"
#import "CapitalStrManager.h"

@interface DetailViewController ()
{
    NSDictionary * array;
    NSMutableArray * country;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    capitallabel.text = [CapitalStrManager sharedManager].capitalstr;
    [self requestWeather];
}

-(void)getdate{
    date  = [NSDate date];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 年・月・日を取得
    flags = NSCalendarUnitMonth| NSCalendarUnitDay;
    comps = [calendar components:flags fromDate:now];
    
    NSInteger month = comps.month;
    NSInteger day = comps.day;
    
    for(int i = 0; i < 6; i ++){
        UILabel *label = datelabels[i];
        label.text = [NSString stringWithFormat:@"%ld/%ld",month,day];
    }
    
}

- (void)requestWeather {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=JSON&units=metric&cnt=7", [CapitalStrManager sharedManager].capitalstr]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error = nil;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    // NSLog(@"Object == %@", [[object valueForKey:@"list"] valueForKey:@"weather"][0]);
    NSLog(@"Error == %@", error);
    
    [self setWeatherImages:[[object valueForKey:@"list"] valueForKey:@"weather"]];
}

- (void)setWeatherImages: (NSArray *)weather {
    NSLog(@"%@", [weather[0] valueForKey:@"icon"][0]);
    if ([[weather[0] valueForKey:@"icon"][0] isEqualToString:@"01d"]) {
        image.image = [UIImage imageNamed:@"01.png"];
    }
}



/*
 weather_icon = @{//day
 @"01d":[UIImage imageNamed:@"01.png"],
 @"02d":[UIImage imageNamed:@"02.png"],
 @"03d":[UIImage imageNamed:@"09.png"],
 @"04d":[UIImage imageNamed:@"12.png"],
 @"09d":[UIImage imageNamed:@"11.png"],
 @"10d":[UIImage imageNamed:@"05.png"],
 @"11d":[UIImage imageNamed:@"13.png"],
 @"13d":[UIImage imageNamed:@"15.png"],
 @"50d":[UIImage imageNamed:@"10.png"],
 //night
 @"01n":[UIImage imageNamed:@"17.png"],
 @"02n":[UIImage imageNamed:@"18.png"],
 @"03n":[UIImage imageNamed:@"09.png"],
 @"04n":[UIImage imageNamed:@"12.png"],
 @"09n":[UIImage imageNamed:@"22.png"],
 @"10n":[UIImage imageNamed:@"21.png"],
 @"11n":[UIImage imageNamed:@"23.png"],
 @"13n":[UIImage imageNamed:@"24.png"],
 @"50n":[UIImage imageNamed:@"19.png"]};
 */

@end
