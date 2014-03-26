//
//  ViewController.h
//  AppWarp_iOS_Sample
//
//  Created by shephertz technologies on 22/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UITextField *nameTextField;
    IBOutlet UILabel     *response;
}

@property(nonatomic,retain) NSString *roomId;
@property (nonatomic,retain, getter = getUsername) NSString *userName;

-(void)initializeAppWarp;
-(void)updateResponseLabel:(NSString*)responseString;
- (void)getLiveRoomInfo;

-(IBAction)connectButtonAction:(id)sender;
-(IBAction)disConnectButtonAction:(id)sender;
-(IBAction)createRoomButtonAction:(id)sender;

@end
