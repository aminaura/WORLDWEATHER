//
//  MainViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/09.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MainViewController{
    
    UIImage *selectedImage;
    
    IBOutlet UIImageView *imageView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout{
    [PFUser logOutInBackgroundWithBlock:^(NSError *error) {
        if (!error) {
            //ユーザのログインに成功
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            //ユーザのログインに失敗
            NSLog(@"error..%@",error);
        }
    }]; //ログアウト
}

-(IBAction)quit{
    
    UIAlertView *message = [[UIAlertView alloc]
                            initWithTitle:@"REALLY?"
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

-(IBAction)change{
    
    PFUser *user  = [PFUser currentUser];
    
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    
    PFFile *imageFile =[PFFile fileWithName:@"image.png" data:imageData];
    [user setObject:imageFile forKey:@"image"];
    [user saveInBackground];
    
    [self getUserImage];
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
    else{
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    selectedImage = image;
    imageView.image = selectedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getUserImage {
    PFUser *user = [PFUser currentUser];
    PFFile *file = user[@"image"];
    NSData *imageData = [file getData];
    UIImage *userImage = [UIImage imageWithData:imageData];
    imageView.image = userImage;
}


@end
