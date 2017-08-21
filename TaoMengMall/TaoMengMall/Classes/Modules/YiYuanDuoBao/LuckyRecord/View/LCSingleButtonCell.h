//
//  LCSingleButtonCell.h
//  YiYuanDuoBaoDemo
//
//  Created by wzningjie on 2017/3/12.
//  Copyright © 2017年 wzningjie. All rights reserved.
//

#import <XMMegaBase/XMMegaBase.h>

typedef enum LCSingleButtonCellStyle{
    LCSingleButtonCellStyleConfirm,
    LCSingleButtonCellStyleAlter
}LCSingleButtonCellStyle;

@interface LCSingleButtonCell : BaseTableViewCell
@property (nonatomic, assign) LCSingleButtonCellStyle type;
@end
