//
//  ViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/08/17.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import "ViewController.h"
#import "VerticalTableViewCell.h"
#import <Parse/Parse.h>

@interface ViewController (){
    NSMutableArray * titlesArray;
    int tagnum;
    
    UIRefreshControl *_refreshControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titlesArray = @[@"AFRICA",
                    @"ASIA",
                    @"EUROPE",
                    @"NORTH AMERICA",
                    @"NIS",
                    @"OCEANIA",
                    @"SOUTH AMERICA"].mutableCopy;
    
    
    // verticalTableViewのメソッドをdelegateに任せる
    self.verticalTableView.delegate = self;
    self.verticalTableView.dataSource = self;
    
    // セルを使うと宣言する
    [self.verticalTableView registerClass:[VerticalTableViewCell class]
                   forCellReuseIdentifier:@"vertical"];
    
    _verticalTableView.backgroundColor =  [UIColor colorWithHue:0.0
                                                     saturation:0.0
                                                     brightness:0.22
                                                          alpha:1.0];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [_verticalTableView addSubview:_refreshControl];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // verticalの時
    // verticalのセルを作る
    VerticalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vertical"];
    [cell buildHorizontalTableView];
    // horizontalTableViewに1以上のタグを設定
    cell.horizontalTableView.tag = indexPath.section +1;
    tableView.separatorColor = [UIColor clearColor];
    
    switch (indexPath.section +1) {
        case 1:
            cell.weather_capital = @[@"Alger",
                                 @"Luanda",
                                 @"Kampala",
                                 @"Cairo",
                                 @"AddisAbaba",
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
                                 @"SaoTome",
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
                                 @"PortoNovo",
                                 @"Gaborone",
                                 @"Antananarivo",
                                 @"Lilongwe",
                                 @"Bamako",
                                 @"PortLouis",
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
            cell.row_num = 54;
            
            break;
            
        case 2:
            cell.weather_capital = @[@"Kabul",
                                 @"AbuDhabi",
                                 @"Sanaa",
                                 @"TelAviv",
                                 @"Bagdad",
                                 @"Teheran",
                                 @"NewDelhi",
                                 @"Jakarta",
                                 @"Muscat",
                                 @"Doha",
                                 @"PhnomPenh",
                                 @"Nicosia",
                                 @"Kuwait",
                                 @"Riyadh",
                                 @"Damascus",
                                 @"Singapore",
                                 @"SriJayawardenepuraKotte",
                                 @"Bangkok",
                                 @"Ankara",
                                 @"Kathmandu",
                                 @"Manama",
                                 @"Islamabad",
                                 @"Dhaka",
                                 @"Manila",
                                 @"Thimphu",
                                 @"BandarSeriBegawan",
                                 @"Hanoi",
                                 @"KualaLumpur",
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
            
            cell.row_num = 40;

            
            break;

        case 3:
            cell.weather_capital = @[@"Reykjavik",
                                 @"Dublin",
                                 @"Tirane",
                                 @"AndorralaVella",
                                 @"London",
                                 @"Rome",
                                 @"VaticanCity",
                                 @"Tallin",
                                 @"Vienna",
                                 @"Amsterdam",
                                 @"Athens",
                                 @"Zagreb",
                                 @"Pristina",
                                 @"SanMarino",
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

            
            cell.row_num = 41;
            
            break;

        case 4:
            cell.weather_capital = @[@"Washington,D.C.",
                                 @"SaintGeorge's",
                                 @"SanSalvador",
                                 @"Ottawa",
                                 @"Havana",
                                 @"GuatemalaCity",
                                 @"SaintGeorge's",
                                 @"SanJose",
                                 @"Kingston",
                                 @"Basseterre",
                                 @"Kingstown",
                                 @"Castries",
                                 @"PortofSpain",
                                 @"Roseau",
                                 @"SantoDomingo",
                                 @"Managua",
                                 @"Port-au-Prince",
                                 @"PanamaCity",
                                 @"Nassau",
                                 @"Bridgetown",
                                 @"Belmopan",
                                 @"Tegucigalpa",
                                 @"MexicoCity"].mutableCopy;
            
            cell.row_num = 23;

            
            break;

        case 5:
            cell.weather_capital = @[@"Baku",
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
            
            cell.row_num = 12;
            
            break;

        case 6:
            cell.weather_capital = @[@"Canberra",
                                 @"Tarawa",
                                 @"Avarua",
                                 @"Apia",
                                 @"Honiara",
                                 @"Funafuti",
                                 @"Nuku'alofa",
                                 @"Yaren",
                                 @"Wellington",
                                 @"PortVila",
                                 @"PortMoresby",
                                 @"Melekeok",
                                 @"Suva",
                                 @"Majuro",
                                 @"Palikir"].mutableCopy;
            
            cell.row_num = 15;

            
            break;

        case 7:
            cell.weather_capital = @[@"BuenosAires",
                                 @"Montevideo",
                                 @"Quito",
                                 @"Georgetown",
                                 @"Bogota",
                                 @"Paramaribo",
                                 @"SantiagodeChile",
                                 @"Asuncion",
                                 @"Brasilia",
                                 @"Caracas",
                                 @"Lima",
                                 @"LaPaz"].mutableCopy;
            
            cell.row_num = 12;

            
            break;

            
        
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //第１セクションの設定
    if (section==0) {
        return 1;
    }
    //第２セクションの設定
    else if (section==1) {
        return 1;
    }
    else if (section==2) {
        return 1;
    }
    else if (section==3) {
        return 1;
    }
    else if (section==4) {
        return 1;
    }
    else if (section==5) {
        return 1;
    }
    else if (section==6) {
        return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    //第１セクションの設定
    
    //第２セクションの設定
    if (section==1) {
        return @"AFRICA";
    }
    else if (section==2) {
        return @"ASIA";
    }
    else if (section==3) {
        return @"EUROPE";
    }
    else if (section==4) {
        return @"NORTH AMERICA";
    }
    else if (section==5) {
        return @"NIS";
    }
    else if (section==6) {
        return @"OCEANIA";
    }
    else if (section==6) {
        return @"SOURTH AMERICA";
    }
    return nil;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        UIImage *image = [UIImage imageNamed:@"Africa_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==1) {
        UIImage *image = [UIImage imageNamed:@"Asia_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==2) {
        UIImage *image = [UIImage imageNamed:@"Europe_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==3) {
        UIImage *image = [UIImage imageNamed:@"NIS_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==4) {
        UIImage *image = [UIImage imageNamed:@"NorthAmerica_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==5) {
        UIImage *image = [UIImage imageNamed:@"Oceania_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    else if (section==6) {
        UIImage *image = [UIImage imageNamed:@"SouthAmerica_text_25pixel.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeLeft;
        
        return imageView;
        
    }
    
    return nil;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (void)refresh
{
    NSLog(@"refresh");
    //TODO:アクションを書く
   
    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(endRefresh) userInfo:nil repeats:NO];
}

- (void)endRefresh
{
    [_refreshControl endRefreshing];
}

-(IBAction)goprofile{
    PFUser *user = [PFUser currentUser];
    if(!user){
        [self performSegueWithIdentifier:@"ToSignIn" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"ToProfile" sender:self];
    }
}


@end
