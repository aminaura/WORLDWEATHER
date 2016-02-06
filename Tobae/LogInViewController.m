//
//  LogInViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/09.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
@interface LogInViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation LogInViewController{
    IBOutlet UITextField *UserNameField;
    IBOutlet UITextField *PassWordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserNameField.delegate = self;
    PassWordField.delegate = self;
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


-(IBAction)login{
    [PFUser logInWithUsernameInBackground:UserNameField.text password:PassWordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            //ユーザのログインに成功
                                            [self performSegueWithIdentifier:@"Gomain" sender:nil];
                                        } else {
                                            //ユーザのログインに失敗
                                            NSLog(@"error...%@",error);
                                        }
                                    }];
}

-(IBAction)back{
    [self dismissViewControllerAnimated:self completion:nil];
}


@end
