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

@implementation SearchViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // テーブルに表示したいデータソースをセット
    self.Capitals = @[@"Alger",
                      @"Luanda",
                      @"Kampala",
                      @"Cairo",
                      @"Addis Ababa",
                      @"Asmara",
                      @"Accra",
                      @"Praia",
                      @"Libreville",
                      @"Yaounde",
                      @"Banjul",
                      @"Conakry",
                      @"Bissau",
                      @"Nairobi",
                      @"Yamoussoukro",
                      @"Moroni",
                      @"Brazzaville",
                      @"Kinshasa",
                      @"Sao Tome",
                      @"Lusaka",
                      @"Freetown",
                      @"Djibouti",
                      @"Harare",
                      @"Khartum",
                      @"Mbabane",
                      @"Victoria",
                      @"Dakar",
                      @"Mogadishu",
                      @"Dodoma",
                      @"N'Djamena",
                      @"Tunis",
                      @"Lome",
                      @"Abuja",
                      @"Windhoek",
                      @"Niamey",
                      @"Ouagadougou",
                      @"Bujumbura",
                      @"Porto Novo",
                      @"Gaborone",
                      @"Antananarivo",
                      @"Lilongwe",
                      @"Bamako",
                      @"Port Louis",
                      @"Nouakchott",
                      @"Maputo",
                      @"Rabat",
                      @"Tripoli",
                      @"Monrovia",
                      @"Kigali",
                      @"Maseru",
                      @"Malabo",
                      @"Bangui",
                      @"Pretoria",
                      @"Juba",
                      @"Kabul",
                      @"Abu Dhabi",
                      @"Sanaa",
                      @"Tel Aviv",
                      @"Bagdad",
                      @"Teheran",
                      @"New Delhi",
                      @"Jakarta",
                      @"Muscat",
                      @"Doha",
                      @"Phnom Penh",
                      @"Nicosia",
                      @"Kuwait",
                      @"Riyadh",
                      @"Damascus",
                      @"Singapore",
                      @"Sri Jayawardenepura Kotte",
                      @"Bangkok",
                      @"Ankara",
                      @"Kathmandu",
                      @"Manama",
                      @"Islamabad",
                      @"Dhaka",
                      @"Manila",
                      @"Thimphu",
                      @"Bandar Seri Begawan",
                      @"Hanoi",
                      @"Kuala Lumpur",
                      @"Naypyidaw",
                      @"Male",
                      @"Ulaanbaatar",
                      @"Amman",
                      @"Vientiane",
                      @"Beirut",
                      @"Seoul",
                      @"Taipei",
                      @"Beijin",
                      @"Dili",
                      @"Tokyo",
                      @"Pyongyang",
                      @"Reykjavik",
                      @"Dublin",
                      @"Tirane",
                      @"Andorra la Vella",
                      @"London",
                      @"Rome",
                      @"Vatican City",
                      @"Tallin",
                      @"Vienna",
                      @"Amsterdam",
                      @"Athens",
                      @"Zagreb",
                      @"Pristina",
                      @"San Marino",
                      @"Bern",
                      @"Stockholm",
                      @"Madrid",
                      @"Bratislava",
                      @"Ljubljana",
                      @"Beograd",
                      @"Praha",
                      @"Copenhagen",
                      @"Berlin",
                      @"Oslo",
                      @"Budapest",
                      @"Helsinki",
                      @"Paris",
                      @"Sofia",
                      @"Bruxelles",
                      @"Warszawa",
                      @"Sarajevo",
                      @"Lisbon",
                      @"Skopje",
                      @"Valletta",
                      @"Monaco",
                      @"Podgorica",
                      @"Riga",
                      @"Vilnius",
                      @"Vaduz",
                      @"Bucharest",
                      @"Luxembourg",
                      @"Washington, D.C.",
                      @"Saint George's",
                      @"San Salvador",
                      @"Ottawa",
                      @"Havana",
                      @"Guatemala City",
                      @"Saint George's",
                      @"San Jose",
                      @"Kingston",
                      @"Basseterre",
                      @"Kingstown",
                      @"Castries",
                      @"Port of Spain",
                      @"Roseau",
                      @"Santo Domingo",
                      @"Managua",
                      @"Port-au-Prince",
                      @"Panama City",
                      @"Nassau",
                      @"Bridgetown",
                      @"Belmopan",
                      @"Tegucigalpa",
                      @"Mexico City",
                      @"Baku",
                      @"Yerevan",
                      @"Kyiv",
                      @"Toshkent",
                      @"Astana",
                      @"Bishkek",
                      @"Tbilisi",
                      @"Dushanbe",
                      @"Ashgabat",
                      @"Minsk",
                      @"kishinev",
                      @"Moscow",
                      @"Canberra",
                      @"Tarawa",
                      @"Avarua",
                      @"Apia",
                      @"Honiara",
                      @"Funafuti",
                      @"Nuku'alofa",
                      @"Yaren",
                      @"Wellington",
                      @"Port Vila",
                      @"Port Moresby",
                      @"Melekeok",
                      @"Suva",
                      @"Majuro",
                      @"Palikir",
                      @"Buenos Aires",
                      @"Montevideo",
                      @"Quito",
                      @"Georgetown",
                      @"Bogota",
                      @"Paramaribo",
                      @"Santiago de Chile",
                      @"Asuncion",
                      @"Brasilia",
                      @"Caracas",
                      @"Lima",
                      @"La Paz"];
    
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
        cell.textLabel.text = self.Capitals[indexPath.row];
    } else {
        // 通常時のテーブルビューはこちらで処理
        cell.textLabel.text = self.Capitals[indexPath.row];
        
    }

    
    return cell;
}

- (void)filterContainsWithSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains1 %@", searchText];
    
    self.SearchCapitals = [self.Capitals filteredArrayUsingPredicate:predicate];
}

-(BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // 検索バーに入力された文字列を引数に、絞り込みをかけます
    [self filterContainsWithSearchText:searchString];
    
    // YESを返すとテーブルビューがリロードされます。
    // リロードすることでdataSourceSearchResultsiPhoneとdataSourceSearchResultsAndroidからテーブルビューを表示します
    return YES;
}

@end
