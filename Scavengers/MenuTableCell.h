//
//  MenuTableCell.h
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuTableCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;

@end
