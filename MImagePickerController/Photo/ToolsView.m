//
//  ToolsView.m
//  VideoAndAudio
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ToolsView.h"

@implementation ToolsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
     
       [self addSubview:self.txtLabel];
       [self addSubview:self.determineBtn];
       [self addSubview:self.horLabel];
       [self addSubview:self.horLabelBottom];
       [self updateUI];
    }
    return self;
}

-(void)updateUI{
    
    self.txtLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *leftA=[NSLayoutConstraint constraintWithItem:self.txtLabel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0];
    
     NSLayoutConstraint *centerYA=[NSLayoutConstraint constraintWithItem:self.txtLabel attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:0.0];
    
     NSLayoutConstraint *widthA=[NSLayoutConstraint constraintWithItem:self.txtLabel attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationGreaterThanOrEqual) toItem:nil attribute:(kNilOptions) multiplier:1.0 constant:80];
    
     NSLayoutConstraint *heightA=[NSLayoutConstraint constraintWithItem:self.txtLabel attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(kNilOptions) multiplier:1.0 constant:30.0];
    [self addConstraints:@[leftA,centerYA]];
    [self.txtLabel addConstraints:@[widthA,heightA]];
    
    self.determineBtn.translatesAutoresizingMaskIntoConstraints=NO;
     NSLayoutConstraint *rightB=[NSLayoutConstraint constraintWithItem:self.determineBtn attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeRight) multiplier:1.0 constant:-10.0];
     NSLayoutConstraint *centerYB=[NSLayoutConstraint constraintWithItem:self.determineBtn attribute:(NSLayoutAttributeCenterY) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeCenterY) multiplier:1.0 constant:0.0];
     NSLayoutConstraint *widthB=[NSLayoutConstraint constraintWithItem:self.determineBtn attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(kNilOptions) multiplier:1.0 constant:60.0];
     NSLayoutConstraint *heightB=[NSLayoutConstraint constraintWithItem:self.determineBtn attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:kNilOptions multiplier:1.0 constant:35.0];
    [self addConstraints:@[rightB,centerYB]];
    [self.determineBtn addConstraints:@[widthB,heightB]];
    
    self.horLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *leftC=[NSLayoutConstraint constraintWithItem:self.horLabel attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0];
    NSLayoutConstraint *topC=[NSLayoutConstraint constraintWithItem:self.horLabel attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0.0];
    NSLayoutConstraint *widthC=[NSLayoutConstraint constraintWithItem:self.horLabel attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeWidth) multiplier:1.0 constant:0.0];
    NSLayoutConstraint *heightC=[NSLayoutConstraint constraintWithItem:self.horLabel attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:kNilOptions multiplier:1.0 constant:0.5];
    [self addConstraints:@[leftC,topC,widthC]];
    [self.horLabel addConstraint:heightC];
    
    self.horLabelBottom.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *leftD=[NSLayoutConstraint constraintWithItem:self.horLabelBottom attribute:(NSLayoutAttributeLeft) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeft) multiplier:1.0 constant:0.0];
    NSLayoutConstraint *bottomD=[NSLayoutConstraint constraintWithItem:self.horLabelBottom attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:-0.5];
    NSLayoutConstraint *widthD=[NSLayoutConstraint constraintWithItem:self.horLabelBottom attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeWidth) multiplier:1.0 constant:0.0];
    NSLayoutConstraint *heightD=[NSLayoutConstraint constraintWithItem:self.horLabelBottom attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:kNilOptions multiplier:1.0 constant:0.5];
    [self addConstraints:@[leftD,bottomD,widthD]];
    [self.horLabelBottom addConstraint:heightD];
    
    
    
}

-(UILabel *)txtLabel
{
    if (!_txtLabel) {
        
        _txtLabel=[[UILabel alloc]init];
        _txtLabel.font=[UIFont systemFontOfSize:16];
        _txtLabel.textColor=[UIColor blackColor];
        _txtLabel.text=@"选中照片的数量: 0个";
    }
    return _txtLabel;
}

-(UIButton *)determineBtn
{
    if (!_determineBtn) {
        
        _determineBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [_determineBtn setTitle:@"确定" forState:UIControlStateNormal];
        _determineBtn.backgroundColor=[UIColor orangeColor];
        _determineBtn.layer.cornerRadius=10;
        [_determineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_determineBtn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        
        
    }
    return _determineBtn;
}

-(UILabel *)horLabel
{
    if (!_horLabel) {
        
        _horLabel=[[UILabel alloc]init];
        _horLabel.backgroundColor=[UIColor colorWithRed:93/225.0 green:93/255.0 blue:93/255.0 alpha:1.0];
    }
    return _horLabel;
}
-(UILabel *)horLabelBottom
{
    if (!_horLabelBottom) {
        
        _horLabelBottom=[[UILabel alloc]init];
        _horLabelBottom.backgroundColor=[UIColor colorWithRed:143/225.0 green:143/255.0 blue:143/255.0 alpha:1.0];
    }
    return _horLabelBottom;
}

@end
