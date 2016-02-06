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

@interface DetailViewController ()
{
    NSDictionary * array;
    NSMutableArray * country;
    NSDictionary *weather_icon;
    NSString *imageKeyname;
    
    NSMutableArray * capital;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    capitallabel.text = [CapitalStrManager sharedManager].capitalstr;
    UIImage *icon =[CapitalStrManager sharedManager].icon;
    image.image = icon;
    
    [self country];
    
    [self getweather:[CapitalStrManager sharedManager].capitalstr];
    [self sunrise:[CapitalStrManager sharedManager].capitalstr];

    
    [self get];
    
}

-(IBAction)back{
    // 戻るコード
    [self dismissViewControllerAnimated:YES completion:nil];
    }




- (void)getweather: (NSString *)string{
    
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
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    //  NSLog(@"DATA==%@",object);
    
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
    
    humidityla.text = [NSString stringWithFormat:@"humidity:%@",[listarray[0]  valueForKey:@"humidity"]];
    
    
    
    
    //   TODO: 降水量が取れるようにする。(rain keyがある日とない日があるので注意)
    for(int i = 0; i < listarray.count; i ++){
        if ([listarray[i] valueForKey:@"rain"]) {
            ((UILabel *)rainfallla[i]).text = [NSString stringWithFormat:@"rain:%@mm",[listarray[i]  valueForKey:@"rain"]];
        }else {
            ((UILabel *)rainfallla[i]).text = @"rain:0mm";
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
    sunrise.text = [NSString stringWithFormat:@"sunrise：%@",sunrisestr];
    
    NSDateFormatter *sunsetFormatter = [[NSDateFormatter alloc] init];
    [sunsetFormatter setDateFormat:@"HH:mm"];
    NSString *sunsetstr = [sunriseFormatter stringFromDate:sunsetDate];
    
     
    NSLog(@"sunsetDate: %@", sunsetDate);
    sunset.text = [NSString stringWithFormat:@"sunset：%@",sunsetstr];
}


-(void)country{
    country = @[ @"Algeria",
                 @"Angola",
                 @"Uganda",
                 @"Egypt",
                 @"Ethiopia",
                 @"Eritrea",
                 @"Ghana",
                 @"Cape Verde",
                 @"Gabonese Republic",
                 @"Cameroon",
                 @"Gambia",
                 @"Guinea",
                 @"Guinea-Bissau",
                 @"Kenya",
                 @"Cote d'Ivoire",
                 @"Comoros",
                 @"Republic of Congo",
                 @"Democratic Republic of the Congo",
                 @"Sao Tome and Principe",
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
                 @"Burkina Faso",
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
                 @"Central African Republic",
                 @"South Africa",
                 @"South Sudan",
                 @"Afghanistan",
                 @"United Arab Emirates",
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
                 @"Sri Lanka",
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
                 @"North Korea",
                 @"Iceland",
                 @"Ireland",
                 @"Albania",
                 @"Andorra",
                 @"United Kingdom",
                 @"Italy",
                 @"Vatican",
                 @"Estonia",
                 @"Austria",
                 @"Netherlands",
                 @"Greece",
                 @"Croatia",
                 @"Kosovo",
                 @"San Marino",
                 @"Switzerland",
                 @"Sweden",
                 @"Spain",
                 @"Slovak Republic",
                 @"Slovenia",
                 @"Serbia",
                 @"Czech Republic",
                 @"Denmark",
                 @"Germany",
                 @"Norway",
                 @"Hungary",
                 @"Finland",
                 @"France",
                 @"Bulgaria",
                 @"Belgium",
                 @"Poland",
                 @"Bosnia and Herzegovina",
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
                 @"United States",
                 @"Antigua and Barbuda",
                 @"El Salvador",
                 @"Canada",
                 @"Cuba",
                 @"Guatemala",
                 @"Grenada",
                 @"Costa Rica",
                 @"Jamaica",
                 @"Saint Christopher and Nevis",
                 @"Saint Vincent and the Grenadines",
                 @"Saint Lucia",
                 @"Trinidad and Tobago",
                 @"Commonwealth of Dominica",
                 @"Dominican Republic",
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
                 @"Kyrgyz Republic",
                 @"Georgia",
                 @"Tajikistan",
                 @"Turkmenistan",
                 @"Belarus",
                 @"Moldova",
                 @"Russia",
                 @"Australia",
                 @"Kiribati",
                 @"Cook Islands",
                 @"Samoa",
                 @"Solomon Islands",
                 @"Tuvalu",
                 @"Tonga",
                 @"Nauru",
                 @"New Zealand",
                 @"Vanuatu",
                 @"Papua New Guinea",
                 @"Palau",
                 @"Fiji",
                 @"Marshall Islands",
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
            // 日付のオフセットを生成
            NSDateComponents *dateComp = [[NSDateComponents alloc] init];
            
            // 1日後とする
            [dateComp setDay:i];
            
            // 1日後のNSDateインスタンスを取得する
            date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            
            // 変換用の書式を設定します。
            [formatter setDateFormat:@"MM/dd"];
            
            // NSDate を NSString に変換します。
            NSString *dateStr = [formatter stringFromDate:date];
            
            
            UILabel *datela = datelabel[i-1];
            datela.text = [NSString stringWithFormat:@"%@",dateStr];
            
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
            NSInteger weekday = [components weekday];
            
            NSMutableArray  *weekdays = @[@"sun",
                                          @"mon",
                                          @"tue",
                                          @"wed",
                                          @"thu",
                                          @"fri",
                                          @"sat"].mutableCopy;
            

            
            ((UILabel *)weekdayla[i - 1]).text = [NSString stringWithFormat:@"%@",weekdays[weekday -1]];
            
        }
    }
}


@end
