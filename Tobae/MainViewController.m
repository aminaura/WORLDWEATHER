//
//  MainViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/09.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#define pageCount 3
#import "MainViewController.h"
#import "CapitalStrManager.h"
#import <Parse/Parse.h>

@interface MainViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@end

@implementation MainViewController{
    
    UIImage *selectedImage;
    
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *commentlabel;
    IBOutlet UILabel *usernamelabel;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    
    NSMutableArray * array;
    NSDictionary * weather_icon;
    
    UIImageView *img;
    UIButton *button;
    
}

// ページ数は最大で11までらしい
#define kNumberOfPages 11

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self getUserImage];
    [self getComment];
    [self getUserName];
    
    PFUser *user = [PFUser currentUser];
    array = [user objectForKey:@"favorites"];
    
    NSInteger pageSize = array.count; // ページ数
    //self.view.bounds.size.width
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = 285;
    
    scrollView.backgroundColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    
    // 横スクロールのインジケータを非表示にする
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // ページングを有効にする
    scrollView.pagingEnabled = YES;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.delegate = self;
    
    // スクロールの範囲を設定
    [scrollView setContentSize:CGSizeMake((pageSize * width), height)];
    
    // スクロールビューを貼付ける
    [self.view addSubview:scrollView];
    
    // スクロールビューにラベルを貼付ける
    for (int i = 0; i < pageSize; i++) {
        
        NSString *name = array[i];
        NSString *URL_String = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json&units=metric&cnt=7&appid=b8f4ce09ae1ca4d1b34a14438e857866",name];
        
        
        NSURL *url = [NSURL URLWithString: URL_String];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSError *error;
        NSURLResponse *responce;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responce error:&error];
        
        
        if(error == nil){
            if(data.length){
                
                NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                
                // ⑦ weather.mainの値を抽出
                NSArray *main = [object valueForKeyPath:@"list.weather.main"]; //天候
                NSArray *description = [object valueForKeyPath:@"list.weather.description"]; // 天候詳細
//                NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
                NSArray *icons = [object valueForKeyPath:@"list.weather.icon"];
                
                
                NSLog(@"main(天候)=%@,description(天候詳細)=%@,icons(天気アイコン)=%@",main,description,icons);
                
                NSMutableDictionary *weather= @{@"main":main,
                                                @"description":description,
                                                @"icons":icons}.mutableCopy;
                
                
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
                
                
                //         UILabel作成
                NSLog(@"i * width = %f",(i * width));
                button = [[UIButton alloc]initWithFrame:CGRectMake(i * width + 90, 240, 210, 26)];
                [button setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont fontWithName:@"Century Gothic" size:19];
                button.titleLabel.textColor = [UIColor whiteColor];
                button.titleLabel.textAlignment = NSTextAlignmentLeft;
                [button addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchDown];
                [scrollView addSubview:button];
                
                button = [[UIButton alloc]initWithFrame:CGRectMake(i * width + 90, 20, 210, 210)];
                NSArray *imageKeyname = icons[0];
                NSLog(@"imageKeyname = %@",imageKeyname);
                UIImage *iconimg = [weather_icon objectForKey:imageKeyname[0]];
                [button setBackgroundImage:iconimg forState:UIControlStateNormal];
                [button addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchDown];
                [scrollView addSubview:button];
                
                
                NSLog(@"imagenum:%d",i);
            
            // ページ数を設定
            pageControl.numberOfPages = pageSize;
            
            // 現在のページを設定
            pageControl.currentPage = 0;
            
            // デフォルトの色
            pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
            // 選択されてるページを現す色
            pageControl.currentPageIndicatorTintColor =  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            
            // ページコントロールをタップされたときに呼ばれるメソッドを設定
            pageControl.userInteractionEnabled = YES;
            [pageControl addTarget:self
                            action:@selector(pageControl_Tapped:)
                  forControlEvents:UIControlEventValueChanged];
            
            // ページコントロールを貼付ける
            [self.view addSubview:pageControl];
            
            }
        }
        else{
            
        }
        
      
    
}
}

-(void)viewWillAppear:(BOOL)animated {
    [self getUserImage];
    [self getComment];
    [self getUserName];
    [self.view setNeedsDisplay];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)getUserImage {
    PFUser *user = [PFUser currentUser];
    PFFile *file = user[@"image"];
    NSData *imageData = [file getData];
    UIImage *userImage = [UIImage imageWithData:imageData];
    imageView.image = userImage;
}

- (void)getComment {
    PFUser *user = [PFUser currentUser];
    commentlabel.text = user[@"Comments"];
}

- (void)getUserName {
    PFUser *user = [PFUser currentUser];
    usernamelabel.text = user.username;
}

-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// スクロールビューがスワイプされたとき
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
}

// ページコントロールがタップされたとき
- (void)pageControl_Tapped:(id)sender {
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    [scrollView scrollRectToVisible:frame animated:YES];
}

-(void)goDetail{
    
    NSInteger currentPage = pageControl.currentPage;
    
    [CapitalStrManager sharedManager].capitalstr = [NSString stringWithFormat:@"%@",array[currentPage]];
    
    [CapitalStrManager sharedManager].icon = img.image;

    
    [self performSegueWithIdentifier:@"GoDetail" sender:self];
}




@end
