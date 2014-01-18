//
//  MenuTableCell.m
//  Scavengers
//
//  Created by David Cottrell on 1/18/2014.
//  Copyright (c) 2014 David Cottrell. All rights reserved.
//

#import "MenuTableCell.h"

@implementation MenuTableCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"MenuTableCell"
                                      owner:self
                                    options:nil];
        [self addSubview:self.content];
    }
    return self;
}

@end
