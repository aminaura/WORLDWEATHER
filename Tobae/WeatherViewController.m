//
//  WeatherViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/09/13.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//

#import "WeatherViewController.h"
#import "VerticalTableViewCell.h"
#import "CapitalStrManager.h"

@interface WeatherViewController (){
    NSMutableDictionary * array;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/city/%@", [CapitalStrManager sharedManager].capitalstr]];
    
    NSLog(@"aaaaaa = %@",[CapitalStrManager sharedManager].capitalstr);
    
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
    
    
    array = @[  @"Algeria",
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

    
    Capitalla.text = [CapitalStrManager sharedManager].capitalstr
    ;
    
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
    
    

}



@end
