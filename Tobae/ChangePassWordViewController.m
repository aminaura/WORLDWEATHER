
//
//  ChangePassWordViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/11.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import <Parse/Parse.h>

@interface ChangePassWordViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation ChangePassWordViewController{
    IBOutlet UITextField *newpass;
    IBOutlet UITextField *confirmpass;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    newpass.delegate = self;
    confirmpass.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(IBAction)change{
    
    PFUser *user  = [PFUser currentUser];
    
    if([newpass.text isEqualToString:confirmpass.text]){
        NSString *new = newpass.text;
        
        user.password = new;
        
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //ユーザの保存に成功
                UIAlertView *message = [[UIAlertView alloc]
                                        initWithTitle:@"Succeeded!"
                                        message:nil
                                        delegate:self
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
                [message show];
                
            } else {
                NSLog(@"error...%@",error);
            }
        }];
        
        
    }
    else{
        UIAlertView *message = [[UIAlertView alloc]
                                initWithTitle:@"password doesn't match the confirm password."
                                message:nil
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
        [message show];
    }
    
}

-(IBAction)back{
    [self.presentingViewController.presentingViewController.presentingViewController
        .presentingViewController  dismissViewControllerAnimated:YES completion:nil];
}

@end
