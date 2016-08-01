//
//  SocketVC.m
//  Two
//
//  Created by li.bin on 16/7/25.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "SocketVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
@interface SocketVC ()

@end

@implementation SocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
//连接按钮
- (IBAction)conn:(id)sender {
    BOOL result = [self connectToHost:self.hostText.text port:self.portText.text.intValue];
    self.recvLabel.text = result ? @"success!" : @"defeat！";
}
//发送按钮
- (IBAction)send:(id)sender {
    self.recvLabel.text = [self sendAndRecv:self.msgText.text];
}
//建立连接
- (BOOL)connectToHost:(NSString *)host port:(int)port
{
    //创建socket对象
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    //建立连接
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;
    //IP,查找机器
    serverAddress.sin_addr.s_addr = inet_addr(host.UTF8String);
    serverAddress.sin_port = htons(port);  //端口，查找程序
    return (connect(self.clientSocket, (const struct sockaddr *)&serverAddress, sizeof(serverAddress)) == 0);
}

#pragma mark - 发送和接收
- (NSString *)sendAndRecv:(NSString *)message
{
    //1.发送信息
    ssize_t sendLen = send(self.clientSocket, message.UTF8String, strlen(message.UTF8String),0);
    //2.接收信息
    //2.1定义一个数组
    uint8_t buffer[1024];
    ssize_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    //2.2 获取服务器返回的二进制数据
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    
    //转换成字符串
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return  str;
}

#pragma mark - 断开连接
- (void)disconnection
{
    close(self.clientSocket);
}

@end
