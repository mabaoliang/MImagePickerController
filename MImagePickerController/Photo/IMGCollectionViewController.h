//
//  IMGCollectionViewController.h
//  VideoAndAudio
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class IMGCollectionViewController;
@protocol IMGCollectionViewControllerDelegate<NSObject>

/**返回选取的图片数组*/
-(void)IMGCollectionViewController:(NSArray *)imgArr;


@end
typedef void(^IMGblock)(NSArray *arrIMG);

@interface IMGCollectionViewController : UIViewController

@property(assign,nonatomic) NSInteger numCount;/**最大数量*/
@property(strong,nonatomic)IMGblock imgBlock; /**block回调*/
@property(weak,nonatomic)id<IMGCollectionViewControllerDelegate> delegate;/**代理*/
@property(strong,nonatomic)UIColor *btnColor;/**确定按钮背景颜色*/
@property(strong,nonatomic)UIColor *btnTitleColor;/**确定按钮文字颜色*/
@property(strong,nonatomic)UIColor *btnTitleHightColor;/**按钮按钮文字高量颜色*/
//@property(strong,nonatomic)

/**通过block方法获取图片*/
-(instancetype)initController:(NSInteger)num block:(IMGblock)returnIMG;

/**代理初始化*/
-(instancetype)initController:(NSInteger)num;
@end
