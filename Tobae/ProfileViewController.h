//
//  ProfileViewController.h
//  Tobae
//
//  Created by 菅野楓 on 2015/09/20.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UIScrollViewDelegate> 
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
    IBOutlet UILabel *capitalla;
    IBOutlet UIImageView *img;
}

@end
