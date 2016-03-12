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
    
     NSInteger _buttonIndex;
    NSMutableDictionary *countries;
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
            if(data.length){
            NSLog(@"responseText = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"object = %@",object);
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
        }}];
    
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
    
    if(error == nil){
        if(data.length){
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
    }
    else{
       //TODO: エラー処理
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
    
    if(error != nil){
        if(data.length){
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
    }
    else{
        
    }
    
    }


-(void)country{
    countries   =  [NSMutableDictionary dictionaryWithDictionary:@{
                    
                    @"Algeria":@"Alger",
                     
                     @"Angola":@"Luanda",
                     
                     @"Uganda":@"Kampala",
                     
                     @"Egypt":@"Cairo",
                     
                     @"Ethiopia":@"AddisAbaba",
                     
                     @"Eritrea":@"Asmara",
                     
                     @"Ghana":@"Accra",
                     
                     @"CapeVerde":@"Praia",
                     
                     @"GaboneseRepublic":@"Libreville",
                     
                     @"Cameroon":@"Yaounde",
                     
                     @"Gambia":@"Banjul",
                     
                     @"Guinea":@"Conakry",
                     
                     @"Guinea-Bissau":@"Bissau",
                     
                     @"Kenya":@"Nairobi",
                     
                     @"Coted'Ivoire":@"Yamoussoukro",
                     
                     @"Comoros":@"Moroni",
                     
                     @"RepublicofCongo":@"Brazzaville",
                     
                     @"DemocraticRepublicoftheCongo":@"Kinshasa",
                     
                     @"SaoTomeandPrincipe":@"SaoTome",
                     
                     @"Zambia":@"Lusaka",
                     
                     @"SierraLeone":@"Freetown",
                     
                     @"Djibouti":@"Djibouti",
                     
                     @"Zimbabwe":@"Harare",
                     
                     @"Sudan":@"Khartum",
                     
                     @"Swaziland":@"Mbabane",
                     
                     @"Seychelles":@"Victoria",
                     
                     @"Senegal":@"Dakar",
                     
                     @"Somalia":@"Mogadishu",
                     
                     @"Tanzania":@"Dodoma",
                     
                     @"Chad":@"N'Djamena",
                     
                     @"Tunisia":@"Tunis",
                     
                     @"Togo":@"Lome",
                     
                     @"Nigeria":@"Abuja",
                     
                     @"Namibia":@"Windhoek",
                     
                     @"Niger":@"Niamey",
                     
                     @"BurkinaFaso":@"Ouagadougou",
                     
                     @"Burundi":@"Bujumbura",
                     
                     @"Benin":@"PortoNovo",
                     
                     @"Botswana":@"Gaborone",
                   
                     @"Madagascar":@"Antananarivo",
                     
                     @"Malawi":@"Lilongwe",
                     
                     @"Mali":@"Bamako",
                     
                     @"Mauritius":@"PortLouis",
                     
                     @"Mauritania":@"Nouakchott",
                     
                     @"Mozambique":@"Maputo",
                     
                     @"Morocco":@"Rabat",
                     
                     @"Libya":@"Tripoli",
                     
                     @"Liberia":@"Monrovia",
                     
                     @"Rwanda":@"Kigali",
                     
                     @"Lesotho":@"Maseru",
                     
                     @"Equatorial Guinea":@"Malabo",
                     
                     @"CentralAfrican Republic":@"Bangui",
                     
                     @"SouthAfrica":@"Pretoria",
                     
                     @"SouthSudan":@"Juba",
                     
                     @"Afghanistan":@"Kabul",
                     
                     @"UnitedArabEmirates" :@"AbuDhabi",
                     
                     @"Yemen":@"Sanaa",
                     
                     @"Israel":@"TelAviv",
                     
                     @"Iraq":@"Bagdad",
                     
                     @"Iran":@"Teheran",
                     
                     @"India":@"NewDelhi",
                     
                     @"Indonesia":@"Jakarta",
                     
                     @"Oman":@"Muscat",
                     
                     @"Qatar":@"Doha",
                     
                     @"Cambodia":@"PhnomPenh",
                     
                     @"Cyprus":@"Nicosia",
                     
                     @"Kuwait":@"Kuwait",
                     
                     @"Saudi Arabia":@"Riyadh",
                     
                     @"Syria":@"Damascus",
                     
                     @"Singapore":@"Singapore",
                     
                     @"SriLanka":@"SriJayawardenepuraKotte",
                     
                     @"Thailand":@"Bangkok",
                     
                     @"Turkey":@"Ankara",
                     
                     @"Nepal":@"Kathmandu",
                     
                     @"Bahrain":@"Manama",
                     
                     @"Pakistan":@"Islamabad",
                     
                     @"Bangladesh":@"Dhaka",
                     
                     @"Philippines":@"Manila",
                     
                     @"Bhutan":@"Thimphu",
                     
                     @"Brunei":@"BandarSeriBegawan",
                     
                     @"Vietnam":@"Hanoi",
                     
                     @"Malaysia":@"KualaLumpur",
                     
                     @"Myanmar":@"Naypyidaw",
                     
                     @"Maldives":@"Male",
                     
                     @"Mongolia":@"Ulaanbaatar",
                     
                     @"Jordan":@"Amman",
                     
                     @"Laos":@"Vientiane",
                     
                     @"Lebanon":@"Beirut",
                     
                     @"Korea":@"Seoul",
                     
                     @"Taiwan":@"Taipei",
                     
                     @"China":@"Beijin",
                     
                     @"Timor-Leste":@"Dili",
                     
                     @"Japan":@"Tokyo",
                     
                     @"NorthKorea":@"Pyongyang",
                     
                     @"Iceland":@"Reykjavik",
                     
                     @"Ireland":@"Dublin",
                     
                     @"Albania":@"Tirane",
                     
                     @"Andorra":@"AndorralaVella",
                     
                     @"UnitedKingdom":@"London",
                     
                     @"Italy":@"Rome",
                     
                     @"Vatican":@"VaticanCity",
                     
                     @"Estonia":@"Tallin",
                     
                     @"Austria":@"Vienna",
                     
                     @"Netherlands":@"Amsterdam",
                     
                     @"Greece":@"Athens",
                     
                     @"Croatia":@"Zagreb",
                     
                     @"Kosovo":@"Pristina",
                     
                     @"SanMarino":@"SanMarino",
                     
                     @"Switzerland":@"Bern",
                     
                     @"Sweden":@"Stockholm",
                     
                     @"Spain":@"Madrid",
                
                     @"SlovakRepublic":@"Bratislava",
                     
                     @"Slovenia":@"Ljubljana",
                     
                     @"Serbia":@"Beograd",
                   
                     @"CzechRepublic":@"Praha",
                     
                     @"Denmark":@"Copenhagen",
                     
                     @"Germany":@"Berlin",
                     
                     @"Norway":@"Oslo",
                     
                     @"Hungary":@"Budapest",
                     
                     @"Finland":@"Helsinki",
                     
                     @"France":@"Paris",
                     
                     @"Bulgaria":@"Sofia",
                     
                     @"Belgium":@"Bruxelles",
                     
                     @"Poland":@"Warszawa",
                     
                     @"BosniaandHerzegovina":@"Sarajevo",
                     
                     @"Portugal":@"Lisbon",
                     
                     @"Macedonia":@"Skopje",
                     
                     @"Malta":@"Valletta",
                   
                     @"Monaco":@"Monaco",
                   
                     @"Montenegro":@"Podgorica",
                     
                     @"Latvia":@"Riga",
                     
                     @"Lithuania":@"Vilnius",
                     
                     @"Liechtenstein":@"Vaduz",
                     
                     @"Romania":@"Bucharest",
                     
                     @"Luxembourg":@"Luxembourg",
                     
                     @"UnitedStates":@"Washington,D.C.",
                     
                     @"AntiguaandBarbuda":@"SaintJohn's",
                     
                     @"ElSalvador":@"SanSalvador",
                     
                     @"Canada":@"Ottawa",
                     
                     @"Cuba":@"Havana",
                     
                     @"Guatemala":@"GuatemalaCity",
                     
                     @"Grenada":@"SaintGeorge's",
                     
                     @"Costa Rica":@"SanJose",
                     
                     @"Jamaica":@"Kingston",
                     
                     @"SaintChristopherandNevis":@"Basseterre",
                     
                     @"SaintVincentandtheGrenadines":@"Kingstown",
                     
                     @"SaintLucia":@"Castries",
                     
                     @"TrinidadandTobago":@"PortofSpain",
                     
                     @"CommonwealthofDominica":@"Roseau",
                     
                     @"DominicanRepublic":@"SantoDomingo",
                     
                     @"Nicaragua":@"Managua",
                
                     @"Haiti":@"Port-au-Prince",
                     
                     @"Panama":@"PanamaCity",
                     
                     @"Bahamas":@"Nassau",
                     
                     @"Barbados":@"Bridgetown",
                     
                     @"Belize":@"Belmopan",
                     
                     @"Honduras":@"Tegucigalpa",
                     
                     @"Mexico":@"MexicoCity",
                     
                     @"Azerbaijan":@"Baku",
                     
                     @"Armenia":@"Yerevan",
                     
                     @"Ukraine":@"Kyiv",
                     
                     @"Uzbekistan":@"Toshkent",
                     
                     @"Kazakhstan":@"Astana",
                     
                     @"KyrgyzRepublic":@"Bishkek",
                     
                     @"Georgia":@"Tbilisi",
                     
                     @"Tajikistan":@"Dushanbe",
                     
                     @"Turkmenistan":@"Ashgabat",
                     
                     @"Belarus":@"Minsk",
                     
                     @"Moldova":@"kishinev",
                     
                     @"Russia":@"Moscow",
                     
                     @"Australia":@"Canberra",
                     
                     @"Kiribati":@"Tarawa",
                     
                     @"CookIslands":@"Avarua",
                     
                     @"Samoa":@"Apia",
                     
                     @"SolomonIslands":@"Honiara",
                     
                     @"Tuvalu":@"Funafuti",
                     
                     @"Tonga":@"Nuku'alofa",
                     
                     @"Nauru":@"Yaren",
                     
                     @"New Zealand":@"Wellington",
                   
                     @"Vanuatu":@"PortVila",
                     
                     @"PapuaNewGuinea":@"PortMoresby",
                     
                     @"Palau":@"Melekeok",
                     
                     @"Fiji":@"Suva",
                     
                     @"MarshallIslands":@"Majuro",
                     
                     @"Micronesia":@"Palikir",
                   
                     @"Argentina":@"BuenosAires",
                     
                     @"Uruguay":@"Montevideo",
                     
                     @"Ecuador":@"Quito",
                     
                     @"Guyana":@"Georgetown",
                     
                     @"Colombia":@"Bogota",
                     
                     @"Suriname":@"Paramaribo",
                     
                     @"Chile":@"SantiagodeChile",
                     
                     @"Paraguay":@"Asuncion",
                     
                     @"Brazil":@"Brasilia",
                     
                     @"Venezuela":@"Caracas",
                     
                     @"Peru":@"Lima",
                     
                     @"Bolivia":@"LaPaz"}];

    
    for (NSString *key in [countries allKeys]) {
        countries[countries[key]] = key;
        [countries removeObjectForKey:key];
    }
    
    NSLog(@"%@", countries);
    
    NSLog(@"capitalstr = %@",[CapitalStrManager sharedManager].capitalstr);
    
    countrylabel.text = [countries valueForKey:[CapitalStrManager sharedManager].capitalstr];
    
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
            
            _buttonIndex = -1;
            while (_buttonIndex == -1) {
                [[NSRunLoop currentRunLoop]
                 runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5f]]; // 0.5秒
            }
            
        }
        else{
            if(favcount >= 11){
                UIAlertView *alert1 =[[UIAlertView alloc]
                                     initWithTitle:@"You can't add favorate anymore!"
                                     message:@"There are too many favorates!"
                                     delegate:nil
                                     cancelButtonTitle:nil
                                     otherButtonTitles:@"OK", nil
                                     ];
                [alert1 show];
                
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
