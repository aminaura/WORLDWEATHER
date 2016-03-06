//
//  ChangeMailAddressViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/11.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "ChangeMailAddressViewController.h"
#import <Parse/Parse.h>

@interface ChangeMailAddressViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation ChangeMailAddressViewController{
    IBOutlet UITextField *newaddress;
    IBOutlet UITextField *confirmaddress;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    newaddress.delegate = self;
    confirmaddress.delegate = self;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)change{
    
    PFUser *user  = [PFUser currentUser];
    
    if([newaddress.text isEqualToString:confirmaddress.text]) {
        NSString *new = newaddress.text;

        user.email = new;
        
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

    }else {
        UIAlertView *message = [[UIAlertView alloc]
                                initWithTitle:@"Email address doesn't match the confirm address.."
                                message:nil
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
        [message show];
    }
    
    
}

-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
