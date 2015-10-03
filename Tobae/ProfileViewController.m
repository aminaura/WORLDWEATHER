//
//  ProfileViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/09/20.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    NSMutableArray *favoritecapital;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    favoritecapital = @[@"Tokyo",
                                        @"Washington,D.C",
                                        @"London",
                                        @"Beijing",
                                        @"Moscow"
                                        ].mutableCopy;
    
    
    
    NSInteger pageSize = favoritecapital.count; // ページ数
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    // UIScrollViewのインスタンス化
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    
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
    
    // ページコントロールのインスタンス化
    CGFloat x = (width - 300) / 2;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(x, 350, 300, 50)];
    
    // 背景色を設定
    pageControl.backgroundColor = [UIColor blackColor];
    
    // ページ数を設定
    pageControl.numberOfPages = pageSize;
    
    // 現在のページを設定
    pageControl.currentPage = 0;
    
    // ページコントロールをタップされたときに呼ばれるメソッドを設定
    pageControl.userInteractionEnabled = YES;
    [pageControl addTarget:self
                    action:@selector(pageControl_Tapped:)
          forControlEvents:UIControlEventValueChanged];
    
    // ページコントロールを貼付ける
    [self.view addSubview:pageControl];
}

/**
 * スクロールビューがスワイプされたとき
 * @attention UIScrollViewのデリゲートメソッド
 */
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    if ((NSInteger)fmod(scrollView.contentOffset.x , pageWidth) == 0) {
        // ページコントロールに現在のページを設定
        pageControl.currentPage = scrollView.contentOffset.x / pageWidth;
    }
    capitalla.text = [NSString stringWithFormat:@"%@",favoritecapital[(int)pageControl.currentPage]];
}

/**
 * ページコントロールがタップされたとき
 */
- (void)pageControl_Tapped:(id)sender
{
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    [scrollView scrollRectToVisible:frame animated:YES];
}

@end
