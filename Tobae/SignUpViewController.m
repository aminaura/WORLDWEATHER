//
//  SignUpViewController.m
//  Tobae
//
//  Created by 菅野楓 on 2016/01/09.
//  Copyright © 2016年 Original_Weather. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SignUpViewController {
    
    UIImage *selectedImage;
    
    IBOutlet UIImageView *imageView;
    
    IBOutlet UITextField *UserIDfield;
    IBOutlet UITextField *Mailadressfield;
    IBOutlet UITextField *Passwordfield;
    IBOutlet UITextField *Commentfield;

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserIDfield.delegate = self;
    Mailadressfield.delegate = self;
    Passwordfield.delegate = self;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


-(IBAction)signup {
    
    PFUser *user  = [PFUser user];
    user.username = UserIDfield.text;
    user.email    = Mailadressfield.text; //optional
    user.password = Passwordfield.text;
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    
    PFFile *imageFile =[PFFile fileWithName:@"image.png" data:imageData];
    [user setObject:imageFile forKey:@"image"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //ユーザの作成に成功
            [self performSegueWithIdentifier:@"ToHome" sender:self];
        } else {
            NSLog(@"error...%@",error);
            //アプリの作成に失敗
            //エラー内容を見れば理由がだいたい分かる。
        }
    }];
    
    
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

@end
