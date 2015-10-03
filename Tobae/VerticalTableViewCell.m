//
//  VerticalTableViewCell.m
//  Tobae
//
//  Created by 菅野楓 on 2015/08/17.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//


#import "VerticalTableViewCell.h"
#import "Cell.h"



@interface VerticalTableViewCell(){
    NSDictionary *weather_icon;
    
    NSString *weatherstr;
}

@end

static NSString * const TableViewCustomCellIdentifier = @"Cell";

@implementation VerticalTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UINib *nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [self.horizontalTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)buildHorizontalTableView
{
    CGRect frame = CGRectMake(0, 0, 140.0, [UIScreen mainScreen].bounds.size.width);
    self.horizontalTableView = [[UITableView alloc] initWithFrame:frame];
    
    // horizontalセルのdelegate等を設定
    self.horizontalTableView.delegate = self;
    self.horizontalTableView.dataSource = self;
    
    // 横スクロールに変更
    self.horizontalTableView.center = CGPointMake(self.horizontalTableView.frame.origin.x + self.horizontalTableView.frame.size.height / 2, self.horizontalTableView.frame.origin.y + self.horizontalTableView.frame.size.width / 2);
    self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    
    // セルの再利用登録
    [self.horizontalTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_object"];
    
    // tableViewを追加
    [self addSubview:self.horizontalTableView];
    
    _horizontalTableView.backgroundColor =  [UIColor colorWithHue:0.0
                                                       saturation:0.0
                                                       brightness:0.22
                                                            alpha:1.0];
}

-(Cell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    

    // horizontalのセルを生成
    static NSString *CellIdentifier = @"Cell";
    Cell *cell_object = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell_object == nil){
        cell_object = [Cell loadFromNib];
    }
    
/*    NSDictionary *weathers = [self getweather:self.weather_capital[indexPath.row]];
    cell_object.title.text = [NSString stringWithFormat:@"%@",_weather_capital[indexPath.row]];
    
    NSString *imageKeyname = weathers[@"icons"][0];
    cell_object.weather_icon_image.image = weather_icon[imageKeyname];
    */
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = YES;
    
    // セルの向きを横向きに
    cell_object.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    return cell_object;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.row_num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    capitalstr = [NSString stringWithFormat:@"%@",_weather_capital[indexPath.row]];
}



@end