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
    IBOutlet UILabel *commentlabel;
    IBOutlet UILabel *usernamelabel;

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUserImage];
    [self getComment];
    [self getUserName];

}

-(void)viewWillAppear:(BOOL)animated {
    [self getUserImage];
    [self getComment];
    [self getUserName];
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)getUserImage {
    PFUser *user = [PFUser currentUser];
    PFFile *file = user[@"image"];
    NSData *imageData = [file getData];
    UIImage *userImage = [UIImage imageWithData:imageData];
    imageView.image = userImage;
}

- (void)getComment {
    PFUser *user = [PFUser currentUser];
    commentlabel.text = user[@"Comments"];
}

- (void)getUserName {
    PFUser *user = [PFUser currentUser];
    usernamelabel.text = user.username;
}


@end
