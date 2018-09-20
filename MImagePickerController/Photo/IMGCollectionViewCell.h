//
//  IMGCollectionViewCell.h
//  VideoAndAudio
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMGCollectionViewCell;


@protocol IMGCollectionViewCellDelegate <NSObject>

@optional
-(void)IMGCollectionView:(IMGCollectionViewCell*)cell isSelected:(Boolean)isA;

@end


@interface IMGCollectionViewCell : UICollectionViewCell

@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UIButton *imgSelected;/***/
@property(weak,nonatomic)id<IMGCollectionViewCellDelegate> delegate;


@end


