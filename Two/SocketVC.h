//
//  SocketVC.h
//  Two
//
//  Created by li.bin on 16/7/25.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocketVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *hostText;
@property (weak, nonatomic) IBOutlet UITextField *portText;
@property (weak, nonatomic) IBOutlet UITextField *msgText;
@property (weak, nonatomic) IBOutlet UITextView *recvLabel;
@property (assign, nonatomic)int clientSocket;

@end
