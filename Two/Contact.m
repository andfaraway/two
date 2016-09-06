//
//  Contact.m
//  Two
//
//  Created by li.bin on 16/9/1.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "Contact.h"
#import <ContactsUI/ContactsUI.h>
static CNContactPickerViewController *con;
@interface Contact ()<CNContactPickerDelegate,CNContactViewControllerDelegate>
{
}

@end

@implementation Contact

- (void)openContact:(UIViewController *)viewController
{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:con animated:NO completion:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        con = [[CNContactPickerViewController alloc]init];
        con.view.frame = [UIScreen mainScreen].bounds;
        con.delegate = self;
        //控制显示
        con.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    }
    return self;
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    NSLog(@"1111");
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    NSLog(@"22222");
}


- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}








@end
