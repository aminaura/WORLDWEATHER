//
//  LogInViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/09.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"
#import "SignUpViewController.h"

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

-(void)viewWillAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    if(!user){
        
    }
    else{
        [self performSegueWithIdentifier:@"Gomain" sender:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    if (UserNameField.isFirstResponder == YES) {
        [UserNameField resignFirstResponder];
    }else if (PassWordField.isFirstResponder == YES) {
        [PassWordField resignFirstResponder];
    }else {
        
    }
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
                                                [self dismissViewControllerAnimated:self completion:^ {
                                                    
                                                    /* メインスレッドで実行したけど、読み込み処理が長いのでブロック内がしんどい
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        ViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                                                        
                                                        // TODO: self.presentingに対してperformSegueする...
                                                        [mainViewController performSegueWithIdentifier:@"ToProfile" sender:self];
                                                    });
                                                     */
                                                }];

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
