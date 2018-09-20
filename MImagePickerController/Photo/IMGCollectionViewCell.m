//
//  IMGCollectionViewCell.m
//  VideoAndAudio
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "IMGCollectionViewCell.h"

@implementation IMGCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.imgView];
        [self addSubview:self.imgSelected];
        [self updateUI];
    }
    return self;
}

-(void)updateUI
{
    //__weak typeof(self) weakself=self;
    
    self.imgView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *left=[NSLayoutConstraint constraintWithItem:self.imgView attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0];
    
     NSLayoutConstraint *top=[NSLayoutConstraint constraintWithItem:self.imgView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0];
    NSLayoutConstraint *right=[NSLayoutConstraint constraintWithItem:self.imgView attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bottom=[NSLayoutConstraint constraintWithItem:self.imgView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0];
    [self addConstraints:@[left,top,right,bottom]];
    
    self.imgSelected.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *leftA=[NSLayoutConstraint constraintWithItem:self.imgSelected attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:-2];
    
      NSLayoutConstraint *topA=[NSLayoutConstraint constraintWithItem:self.imgSelected attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:2];
    
    NSLayoutConstraint *widthA=[NSLayoutConstraint constraintWithItem:self.imgSelected attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(kNilOptions) multiplier:1.0 constant:20];
    
    NSLayoutConstraint *heigthA=[NSLayoutConstraint constraintWithItem:self.imgSelected attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(kNilOptions) multiplier:1.0 constant:20];
    
    [self addConstraints:@[leftA,topA]];
    [self.imgSelected addConstraints:@[widthA,heigthA]];
    
    
    
    
    
}

-(UIImageView *)imgView
{
    if (!_imgView) {
        
        _imgView=[[UIImageView alloc]init];
    }
    return _imgView;
}

-(UIButton *)imgSelected
{
    if (!_imgSelected) {
        
        _imgSelected=[[UIButton alloc]init];
        [_imgSelected setImage:[UIImage imageNamed:@"wzx"] forState:(UIControlStateNormal)];
        [_imgSelected setImage:[UIImage imageNamed:@"zx"] forState:UIControlStateSelected];
        _imgSelected.selected=NO;
        [_imgSelected addTarget:self action:@selector(btnClickWay:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _imgSelected;
}

-(void)btnClickWay:(UIButton *)sender
{
    if (sender.isSelected) {
        sender.selected=NO;
    }else
    {
        sender.selected=YES;
    }
    
    [self.delegate IMGCollectionView:self isSelected:sender.isSelected];
}

@end
