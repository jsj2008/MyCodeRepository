



#import "SDBankCardDetailCell.h"
#import "SDBankCard.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define BankCardFont (28 * SCALE)

@interface SDBankCardDetailCell ()



@property (nonatomic, weak) UIImageView *headBackView;

@property (nonatomic, weak) UILabel *cardNameLabel;

@property (nonatomic, weak) UILabel *cardTypeLabel;

@property (nonatomic, weak) UIImageView *bankIconImageView;

@property (nonatomic, weak) UILabel *cardNumberLabel;

@property (nonatomic, weak) UIImageView *hideImageView1;

@property (nonatomic, weak) UIImageView *hideImageView2;

@property (nonatomic, weak) UIImageView *hideImageView3;

@property (nonatomic, strong) NSArray *backImageArray;


@end

@implementation SDBankCardDetailCell

#pragma mark - 创建cell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    
    
    static NSString *ID = @"SDBankCardDetailCell";
    SDBankCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        
        cell = [[SDBankCardDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = FDColor(243, 245, 249);
        //
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDColor(243, 245, 249)]];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backImageArray = @[@"bg_big_card1",@"bg_big_card2",@"bg_big_card3"];
        
        UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:SDWhiteColor]];
        self.backView = backView;
        [self.contentView addSubview:backView];
        
        
        //        UIImageView *headBackView = [[UIImageView alloc] initWithImage:[UIImage imageWithBgColor:FDRandomColor]];;
        //        self.headBackView = headBackView;
        //        [backView addSubview:headBackView];
        
        
        UILabel *cardNameLabel = [UILabel labelWithText:@"" textColor:SDWhiteColor font:BankCardFont textAliment:NSTextAlignmentLeft];
        self.cardNameLabel = cardNameLabel;
        [backView addSubview:cardNameLabel];
        
        UILabel *cardTypeLabel = [UILabel labelWithText:@"" textColor:SDWhiteColor font:BankCardFont textAliment:NSTextAlignmentLeft];
        self.cardTypeLabel = cardTypeLabel;
        [backView addSubview:cardTypeLabel];
        
        UIImageView *bankIconImageView = [[UIImageView alloc] init];
        self.bankIconImageView = bankIconImageView;
        [backView addSubview:bankIconImageView];
        
        UILabel *cardNumberLabel = [UILabel labelWithText:@"" textColor:SDWhiteColor font:BankCardFont textAliment:NSTextAlignmentLeft];
        self.cardNumberLabel = cardNumberLabel;
        [backView addSubview:cardNumberLabel];
        
        UIImageView *hideImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spot_white"]];
        self.hideImageView1 = hideImageView1;
        [backView addSubview:hideImageView1];
        
        UIImageView *hideImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spot_white"]];
        self.hideImageView2 = hideImageView2;
        [backView addSubview:hideImageView2];
        
        UIImageView *hideImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spot_white"]];
        self.hideImageView3 = hideImageView3;
        [backView addSubview:hideImageView3];
        
        
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat backX = 0;
    CGFloat backY = 0 * SCALE;
    CGFloat backW = self.width - backX * 2;
    CGFloat backH = self.height - backY;
    
    self.backView.frame = CGRectMake(backX, backY, backW, backH);
    
    CGFloat headerX = 0;
    CGFloat headerW = backW;
    CGFloat headerH = 80 * SCALE;
    CGFloat headerY = 0;
    self.headBackView.frame = CGRectMake(headerX, headerY, headerW, headerH);
    
    CGSize cardSize = [@"中国工商银行" sizeOfMaxScreenSizeInFont:BankCardFont];
    CGFloat cardNameLabelX = 30 * SCALE;
    CGFloat cardNameLabelW = cardSize.width;
    CGFloat cardNameLabelH = cardSize.height;
    CGFloat cardNameLabelY = (headerH - cardNameLabelH)/2;
    self.cardNameLabel.frame = CGRectMake(cardNameLabelX, cardNameLabelY, cardNameLabelW, cardNameLabelH);
    
    self.cardTypeLabel.frame = self.cardNameLabel.frame;
    self.cardTypeLabel.x = CGRectGetMaxX(self.cardNameLabel.frame) + cardNameLabelX;
    
    CGFloat iconX = cardNameLabelX;
    CGFloat iconW = 45;
    CGFloat iconH = 45;
    CGFloat iconY = (backH - headerH - iconH)/2;
    self.bankIconImageView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.bankIconImageView.centerY = headerH + (backH - headerH)/2;
    
    CGSize size = [@"999999" sizeOfMaxScreenSizeInFont:BankCardFont];
    
    CGFloat numberW = size.width;
    CGFloat numberH = size.height;
    CGFloat numberX = backW - numberW - 42 * SCALE;
    CGFloat numberY = (backH - headerH - numberH)/2;
    self.cardNumberLabel.frame = CGRectMake(numberX, numberY, numberW, numberH);
    self.cardNumberLabel.centerY = headerH + (backH - headerH)/2;
    
    
    UIImageView *hide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spot_four"]];
    [hide sizeToFit];
    CGFloat width = hide.width;
    
    
    self.hideImageView1.centerY = self.cardNumberLabel.centerY;
    self.hideImageView1.width = width;
    self.hideImageView1.height = hide.height;
    self.hideImageView1.x = self.cardNumberLabel.x - 34 * SCALE - width;
    
    self.hideImageView2.frame = self.hideImageView1.frame;
    self.hideImageView2.x = self.hideImageView1.x - 34 * SCALE - width;
    
    self.hideImageView3.frame = self.hideImageView1.frame;
    self.hideImageView3.x = self.hideImageView2.x - 34 * SCALE - width;
        
}

- (void)setBankCard:(SDBankCard *)bankCard{
    
    _bankCard = bankCard;
    
    int i =  ([bankCard.cardNumber integerValue] + 1) % 3;
    
    _backView.image = [UIImage imageNamed:self.backImageArray[i]];
    
    self.cardNameLabel.text = bankCard.bankName;
    if ([bankCard.cardType isEqualToString:@"DC"]) {
        
        self.cardTypeLabel.text = @"储蓄卡";
    }else{
        
        self.cardTypeLabel.text = @"储蓄卡";
        
    }
    
    self.cardNumberLabel.text = [bankCard.cardNumber substringFromIndex:bankCard.cardNumber.length - 4];
    
    
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:bankCard.logoUrl]];
    
    
}

- (void)setImage:(UIImage *)image{

    _image = image;
    
    self.backView.image = image;
}

@end












