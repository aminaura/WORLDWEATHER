//
//  SearchViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/02/06.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSArray *Capitals;

@property (nonatomic, strong) NSArray *SearchCapitals;



@end

@implementation SearchViewController{
    NSString *capitalname;
    NSDictionary *listDict;
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
    capitalname = _Capitals[indexPath.row];
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
