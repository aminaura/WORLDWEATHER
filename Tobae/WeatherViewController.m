//
//  WeatherViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/09/13.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import "WeatherViewController.h"
#import "VerticalTableViewCell.h"

@interface WeatherViewController (){
    NSMutableArray * capitalarray;
    NSMutableArray * countryarray;
  
    NSMutableArray * weekdays;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(3.0, 3.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    view1.layer.mask = maskLayer;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(3.0, 3.0)];
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    view1.layer.mask = maskLayer;
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/city/%@", capitalstr]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // ⑦ weather.mainの値を抽出
    NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
    NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
    NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
    NSArray *temperature = [object valueForKeyPath:@"weather.temperature"];
    
    temperaturela.text = [NSString stringWithFormat:@"%@℃",temperature];
    
    NSLog(@"main(天候)=%@,description(天候詳細)=%@,speed(風速)=%@,icons(天気アイコン)=%@",main,description,speed,temperature);
    
    NSDictionary *weather= @{@"main":main,
                             @"description":description,
                             @"speed":speed,
                             @"Tempereture":temperature};

    
    
    capitalarray = @[@"Alger",
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
                     @"Juba",
                     @"Kabul",
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
                     @"Pyongyang",
                     @"Reykjavik",
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
                     @"Luxembourg",
                     @"Washington,D.C.",
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
                     @"PortVila",
                     @"PortMoresby",
                     @"Melekeok",
                     @"Suva",
                     @"Majuro",
                     @"Palikir",
                     @"BuenosAires",
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
    
    
    countryarray = @[@"Algeria",
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
                     @"Sierra Leone",
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
                     @"Madagascal",
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
    
    
    
    
    
    // 配列から要素を検索する
    NSInteger index = [capitalarray indexOfObject:capitalstr];
    
    countryla.text = [NSString stringWithFormat:@"%@",countryarray[index]];
    Capitalla.text = capitalstr;
    
    
    weekdays = @[@"sun",
                 @"mon",
                 @"tue",
                 @"wed",
                 @"thu",
                 @"fri",
                 @"sat"].mutableCopy;
    
}

-(void)getdate{
    date  = [NSDate date];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags;
    NSDateComponents *comps;
    
    // 年・月・日を取得
    flags = NSCalendarUnitMonth| NSCalendarUnitDay;
    comps = [calendar components:flags fromDate:now];
    
    NSInteger month = comps.month;
    NSInteger day = comps.day;
    
    NSDateComponents *comps2;
    comps2 = [calendar components:NSCalendarUnitWeekday fromDate:now];
    NSInteger weekday = comps2.weekday; // 曜日(1が日曜日 7が土曜日)
    
    
    NSString *week = [NSString stringWithFormat:@"%@",weekdays[weekday]];

}

@end
