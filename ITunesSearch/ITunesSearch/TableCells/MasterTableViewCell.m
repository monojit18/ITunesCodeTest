//
//  MasterTableViewCell.m
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import "MasterTableViewCell.h"

@interface MasterTableViewCell ()

@end

@implementation MasterTableViewCell

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.artWorkImageView.layer.cornerRadius = 5.0;
    self.artWorkImageView.layer.borderWidth = 1.0;
    self.artWorkImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.artWorkImageView.layer.masksToBounds = YES;
    self.artWorkImageView.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    [super setSelected:selected animated:animated];

}

@end
