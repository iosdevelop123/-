//
//  ContactUsViewController.m
//  MarKet
//
//  Created by Aaron Lee on 16/4/19.
//  Copyright © 2016年 Secret. All rights reserved.
//

#import "ContactUsViewController.h"
#import "BaseNavigation.h"
#import "BaseWebRequest.h"
#import <AFNetworking/AFNetworking.h>
#define WIDTH CGRectGetWidth(self.view.bounds)
#define HEIGHT CGRectGetHeight(self.view.bounds)
#define API @"http://175.102.13.51:8080/XDSY/ZhuBan?type=.guanwang&defference=lianxi&indexPage=0"
@interface ContactUsViewController ()<UIWebViewDelegate>
@property (strong,nonatomic) UILabel *label;
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义导航栏
    [BaseNavigation loadUIViewController:self title:@"联系我们" navigationBarBgColor:[UIColor blackColor] backSelector:@selector(back)];
    //网络请求
    [self WebRequest];
}
- (void)WebRequest{
    BaseWebRequest *webRequest = [[BaseWebRequest alloc] init];
    [webRequest webRequestWithAPI:API CompletionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *data = [dic objectForKey:@"data"];
            NSString *CompanyAddress=[data[0]objectForKey:@"CompanyAddress"];
            NSString *CompanyTel=[data[0]objectForKey:@"CompanyTel"];
            NSString *ComplaintsTel=[data[0]objectForKey:@"ComplaintsTel"];
            NSString *CustomerHotline=[data[0]objectForKey:@"CustomerHotline"];
            NSString *HeadquartersAddress=[data[0]objectForKey:@"HeadquartersAddress"];
            NSString *JoinHotline=[data[0]objectForKey:@"JoinHotline"];
            NSArray  *arr2=[NSArray arrayWithObjects:CompanyTel,CustomerHotline,JoinHotline,ComplaintsTel,CompanyAddress,HeadquartersAddress, nil];
            NSArray *arr1=[[NSArray alloc]initWithObjects:@"公司电话:",@"客服热线:",@"加盟热线:",@"投诉电话:",@"公司地址:上",@"总部地址:",nil];
            for (int i=0; i<5; i++) {
                _label=[[UILabel alloc]initWithFrame:CGRectMake(10, 35*i, WIDTH-20, 35)];
                _label.text=[NSString stringWithFormat:@"%@%@",arr1[i],arr2[i]];
                _label.font=[UIFont systemFontOfSize:13.0];
                _label.numberOfLines=0;
                _label.textColor=[UIColor blackColor];
                [self.view addSubview:_label];
            }
            UIImageView *imgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map.png"]];
            imgV.frame=CGRectMake(0, CGRectGetMaxY(_label.frame)+5, WIDTH, HEIGHT-CGRectGetMaxY(_label.frame));
            [self.view addSubview:imgV];
        }
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
@end