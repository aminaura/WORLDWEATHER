//
//  WeatherViewController.h
//  Tobae
//
//  Created by 菅野楓 on 2015/09/13.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController
{
    IBOutlet UILabel *Capitalla;
    IBOutlet UILabel *countryla;
    IBOutlet UILabel *temperaturela;
    
    IBOutlet UIView *view1;
    IBOutlet UIView *view6;
    
    NSDate *date;
}
@end
