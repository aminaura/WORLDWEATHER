//
//  VerticalTableViewCell.m
//  Tobae
//
//  Created by 菅野楓 on 2015/08/17.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//


#import "VerticalTableViewCell.h"
#import "Cell.h"
#import "CapitalStrManager.h"


@interface VerticalTableViewCell(){
    NSDictionary *weather_icon;
    UIImage *iconimg;
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
    
    
    // この部分が重要
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    cell_object.weather_icon_image.image = nil;
    
    // 実行待ち
    dispatch_async(q_global, ^{
        // NSDictionary *weathers = [self getweather:self.weather_capital[indexPath.row]];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?APPID=b8f4ce09ae1ca4d1b34a14438e857866&q=%@", self.weather_capital[indexPath.row]]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (data) {
                                       NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                       
                                       if (object) {
                                           // ⑦ weather.mainの値を抽出
                                           NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
                                           NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
                                           NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
                                           NSArray *icons = [object valueForKeyPath:@"weather.icon"];
                                           
                                           
                                           NSLog(@"main(天候)=%@,description(天候詳細)=%@,speed(風速)=%@,icons(天気アイコン)=%@",main,description,speed,icons);
                                           
                                           NSMutableDictionary *weather= @{@"main":main,
                                                                           @"description":description,
                                                                           @"speed":speed,
                                                                           @"icons":icons}.mutableCopy;
                                           dispatch_async(q_main, ^{
                                               NSString *imageKeyname = weather[@"icons"][0];
                                               cell_object.weather_icon_image.image = weather_icon[imageKeyname];
                                               iconimg = weather_icon[imageKeyname];
                                               [cell_object layoutSubviews];
                                           });
                                       }else {
                                           // TODO: ここに取得できなかったときの処理。でも本当は、「すでに取れてたらリクエストを送らない」というのが正解
                                       }
                                   }else {
                                       NSLog(@"レスポンス == %@, エラー == %@", response, error);
                                   }
                               }];
    });
    
    cell_object.title.text = [NSString stringWithFormat:@"%@",_weather_capital[indexPath.row]];
    
    /*
    NSString *imageKeyname = weathers[@"icons"][0];
    cell_object.weather_icon_image.image = weather_icon[imageKeyname];
    iconimg = weather_icon[imageKeyname];
    */
     
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.bounces = YES;
    
    if (indexPath.row % 2 == 0) {
        cell_object.backgroundColor = [UIColor colorWithHue:0.0
                                                 saturation:0.0
                                                 brightness:0.67
                                                      alpha:1.0];
    }
    // 奇数セル
    else {
        cell_object.backgroundColor = [UIColor colorWithHue:0.0
                                                 saturation:0.0
                                                 brightness:0.73
                                                      alpha:1.0];
    }
    
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

- (NSDictionary *)getweather:(NSString *)string{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?APPID=b8f4ce09ae1ca4d1b34a14438e857866&q=%@", string]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
    __block NSDictionary *object;
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            // Error
            NSLog(@"エラー == %@", error);
            
        }else {
            NSLog(@"responseText = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
            NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
            NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
            NSArray *icons = [object valueForKeyPath:@"weather.icon"];
            
            
            NSLog(@"main(天候)=%@,description(天候詳細)=%@,speed(風速)=%@,icons(天気アイコン)=%@",main,description,speed,icons);
            NSLog(@"str=%@",string);
            
            NSMutableDictionary *weather= @{@"main":main,
                                            @"description":description,
                                            @"speed":speed,
                                            @"icons":icons}.mutableCopy;
            
            return weather;
            dispatch_async(dispatch_get_main_queue(), ^{
                // ここに何か処理を書く。
                
            });
        }
    }];
     */
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // ⑦ weather.mainの値を抽出
    NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
    NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
    NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
    NSArray *icons = [object valueForKeyPath:@"weather.icon"];
    
    
    NSLog(@"main(天候)=%@,description(天候詳細)=%@,speed(風速)=%@,icons(天気アイコン)=%@",main,description,speed,icons);
    NSLog(@"str=%@",string);
    
    NSMutableDictionary *weather= @{@"main":main,
                                    @"description":description,
                                    @"speed":speed,
                                    @"icons":icons}.mutableCopy;
    
    return weather;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [CapitalStrManager sharedManager].capitalstr = [NSString stringWithFormat:@"%@",_weather_capital[indexPath.row]];
    
    Cell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [CapitalStrManager sharedManager].icon = cell.weather_icon_image.image;
    
    [[self getViewController] performSegueWithIdentifier:@"toDetail" sender:self];
}

-(UIViewController *)getViewController{
    UIResponder *responder = self;
    while((responder = responder.nextResponder) != nil)
    {
        if([responder isKindOfClass:[UIViewController class]]){
            return (UIViewController*)responder;
        }
    }
    return  nil;
}



@end