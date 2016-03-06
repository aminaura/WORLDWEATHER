//
//  WeatherViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2015/09/13.
//  Copyright (c) 2015年 Original_Weather. All rights reserved.
//ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・ー・・ー・ー・ー・ー

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
    
    NSLog(@"Icon == %@", [CapitalStrManager sharedManager].icon);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/city/%@", [CapitalStrManager sharedManager].capitalstr]];
    
    NSLog(@"CapitalStrManager = %@",[CapitalStrManager sharedManager].capitalstr);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    // ⑦ weather.mainの値を抽出
    NSArray *main = [object valueForKeyPath:@"weather.main"]; //天候
    NSArray *description = [object valueForKeyPath:@"weather.description"]; // 天候詳細
    NSArray *speed = [object valueForKeyPath:@"wind.speed"]; //風速
    NSArray *temperature = [object valueForKeyPath:@"weather.temperature"];
    
    temperaturela.text = [NSString stringWithFormat:@"%@",temperature];
    
    NSLog(@"main(天候)= %@,description（天候詳細）=%@,speed（風速）=%@,icons（天気アイコン=%@",main,description,speed,temperature);
    
    
      array = @[@"Algeria",
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
                @"EquatorialGuinea",
                @"CentralAfricanRepublic",
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
                @"SaudiArabia",
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
                @"CostaRica",
                @"Jamaica",
                @"SaintChristopherandNevis",
                @"SaintVincentandtheGrenadines",
                @"Saint Lucia",
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

    
    Capitalla.text = [CapitalStrManager sharedManager].capitalstr;
    
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
