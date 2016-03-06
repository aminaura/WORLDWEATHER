//
//  DetailViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/10/03.
//  Copyright © 2015年 Original_Weather. All rights reserved.
//

#import "DetailViewController.h"
#import "VerticalTableViewCell.h"
#import "CapitalStrManager.h"
#import <Parse/Parse.h>

@interface DetailViewController ()
{
    NSDictionary * array;
    NSMutableArray * country;
    NSDictionary *weather_icon;
    NSDictionary * weekday;
    NSString *imageKeyname;
    
    NSMutableArray * capital;
    
    NSMutableArray * favarray;
    
    IBOutlet UIButton *addfav;
    int favcount;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    capitallabel.text = [CapitalStrManager sharedManager].capitalstr;
    
    [self sendRequestForWeather];
    
    [self country];
    
    [self getweather:[CapitalStrManager sharedManager].capitalstr];
    [self sunrise:[CapitalStrManager sharedManager].capitalstr];
    
    
    [self get];
    
    NSString *name = [CapitalStrManager sharedManager].capitalstr;
    
    PFUser *user = [PFUser  currentUser];
    
    favarray = [user objectForKey:@"favorites"];
    
    if([[user objectForKey:@"favorites"] containsObject:name]){
        [addfav setImage:[UIImage imageNamed:@"Favorite_Cancel.png"] forState:UIControlStateNormal];
    }
    else {
        [addfav setImage:[UIImage imageNamed:@"Favorite_Add.png"] forState:UIControlStateNormal];
    }

    
}

- (void)sendRequestForWeather {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?APPID=b8f4ce09ae1ca4d1b34a14438e857866&q=%@", [CapitalStrManager sharedManager].capitalstr]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSDictionary *object;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            // Error
            NSLog(@"エラー == %@", connectionError);
            
        }else {
            NSLog(@"responseText = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
            NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
            NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
            NSArray *icons = [object valueForKeyPath:@"weather.icon"];
            humidityla.text = [NSString stringWithFormat:@"humidity : %@％", [object valueForKeyPath:@"main.humidity"]];

            NSMutableDictionary *weather= @{@"main":main,
                                            @"description":description,
                                            @"speed":speed,
                                            @"icons":icons}.mutableCopy;
            
            dispatch_async(dispatch_get_main_queue(), ^{
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

                image.image = weather_icon[weather[@"icons"][0]];
            });
        }
    }];
}


-(IBAction)back{
    // 戻るコード
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)getweather: (NSString *)string {
    
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
    
    
    NSString *name = [CapitalStrManager sharedManager].capitalstr;
    NSString *URL_String = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&mode=json&units=metric&cnt=7&appid=b8f4ce09ae1ca4d1b34a14438e857866",name];
    
    
    NSURL *url = [NSURL URLWithString: URL_String];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *error;
    NSURLResponse *responce;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responce error:&error];
    
    // TODO: スペースがあるものはここで落ちる
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
   
    
    NSArray *listarray = [object valueForKeyPath:@"list"]; //天候;
    
    NSLog(@"listArray == %@", listarray );
    
    // UIImageViewに順番に入れていく
    for(int i = 0; i < listarray.count; i ++){
        if (i == 0) {
            // 今日のアイコン
        }else {
            ((UIImageView *)imageViews[i - 1]).image = [weather_icon valueForKey:[[listarray[i] valueForKey:@"weather"][0] valueForKey:@"icon"]];
        }
    }
    
    for(int i = 0; i < listarray.count; i ++){
        if ([listarray[i] valueForKey:@"rain"]) {
            
            int rain = [[listarray[i]  valueForKey:@"rain"]intValue];
            
            ((UILabel *)rainfallla[i]).text = [NSString stringWithFormat:@"rain : %dmm",rain];
            
        }else {
            ((UILabel *)rainfallla[i]).text = @"rain : 0mm";
        }
    }
    
    for(int j = 0; j < listarray.count; j ++){
        
        int temp = [[[(NSDictionary *)listarray[j] valueForKey:@"temp"] valueForKey:@"day"]intValue];
        NSLog(@"%d",temp);
        
        ((UILabel*)templa[j]).text = [NSString stringWithFormat:@"%d℃",temp];
        
    }
    
    
    
}

-(void)sunrise: (NSString *)string{
    
    NSString *name = [CapitalStrManager sharedManager].capitalstr;
    NSString *URL_String = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&appid=b8f4ce09ae1ca4d1b34a14438e857866",name];
    
    
    NSURL *url = [NSURL URLWithString: URL_String];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *error;
    NSURLResponse *responce;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responce error:&error];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *sysDic = [object valueForKeyPath:@"sys"]; //天候;
    
    NSDate *sunriseDate = [NSDate dateWithTimeIntervalSince1970:[[sysDic valueForKey:@"sunrise"] doubleValue]];
    NSDate *sunsetDate = [NSDate dateWithTimeIntervalSince1970:[[sysDic valueForKey:@"sunset"] doubleValue]];
    
    
    
    
    NSDateFormatter *sunriseFormatter = [[NSDateFormatter alloc] init];
    [sunriseFormatter setDateFormat:@"HH:mm"];
    NSString *sunrisestr = [sunriseFormatter stringFromDate:sunriseDate];
    
    NSLog(@"sunriseDate: %@", sunriseDate);
    sunrise.text = [NSString stringWithFormat:@"sunrise : %@",sunrisestr];
    
    NSDateFormatter *sunsetFormatter = [[NSDateFormatter alloc] init];
    [sunsetFormatter setDateFormat:@"HH:mm"];
    NSString *sunsetstr = [sunriseFormatter stringFromDate:sunsetDate];
    
    
    NSLog(@"sunsetDate: %@", sunsetDate);
    sunset.text = [NSString stringWithFormat:@"sunset : %@",sunsetstr];
}


-(void)country{
    country = @[ @"Algeria",
                 @"Angola",
                 @"Uganda",
                 @"Egypt",
                 @"Ethiopia",
                 @"Eritrea",
                 @"Ghana",
                 @"CapeVerde",
                 @"GaboneseRepublic",
                 @"Cameroon",
                 @"Gambia",
                 @"Guinea",
                 @"Guinea-Bissau",
                 @"Kenya",
                 @"Coted'Ivoire",
                 @"Comoros",
                 @"RepublicofCongo",
                 @"DemocraticRepublicoftheCongo",
                 @"SaoTomeandPrincipe",
                 @"Zambia",
                 @"SierraLeone",
                 @"Djibouti",
                 @"Zimbabwe",
                 @"Sudan",
                 @"Swaziland",
                 @"Seychelles",
                 @"Senegal",
                 @"Somalia",
                 @"Tanzania",
                 @"Chad",
                 @"Tunisia",
                 @"Togo",
                 @"Nigeria",
                 @"Namibia",
                 @"Niger",
                 @"BurkinaFaso",
                 @"Burundi",
                 @"Benin",
                 @"Botswana",
                 @"Madagascar",
                 @"Malawi",
                 @"Mali",
                 @"Mauritius",
                 @"Mauritania",
                 @"Mozambique",
                 @"Morocco",
                 @"Libya",
                 @"Liberia",
                 @"Rwanda",
                 @"Lesotho",
                 @"Equatorial Guinea",
                 @"CentralAfrican Republic",
                 @"SouthAfrica",
                 @"SouthSudan",
                 @"Afghanistan",
                 @"UnitedArabEmirates",
                 @"Yemen",
                 @"Israel",
                 @"Iraq",
                 @"Iran",
                 @"India",
                 @"Indonesia",
                 @"Oman",
                 @"Qatar",
                 @"Cambodia",
                 @"Cyprus",
                 @"Kuwait",
                 @"Saudi Arabia",
                 @"Syria",
                 @"Singapore",
                 @"SriLanka",
                 @"Thailand",
                 @"Turkey",
                 @"Nepal",
                 @"Bahrain",
                 @"Pakistan",
                 @"Bangladesh",
                 @"Philippines",
                 @"Bhutan",
                 @"Brunei",
                 @"Vietnam",
                 @"Malaysia",
                 @"Myanmar",
                 @"Maldives",
                 @"Mongolia",
                 @"Jordan",
                 @"Laos",
                 @"Lebanon",
                 @"Korea",
                 @"Taiwan",
                 @"China",
                 @"Timor-Leste",
                 @"Japan",
                 @"NorthKorea",
                 @"Iceland",
                 @"Ireland",
                 @"Albania",
                 @"Andorra",
                 @"UnitedKingdom",
                 @"Italy",
                 @"Vatican",
                 @"Estonia",
                 @"Austria",
                 @"Netherlands",
                 @"Greece",
                 @"Croatia",
                 @"Kosovo",
                 @"SanMarino",
                 @"Switzerland",
                 @"Sweden",
                 @"Spain",
                 @"SlovakRepublic",
                 @"Slovenia",
                 @"Serbia",
                 @"CzechRepublic",
                 @"Denmark",
                 @"Germany",
                 @"Norway",
                 @"Hungary",
                 @"Finland",
                 @"France",
                 @"Bulgaria",
                 @"Belgium",
                 @"Poland",
                 @"BosniaandHerzegovina",
                 @"Portugal",
                 @"Macedonia",
                 @"Malta",
                 @"Monaco",
                 @"Montenegro",
                 @"Latvia",
                 @"Lithuania",
                 @"Liechtenstein",
                 @"Romania",
                 @"Luxembourg",
                 @"UnitedStates",
                 @"AntiguaandBarbuda",
                 @"ElSalvador",
                 @"Canada",
                 @"Cuba",
                 @"Guatemala",
                 @"Grenada",
                 @"Costa Rica",
                 @"Jamaica",
                 @"SaintChristopherandNevis",
                 @"SaintVincentandtheGrenadines",
                 @"SaintLucia",
                 @"TrinidadandTobago",
                 @"CommonwealthofDominica",
                 @"DominicanRepublic",
                 @"Nicaragua",
                 @"Haiti",
                 @"Panama",
                 @"Bahamas",
                 @"Barbados",
                 @"Belize",
                 @"Honduras",
                 @"Mexico",
                 @"Azerbaijan",
                 @"Armenia",
                 @"Ukraine",
                 @"Uzbekistan",
                 @"Kazakhstan",
                 @"KyrgyzRepublic",
                 @"Georgia",
                 @"Tajikistan",
                 @"Turkmenistan",
                 @"Belarus",
                 @"Moldova",
                 @"Russia",
                 @"Australia",
                 @"Kiribati",
                 @"CookIslands",
                 @"Samoa",
                 @"SolomonIslands",
                 @"Tuvalu",
                 @"Tonga",
                 @"Nauru",
                 @"New Zealand",
                 @"Vanuatu",
                 @"PapuaNewGuinea",
                 @"Palau",
                 @"Fiji",
                 @"MarshallIslands",
                 @"Micronesia",
                 @"Argentina",
                 @"Uruguay",
                 @"Ecuador",
                 @"Guyana",
                 @"Colombia",
                 @"Suriname",
                 @"Chile",
                 @"Paraguay",
                 @"Brazil",
                 @"Venezuela",
                 @"Peru",
                 @"Bolivia"].mutableCopy;
    
    
    
    capital = @[@"Alger",
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
                @"La Paz"].mutableCopy;
    
    int count = [self getNumberOfArray:capital withKey:[CapitalStrManager sharedManager].capitalstr];
    
    countrylabel.text = [NSString stringWithFormat:@"%@",country[count]];
}

- (int)getNumberOfArray: (NSMutableArray *)mutableArray withKey: (NSString *)key {
    
    for (int i  = 0; i < mutableArray.count; i++) {
        if ([mutableArray[i] isEqualToString:key]) {
            return i;
        }
    }
    return 0;
}



-(void)get{
    
    for(int i = 0; i < 7; i ++){
        
        if(i == 0){
            
        }
        else{
            
            NSDateComponents *dateComp = [[NSDateComponents alloc] init];
            
            // 1~7日後とする
            [dateComp setDay:i];
            
            // 1日後のNSDateインスタンスを取得する
            NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            NSDateFormatter* formatter_e = [[NSDateFormatter alloc] init];
            
            // 変換用の書式を設定します。
            [formatter setDateFormat:@"MM/dd"];
            [formatter_e setDateFormat:@"E"];
            
            // NSDate を NSString に変換します。
            NSString *dateStr = [formatter stringFromDate:date];
            NSString *eStr = [formatter_e stringFromDate:date];
            
            
            NSLog(@"date=%@",dateStr);
            NSLog(@"e=%@",eStr);
            
            
            //日付を表示
            
            UILabel *datela = datelabel[i-1];
            datela.text = [NSString stringWithFormat:@"%@",dateStr];
            
            weekday = @{//day
                        @"Sun":@"sun",
                        @"Mon":@"mon",
                        @"Tue":@"tue",
                        @"Wed":@"wed",
                        @"Thu":@"thu",
                        @"Fri":@"fri",
                        @"Sat":@"sat"};
            
            
            UILabel *weekdayl = weekdayla[i - 1];
            weekdayl.text = [weekday valueForKey:eStr];
            
            
        }
    }
}

-(IBAction)addfavorite{
    PFUser *user  = [PFUser currentUser];
    
    if([[addfav currentImage] isEqual:[UIImage imageNamed:@"Favorite_Add.png"]]){
        if(!user){
            UIAlertView *alert =[[UIAlertView alloc]
                                 initWithTitle:@"You should login!"
                                 message:@"If you want to add, you should to login!"
                                 delegate:nil
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"OK", nil
                                 ];
            [alert show];
        }
        else{
            if(favcount >= 11){
                UIAlertView *alert =[[UIAlertView alloc]
                                     initWithTitle:@"You can't add favorate anymore!"
                                     message:@"There are too many favorates!"
                                     delegate:nil
                                     cancelButtonTitle:nil
                                     otherButtonTitles:@"OK", nil
                                     ];
                [alert show];
                
            }
            else{
                [user addUniqueObject:capitallabel.text forKey:@"favorites"];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    NSLog(@"error...%@",error);
                }];
                [addfav setImage:[UIImage imageNamed:@"Favorite_Cancel.png"] forState:UIControlStateNormal];
                favcount = favcount + 1;
            }
                    }

    }
    else{
        if(!user){
            UIAlertView *alert =[[UIAlertView alloc]
                                 initWithTitle:@"You should login!"
                                 message:@"If you want to delete, you should to login!"
                                 delegate:nil
                                 cancelButtonTitle:nil
                                 otherButtonTitles:@"OK", nil
                                 ];
            [alert show];
        }
        else{
            [user removeObject:capitallabel.text forKey:@"favorites"];
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                NSLog(@"error...%@",error);
            }];
            [addfav setImage:[UIImage imageNamed:@"Favorite_Add.png"] forState:UIControlStateNormal];
            favcount = favcount - 1;
        }

    }

}


@end
