//
//  MyVC.m
//  ARTest
//
//  Created by 胡忠诚 on 2018/6/28.
//  Copyright © 2018年 biyu6. All rights reserved.
//首页VC

#import "MyVC.h"
#import "MyARVC.h"//AR界面VC

@interface MyVC ()

@end
@implementation MyVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    [btn setTitle:@"进入AR" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnClick:(UIButton *)btn{//点击了AR
    MyARVC *myARVC = [[MyARVC alloc]init];
    [self presentViewController:myARVC animated:YES completion:nil];
}


@end
