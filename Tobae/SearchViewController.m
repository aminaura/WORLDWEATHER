//
//  SearchViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/02/06.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "SearchViewController.h"
#import "CapitalStrManager.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *Capitals;

@property (nonatomic, strong) NSArray *SearchCapitals;



@end

@implementation SearchViewController{
    NSString *capitalname;
    NSDictionary *listDict;
    UIImage *cellimg;
    NSDictionary *weather_icon;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // テーブルに表示したいデータソースをセット
    self.Capitals = @[@"Abu Dhabi",
                      @"Abuja",
                      @"Accra",
                      @"Addis Ababa",
                      @"Alger",
                      @"Amman",
                      @"Amsterdam",
                      @"Andorra la Vella",
                      @"Ankara",
                      @"Antananarivo",
                      @"Apia",
                      @"Ashgabat",
                      @"Asmara",
                      @"Astana",
                      @"Asuncion",
                      @"Athens",
                      @"Avarua",
                      @"Bagdad",
                      @"Baku",
                      @"Bamako",
                      @"Bandar Seri Begawan",
                      @"Bangkok",
                      @"Bangui",
                      @"Banjul",
                      @"Basseterre",
                      @"Beijin",
                      @"Beirut",
                      @"Belmopan",
                      @"Beograd",
                      @"Berlin",
                      @"Bern",
                      @"Bishkek",
                      @"Bissau",
                      @"Bogota",
                      @"Brasilia",
                      @"Bratislava",
                      @"Brazzaville",
                      @"Bridgetown",
                      @"Bruxelles",
                      @"Bucharest",
                      @"Budapest",
                      @"Buenos Aires",
                      @"Bujumbura",
                      @"Cairo",
                      @"Canberra",
                      @"Caracas",
                      @"Castries",
                      @"Conakry",
                      @"Copenhagen",
                      @"Dakar",
                      @"Damascus",
                      @"Dhaka",
                      @"Dili",
                      @"Djibouti",
                      @"Dodoma",
                      @"Doha",
                      @"Dublin",
                      @"Dushanbe",
                      @"Freetown",
                      @"Funafuti",
                      @"Gaborone",
                      @"Georgetown",
                      @"Guatemala City",
                      @"Hanoi",
                      @"Harare",
                      @"Havana",
                      @"Helsinki",
                      @"Honiara",
                      @"Islamabad",
                      @"Jakarta",
                      @"Juba",
                      @"Kabul",
                      @"Kampala",
                      @"Kathmandu",
                      @"Khartum",
                      @"Kigali",
                      @"Kingston",
                      @"Kingstown",
                      @"Kinshasa",
                      @"kishinev",
                      @"Kuala Lumpur",
                      @"Kuwait",
                      @"Kyiv",
                      @"La Paz",
                      @"Libreville",
                      @"Lilongwe",
                      @"Lima",
                      @"Lisbon",
                      @"Ljubljana",
                      @"Lome",
                      @"London",
                      @"Luanda",
                      @"Lusaka",
                      @"Luxembourg",
                      @"Madrid",
                      @"Majuro",
                      @"Malabo",
                      @"Male",
                      @"Managua",
                      @"Manama",
                      @"Manila",
                      @"Maputo",
                      @"Maseru",
                      @"Mbabane",
                      @"Melekeok",
                      @"Mexico City",
                      @"Minsk",
                      @"Mogadishu",
                      @"Monaco",
                      @"Monrovia",
                      @"Montevideo",
                      @"Moroni",
                      @"Moscow",
                      @"Muscat",
                      @"N'Djamena",
                      @"Nairobi",
                      @"Nassau",
                      @"Naypyidaw",
                      @"New Delhi",
                      @"Niamey",
                      @"Nicosia",
                      @"Nouakchott",
                      @"Nuku'alofa",
                      @"Oslo",
                      @"Ottawa",
                      @"Ouagadougou",
                      @"Palikir",
                      @"Panama City",
                      @"Paramaribo",
                      @"Paris",
                      @"Phnom Penh",
                      @"Podgorica",
                      @"Port Louis",
                      @"Port Moresby",
                      @"Port of Spain",
                      @"Port Vila",
                      @"Port-au-Prince",
                      @"Porto Novo",
                      @"Praha",
                      @"Praia",
                      @"Pretoria",
                      @"Pristina",
                      @"Pyongyang",
                      @"Quito",
                      @"Rabat",
                      @"Reykjavik",
                      @"Riga",
                      @"Riyadh",
                      @"Rome",
                      @"Roseau",
                      @"Saint George's",
                      @"Saint George's",
                      @"San Jose",
                      @"San Marino",
                      @"San Salvador",
                      @"Sanaa",
                      @"Santiago de Chile",
                      @"Santo Domingo",
                      @"Sao Tome",
                      @"Sarajevo",
                      @"Seoul",
                      @"Singapore",
                      @"Skopje",
                      @"Sofia",
                      @"Sri Jayawardenepura Kotte",
                      @"Stockholm",
                      @"Suva",
                      @"Taipei",
                      @"Tallin",
                      @"Tarawa",
                      @"Tbilisi",
                      @"Tegucigalpa",
                      @"Teheran",
                      @"Tel Aviv",
                      @"Thimphu",
                      @"Tirane",
                      @"Tokyo",
                      @"Toshkent",
                      @"Tripoli",
                      @"Tunis",
                      @"Ulaanbaatar",
                      @"Vaduz",
                      @"Valletta",
                      @"Vatican City",
                      @"Victoria",
                      @"Vienna",
                      @"Vientiane",
                      @"Vilnius",
                      @"Warszawa",
                      @"Washington, D.C.",
                      @"Wellington",
                      @"Windhoek",
                      @"Yamoussoukro",
                      @"Yaounde",
                      @"Yaren",
                      @"Yerevan",
                      @"Zagreb"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource delegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
    // ここのsearchDisplayControllerはStoryboardで紐付けされたsearchBarに自動で紐づけられています
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        dataCount = self.SearchCapitals.count;
        
    } else {
        
        dataCount = self.Capitals.count;
        
    }
    return dataCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = self.Capitals[indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // 検索中の暗転された状態のテーブルビューはこちらで処理
        cell.textLabel.text = self.SearchCapitals[indexPath.row];
    } else {
        // 通常時のテーブルビューはこちらで処理
        cell.textLabel.text = self.Capitals[indexPath.row];
        
    }

    
    return cell;
}


- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 検索バーに入力された文字列を引数に、絞り込みをかけます
    [self filterContainsWithSearchText:searchString];
    
    // YESを返すとテーブルビューがリロードされます。
    // リロードすることでdataSourceSearchResultsiPhoneとdataSourceSearchResultsAndroidからテーブルビューを表示します
    return YES;
}
- (void)filterContainsWithSearchText:(NSString *)searchText
{
    //CONTAINS右辺値が含まれているか,cは大文字小文字の区別なしオプション
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[l] %@", searchText];
    
    self.SearchCapitals= [self.Capitals filteredArrayUsingPredicate:predicate];

}

-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    listDict = [_Capitals objectAtIndex:indexPath.row];
    
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


    // この部分が重要
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    
    // 実行待ち
    dispatch_async(q_global, ^{
        // NSDictionary *weathers = [self getweather:self.weather_capital[indexPath.row]];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?APPID=b8f4ce09ae1ca4d1b34a14438e857866&q=%@",_Capitals[indexPath.row]]];
        
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
                                               cellimg = weather_icon[imageKeyname];
                                           });
                                       }else {
                                           // TODO: ここに取得できなかったときの処理。でも本当は、「すでに取れてたらリクエストを送らない」というのが正解
                                       }
                                   }else {
                                       NSLog(@"レスポンス == %@, エラー == %@", response, error);
                                   }
                               }];
    });
    
    [CapitalStrManager sharedManager].capitalstr = [NSString stringWithFormat:@"%@",_Capitals[indexPath.row]];
    capitalname = _Capitals[indexPath.row];
    [CapitalStrManager sharedManager].icon = cellimg;
    [CapitalStrManager sharedManager].capitalstr = _Capitals[indexPath.row];
    
    [self performSegueWithIdentifier:@"goDetail" sender:self];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.backgroundColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.329 alpha:1.0];
    cell.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.329 alpha:1.0];
}

-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}





@end
