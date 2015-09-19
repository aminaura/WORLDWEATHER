//
//  SearchTableViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/09/09.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()
{
    NSMutableArray * weather_capital1;
    NSMutableArray * weather_capital2;
    NSMutableArray * weather_capital3;
    NSMutableArray * weather_capital4;
    NSMutableArray * weather_capital5;
    NSMutableArray * weather_capital6;
    NSMutableArray * weather_capital7;
}
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    weather_capital1 = @[@"Alger",
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
                         @"Juba"].mutableCopy;
    
    weather_capital2 = @[@"Kabul",
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
                         @"Pyongyang"].mutableCopy;
    
    weather_capital3 = @[@"Reykjavik",
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
                         @"Luxembourg"].mutableCopy;
    
    weather_capital4 = @[@"Washington, D.C.",
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
                         @"Mexico City"].mutableCopy;
    
    weather_capital5 = @[@"Baku",
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
                         @"Moscow"].mutableCopy;
    
    weather_capital6 = @[@"Canberra",
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
                         @"Palikir"].mutableCopy;
    
    weather_capital7 = @[@"Buenos Aires",
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
                         @"La Paz"].mutableCopy;
    
    if(section == 0){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 54;
    }
    if(section == 1){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 40;
    }
    if(section == 2){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 41;
    }
    if(section == 3){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 23;
    }
    if(section == 4){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 12;
    }
    if(section == 5){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 15;
    }
    if(section == 6){
        _searchcell.textLabel.text = [NSString stringWithFormat:@"%@",weather_capital1[0]];
        return 12;
    }
    
    return 0;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;

}


@end
