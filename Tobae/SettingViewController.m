//
//  SettingViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/11.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "SettingViewController.h"
#import <Parse/Parse.h>

@interface SettingViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SettingViewController{
    UIImage *selectedImage;
    
    IBOutlet UIImageView *imageView;
    
    IBOutlet UITextField *newusername;
    IBOutlet UITextField *newcomments;
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    newusername.delegate = self;
    newcomments.delegate = self;
    
}

-(IBAction)back{
    
    if([newusername.text isEqualToString:@""] && [newcomments.text isEqualToString:@""]){
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else {
        PFUser *user  = [PFUser currentUser];
        
        if (newusername.text.length > 0) {
            user.username = newusername.text;
        }
        if (newcomments.text.length > 0) {
            [user setObject:newcomments.text forKey:@"Comments"];
        }
        
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
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSLog(@"error...%@",error);
            }
        }];
    }
    
}

-(IBAction)quit{
    
    UIAlertView *message = [[UIAlertView alloc]
                            initWithTitle:@"Really? Please type your password."
                            message:nil
                            delegate:self
                            cancelButtonTitle:@"YES"
                            otherButtonTitles:@"NO", nil];
    
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];//１行で実装
    [message show];
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理
            [[alertView textFieldAtIndex:0] resignFirstResponder];
            
            if([[alertView textFieldAtIndex:0].text isEqual: [[PFUser currentUser] password]]){
                
                [[PFUser currentUser] deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        //ユーザの退会に成功
                        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                        NSLog(@"quit");
                    } else {
                        //ユーザの退会に失敗
                        NSLog(@"error..%@",error);
                    }
                }];
                
            }
            else{
                
            }
            
            break;
        case 1:
            //２番目のボタンが押されたときの処理
            break;
    }
    
}

-(IBAction)logout{
    [PFUser logOutInBackgroundWithBlock:^(NSError *error) {
        if (!error) {
            //ユーザのログアウトに成功
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"logout");
        } else {
            //ユーザのログアウトに失敗
            NSLog(@"error..%@",error);
        }
    }]; //ログアウト
}


-(IBAction)selectimage{
    
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"選択してください。";
    [as addButtonWithTitle:@"カメラから"];
    [as addButtonWithTitle:@"フォトライブラリから"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 2;
    as.destructiveButtonIndex = 0;
    [as showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    else if(buttonIndex == 1){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }
    else{
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    selectedImage = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self change];
}

-(void)change{
    
    PFUser *user  = [PFUser currentUser];
    
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    
    PFFile *imageFile =[PFFile fileWithName:@"image.png" data:imageData];
    [user setObject:imageFile forKey:@"image"];
    [user saveInBackground];
    
    [self getUserImage];
}

- (void)getUserImage {
    PFUser *user = [PFUser currentUser];
    PFFile *file = user[@"image"];
    NSData *imageData = [file getData];
    UIImage *userImage = [UIImage imageWithData:imageData];
    imageView.image = userImage;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // textFieldを最初にイベントを受け取る対象から外すことで、キーボードを閉じる。
    [newcomments resignFirstResponder];
    [newusername resignFirstResponder];
    
    return YES;
}

@end
