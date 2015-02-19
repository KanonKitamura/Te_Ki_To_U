//
//  MasterViewController.h
//  Te_Ki_To_U
//
//  Created by kanon kitamura on 2015/02/19.
//  Copyright (c) 2015年 myname. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController
<UITextFieldDelegate>
{
    

UIView *orangeView;//TextFieldを乗せるだけの色付きView
    BOOL insertMode;//何回もTextFieldを乗せてしまわないためのフラグ
    UITextField *textField;
    

}
@end

