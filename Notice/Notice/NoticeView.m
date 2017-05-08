//
//  NoticeView.m
//  XianJinDai
//
//  Created by 航哥 on 2017/4/10.
//  Copyright © 2017年 com.hangge. All rights reserved.
//

#import "NoticeView.h"
//static CGFloat firstBtnTotate;
//static CGFloat SecondBtnTotate;
#define BtnBaseTag      1000
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define Scaling         [UIScreen mainScreen].bounds.size.width/375

@interface NoticeView ()
@property (nonatomic , strong) NSMutableArray *btnArray;

@end

@implementation NoticeView
- (instancetype)initWithFrame:(CGRect)frame
                     andImage:(NSString *)imageName
                 andDataArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.dataArray = [NSArray arrayWithArray:dataArray];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.image = [UIImage imageNamed:imageName];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];

        //图片的约束
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
       NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
        [self addConstraint:left];
        
       NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraint:centerY];
        
       NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(27 * Scaling)];
        [self.imageView addConstraint:width];
        
       NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(25 * Scaling)];
        [self.imageView addConstraint:height];
        
        //根据数据源创建Btn 可以在创建Btn的时候修改你所需要的属性
        if (dataArray.count>0) {
            for (int i = 0; i < dataArray.count ; i++) {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = BtnBaseTag + i;
                [btn setTitle:dataArray[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.frame = CGRectMake(47, 2, self.frame.size.width - 47-10, self.frame.size.height-4);
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                if (i != 0) {
                    CATransform3D trans = CATransform3DIdentity;
                    trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                    trans = CATransform3DTranslate(trans, 0, - self.frame.size.height/2, -self.frame.size.height/2);
                    btn.layer.transform = trans;
                }else{
                    CATransform3D trans = CATransform3DIdentity;
                    trans = CATransform3DMakeRotation(0, 1, 0, 0);
                    trans = CATransform3DTranslate(trans, 0, 0, - self.frame.size.height/2);
                    btn.layer.transform = trans;
                }
                [self addSubview:btn];
                [self.btnArray addObject:btn];
                
            }
        }
        
        
        
        

        
        
        
    }
    return self;
}
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (void)startTimer{
    
    NSLog(@"%ld",self.interval);
    if (!self.interval) {
        self.interval = 5;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerRun{
    
    if (self.btnArray.count >1) {
        

        [UIView animateWithDuration:self.interval/2 animations:^{
            
            
            UIButton *btn = self.btnArray[0];
            CATransform3D trans = CATransform3DIdentity;
            trans = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
            trans = CATransform3DTranslate(trans, 0, self.frame.size.height/2, - self.frame.size.height/2);
            btn.layer.transform = trans;

            
            UIButton *btn1 = self.btnArray[1];
            CATransform3D trans1 = CATransform3DIdentity;
            trans1 = CATransform3DMakeRotation(0, 1, 0, 0);
            trans1 = CATransform3DTranslate(trans1, 0, 0, 0);
            btn1.layer.transform = trans1;
            
            
        } completion:^(BOOL finished) {
            
            if (finished == YES) {
                UIButton *btn = self.btnArray[0];
                CATransform3D trans = CATransform3DIdentity;
                trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                trans = CATransform3DTranslate(trans, 0, - self.frame.size.height/2, - self.frame.size.height/2);
                btn.layer.transform = trans;
                
                
                
                [self.btnArray addObject:btn];
                [self.btnArray removeObjectAtIndex:0];
            }
           
            
            
        }];
        
        
    }
    
}
- (void)btnAction:(UIButton *)sender{
    
//    sender.model.content = sender.titleLabel.text;
//    
//    NSArray *data = [MethodTools checkAllWebURL];
    
    NSInteger tag = sender.tag - BtnBaseTag;
    
    if ([self.delegate respondsToSelector:@selector(noticeViewSelectNoticeActionAtIndex:)]) {
        [self.delegate noticeViewSelectNoticeActionAtIndex:tag];
    }
    
//    NSString *url = nil;
//    if (data.count>0) {
//        for (NSDictionary *dic in data) {
//            if ([dic[@"id"] integerValue] == 5) {
//                url = dic[@"url"];
//                JFWebController *web = [[JFWebController alloc] initWithRequestPath:url];
//                [web setNavTitleWithString:dic[@"title"]];
//                self.controller.navigationController.hidesBottomBarWhenPushed = YES;
//                [self.controller.navigationController pushViewController:web animated:YES];
//                NSLog(@"btn-------%@",sender.model.content);
//            }
//        }
//      
//    }

    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
