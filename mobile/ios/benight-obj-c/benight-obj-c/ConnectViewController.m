//
//  ViewController.m
//  benight-obj-c
//
//  Created by Kevin VACQUIER on 15/02/2016.
//  Copyright © 2016 Kevin VACQUIER. All rights reserved.
//

#import "ConnectViewController.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ErrorPopup:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (IBAction)Connect {
    if ([self.idField.text length] > 0) {
        if ([self.passwdField.text length] > 0) {
            [PFUser logInWithUsernameInBackground:self.idField.text password:self.passwdField.text
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    [self ErrorPopup:@"Login OK"];
                                                } else {
                                                    [self ErrorPopup:@"Login Failed"];
                                                }
                                            }];
        }
    }
}

@end
