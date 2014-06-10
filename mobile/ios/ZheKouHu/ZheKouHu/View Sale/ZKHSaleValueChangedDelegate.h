//
//  ZKHSaleValueChangedDelegate.h
//  ZheKouHu
//
//  Created by undyliu on 14-6-10.
//  Copyright (c) 2014年 undyliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKHEntity.h"

@protocol ZKHSaleValueChangedDelegate <NSObject>

- (void) updateSale:(ZKHSaleEntity *)sale;

@end
