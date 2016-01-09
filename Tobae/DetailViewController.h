//
//  DetailViewController.h
//  Tobae
//
//  Created by 菅野楓 on 2015/10/03.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    IBOutlet UIImageView * image;
    IBOutlet UILabel * capitallabel;
    IBOutlet UILabel * countrylabel;
    IBOutlet UILabel * temperaturela;
    IBOutletCollection (UILabel) NSArray *datelabel;
    IBOutletCollection (UIImageView) NSArray *imageViews;
    IBOutletCollection (UILabel) NSArray *rainfallla;
    
    IBOutletCollection (UILabel) NSArray *weekdayla;
    
    IBOutletCollection (UILabel) NSArray *templa;
    IBOutlet UILabel *humidityla;
    
    IBOutlet UILabel *sunrise;
    IBOutlet UILabel *sunset;
    NSDate * date;
}
-(IBAction)back;
@end
