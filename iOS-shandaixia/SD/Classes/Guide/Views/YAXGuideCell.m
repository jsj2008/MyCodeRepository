#import "YAXGuideCell.h"

@interface YAXGuideCell ()

@property (nonatomic,weak) UIImageView *backgroundImageView;




@end

@implementation YAXGuideCell

#pragma mark - 创建子控件
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        //添加背景图
        UIImageView *backgroundImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:backgroundImageView];
        
        self.backgroundImageView = backgroundImageView;
        
        //添加进入主界面按钮
        UIButton *enterButton = [[UIButton alloc] init];
        
        [enterButton setImage:[UIImage imageNamed:@"guide_experience"] forState:UIControlStateNormal];
        
//        [enterButton setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
        
        [self.contentView addSubview:enterButton];
        
        self.enterButton = enterButton;
        
        
        
    }
    return self;
}

#pragma mark - 设置数据
- (void)setBackgroundImage:(UIImage *)backgroundImage{

    _backgroundImage = backgroundImage;
    
    self.backgroundImageView.image = self.backgroundImage;
    
}

#pragma mark - 布局子控件
- (void)layoutSubviews{

    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
    
    [self.enterButton sizeToFit];
    
    self.enterButton.centerX = self.width/2;
    
    self.enterButton.y = self.height - self.enterButton.height - 124 * SCALE;
    
    
    
}


@end









