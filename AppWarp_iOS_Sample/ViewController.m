//
//  ViewController.m
//  AppWarp_iOS_Sample
//
//  Created by shephertz technologies on 22/05/13.
//  Copyright (c) 2013 shephertz technologies. All rights reserved.
//

#import "ViewController.h"
#import <AppWarp_iOS_SDK/AppWarp_iOS_SDK.h>
#import "ConnectionListener.h"
#import "RoomListener.h"
#import "NotificationListener.h"
#import "ZoneListener.h"
#import "LobbyListener.h"
#import "ChatListener.h"

#define APPWARP_APP_KEY     @"cad2bfab6310acd9696187b98682925125e469ab0d0d585db0b00609f461b791"
#define APPWARP_SECRET_KEY  @"55811709916e7ce4405cde0cdc5a254cf4b506fbafdae05760a73100b8080b67"
#define MAX_USERS 3
#define TURN_TIME 30

@interface ViewController ()

@end

@implementation ViewController
@synthesize roomId;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initializeAppWarp];
}

-(void)initializeAppWarp {
    [WarpClient initWarp:APPWARP_APP_KEY secretKey:APPWARP_SECRET_KEY];
    
    WarpClient *warpClient = [WarpClient getInstance];
    
    ConnectionListener *connectionListener = [[ConnectionListener alloc] initWithHelper:self];
    [warpClient addConnectionRequestListener:connectionListener];
    [connectionListener release];
    
    ZoneListener *zoneListener = [[ZoneListener alloc] initWithHelper:self];
    [warpClient addZoneRequestListener:zoneListener];
    [zoneListener release];
    
    RoomListener *roomListener = [[RoomListener alloc]initWithHelper:self];
    [warpClient addRoomRequestListener:roomListener];
    [roomListener release];
    
    NotificationListener *notificationListener = [[NotificationListener alloc]initWithHelper:self];
    [warpClient addNotificationListener:notificationListener];
    [notificationListener release];
    
    LobbyListener *lobbyListener = [[LobbyListener alloc]initWithHelper:self];
    [warpClient addLobbyRequestListener:lobbyListener];
    [lobbyListener release];
    
    ChatListener *chatListener = [[ChatListener alloc]initWithHelper:self];
    [warpClient addChatRequestListener:chatListener];
    [chatListener release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertWithInfo:(NSDictionary*)alertInfo {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: [alertInfo objectForKey:@"title"]
                          message:[alertInfo objectForKey:@"message"]
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void)updateResponseLabel:(NSString*)responseString {
    [response setText:responseString];
}

- (void)getLiveRoomInfo {
    [[WarpClient getInstance] getLiveRoomInfo:roomId];
}

#pragma mark -- Button Actions -- 

-(IBAction)connectButtonAction:(id)sender {
    if ([nameTextField.text length]) {
        [self setUserName: nameTextField.text];
        [[WarpClient getInstance] connectWithUserName:nameTextField.text];
        [nameTextField resignFirstResponder];
    } else {
        [self showAlertWithInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Ooops!!",@"title",
                                @"Invalid User Name",@"message",nil]];
    }
}


-(IBAction)disConnectButtonAction:(id)sender {
    [[WarpClient getInstance] disconnect];
}


-(IBAction)createRoomButtonAction:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    NSString *game = @"Apple";
    NSDictionary *properties = @{
                                 @"host":[self getUsername],
                                 @"gamename":game,
                                 };
    
    [[WarpClient getInstance] createTurnRoomWithRoomName:@"testRoom1234567890"
                                               roomOwner:[self getUsername]
                                              properties:properties
                                                maxUsers:MAX_USERS
                                           turnExpiresIn:TURN_TIME];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
