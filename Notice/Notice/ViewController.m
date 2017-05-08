//
//  ViewController.m
//  Notice
//
//  Created by 航哥 on 2017/5/8.
//  Copyright © 2017年 com.hangge. All rights reserved.
//

#import "ViewController.h"
#import "NoticeView.h"
@interface ViewController ()<NoticeViewDelegate>
@property (nonatomic , strong) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //数据源标题
    self.dataArr = @[@"通知1",@"通知2",@"通知3",@"通知4",@"通知5",@"通知6"];
    //初始化
    NoticeView *notice = [[NoticeView alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 30) andImage:@"noticeYellow" andDataArray:self.dataArr];
    notice.delegate = self;
    //设置定时器多久循环
    notice.interval = 2;
    notice.layer.borderColor = [UIColor blueColor].CGColor;
    notice.layer.borderWidth = 1;
    [self.view addSubview:notice];
    //开始循环
    [notice startTimer];
    
}
- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index{
    NSLog(@"%@",self.dataArr[index]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
