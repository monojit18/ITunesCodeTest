//
//  MasterTableViewCell.h
//  ITunesSearch
//
//  Created by Monojit Datta@Cognizant on 11/23/16.
//  Copyright © 2016 Monojit Datta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *artWorkImageView;

@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@end
