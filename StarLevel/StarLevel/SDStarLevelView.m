//
//  SDStarLevelView.m
//  StarLevel
//
//  Created by xialan on 2018/12/19.
//  Copyright © 2018 HARAM. All rights reserved.
//

#import "SDStarLevelView.h"

@interface SDStarLevelView()

/** 背景 */
@property (nonatomic, strong) UIView *backgroundView;
/** 选择view */
@property (nonatomic, strong) UIView *foreView;
/** 星星宽度 */
@property (nonatomic, assign) CGFloat starWidth;

@end

@implementation SDStarLevelView

-(instancetype)initWithFrame:(CGRect)frame starCount:(NSInteger)starCount currentStar:(CGFloat)currentStar style:(SDStarLevelStyle)style isAnimation:(BOOL)isAnimation complete:(CountCompleteBackBlock)complete{
    if (self = [super initWithFrame:frame]) {
        
        //设置默认值
        self.starCounts = 5;
        self.selectStarCounts = 0;
        self.isAnimation = YES;
        self.isSupportTap = YES;
        self.style = SDStarLevelStyleHalf;

        
        self.callback = complete;
        self.starCounts = starCount;
        self.selectStarCounts = currentStar;
        self.style = style;
        self.isAnimation = isAnimation;
        
        [self setupUI];
    }
    return self;
}

-(void)setSelectStarCounts:(CGFloat)selectStarCounts{
    _selectStarCounts = selectStarCounts;
    
    if (selectStarCounts < 0) {
        selectStarCounts = 0;
    }else if(selectStarCounts > (CGFloat)self.starCounts){
        selectStarCounts = (CGFloat)self.starCounts;
    }

    if (self.callback) {
        self.callback(selectStarCounts);
    }
    
    [self layoutSubviews];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupUI];
    
    CGFloat animationTimeInterval = self.isAnimation ? 0.25 : 0;
    
    [UIView animateWithDuration:animationTimeInterval animations:^{
        self.foreView.frame = CGRectMake(0, 0, self.starWidth*(CGFloat)self.selectStarCounts, self.bounds.size.height);
    }];
    
}

#pragma mark - 外部调用 刷新界面
-(void)updateUI{
    [self setupUI];
}

#pragma mark - 初始化
-(void)setupUI{
    [self clearAll];
    
    
    //星星的宽度
    _starWidth = self.bounds.size.width / (CGFloat)self.starCounts;
    
    //背景
    self.backgroundView = [self creatStarView:[UIImage imageNamed:@"star_bg"]];
    
    //选择view
    self.foreView = [self creatStarView:[UIImage imageNamed:@"star_fore"]];
    
    self.foreView.frame = CGRectMake(0, 0, _starWidth*(CGFloat)_selectStarCounts, self.bounds.size.height);
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.foreView];
    
    [self setupTap];
    
}


#pragma mark - 添加手势
-(void)setupTap{
    if (_isSupportTap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStar:)];
        [self addGestureRecognizer:tap];
    }
    
}
#pragma mark - 点击事件
-(void)tapStar:(UITapGestureRecognizer *)tap{
    CGPoint tapPoint = [tap locationInView:self];
    CGFloat offset = tapPoint.x;
    CGFloat selectCount = offset / _starWidth;
    
    switch (self.style) {
        case SDStarLevelStyleAll:
            
            self.selectStarCounts = ceilf((CGFloat)selectCount);
            
            break;
            
        case SDStarLevelStyleHalf:
            

            self.selectStarCounts = roundf((CGFloat)selectCount) > (CGFloat)selectCount ? ceilf((CGFloat)selectCount) : ceilf((CGFloat)selectCount)-0.5;
            
            break;
            
        case SDStarLevelStyleCustom:
            
            self.selectStarCounts = (CGFloat)selectCount;
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 创建StarView
-(UIView *)creatStarView:(UIImage *)image{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    
    for (NSInteger i = 0; i < self.starCounts; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake((CGFloat)i * _starWidth, 0, _starWidth, self.bounds.size.height);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = image;
        [view addSubview:imgView];
    }
    
    return view;
    
}


#pragma mark - 清除
-(void)clearAll{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    for (UIGestureRecognizer *tap in self.gestureRecognizers) {
        [self removeGestureRecognizer:tap];
    }
}

@end
