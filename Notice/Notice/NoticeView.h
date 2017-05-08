//
//  NoticeView.h
//  XianJinDai
//
//  Created by 航哥 on 2017/4/10.
//  Copyright © 2017年 com.hangge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoticeViewDelegate <NSObject>

- (void)noticeViewSelectNoticeActionAtIndex:(NSInteger)index;

@end

@interface NoticeView : UIView

/**
 图片
 */
@property (nonatomic , strong) UIImageView *imageView;

/**
 定时器的循环时间
 */
@property (nonatomic , assign) NSInteger interval;

@property (nonatomic , assign) id<NoticeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame
                     andImage:(NSString *)imageName
                 andDataArray:(NSArray *)dataArray;

/**
 创建定时器并run
 */
- (void)startTimer;
@end
