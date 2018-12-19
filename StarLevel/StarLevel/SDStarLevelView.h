//
//  SDStarLevelView.h
//  StarLevel
//
//  Created by xialan on 2018/12/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SDStarLevelStyle){
    
    SDStarLevelStyleAll = 0, //整颗星
    SDStarLevelStyleHalf,    //半颗星
    SDStarLevelStyleCustom   //任意小数的星
    
};

typedef void(^CountCompleteBackBlock)(CGFloat currentCount);

@interface SDStarLevelView : UIView

/** 星星的总数 默认是5 */
@property (nonatomic, assign) NSInteger starCounts;

/** 当前选中的数量 默认是0 */
@property (nonatomic, assign) CGFloat selectStarCounts;

/** 选中时是否有动画 默认是yes */
@property (nonatomic, assign) BOOL isAnimation;

/** 是否支持点击选择 默认是yes */
@property (nonatomic, assign) BOOL isSupportTap;

/** 回调星星数量 */
@property (nonatomic, copy) CountCompleteBackBlock callback;

/** 设置样式 默认是半颗星样式*/
@property (nonatomic, assign) SDStarLevelStyle style;

/** 设置完属性后,需要调用此方法 */
-(void)updateUI;

-(instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)starCount currentStar:(CGFloat)currentStar style:(SDStarLevelStyle)style isAnimation:(BOOL)isAnimation complete:(CountCompleteBackBlock)complete;

@end


