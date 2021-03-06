//
//	Copyright (c) 2008-2011, AppReviews
//	http://github.com/gambcl/AppReviews
//	http://www.perculasoft.com/appreviews
//	All rights reserved.
//
//	This software is released under the terms of the BSD License.
//	http://www.opensource.org/licenses/bsd-license.php
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//	* Redistributions of source code must retain the above copyright notice, this
//	  list of conditions and the following disclaimer.
//	* Redistributions in binary form must reproduce the above copyright notice,
//	  this list of conditions and the following disclaimer
//	  in the documentation and/or other materials provided with the distribution.
//	* Neither the name of AppReviews nor the names of its contributors may be used
//	  to endorse or promote products derived from this software without specific
//	  prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//	OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "ARAppStoreReviewsSummaryTableCell.h"
#import "PSRatingView.h"
#import "UIColor+MoreColors.h"
#import "AppReviewsAppDelegate.h"


static UIColor *sLabelColor = nil;


@implementation ARAppStoreReviewsSummaryTableCell

@synthesize ratingsLabel, ratingsValue, ratingsView, reviewsLabel, reviewsValue, averageRating, ratingsCount, reviewsCount;

+ (void)initialize
{
	sLabelColor = [[UIColor tableCellTextBlue] retain];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
#define TITLE_FONT_SIZE 24.0
#define DETAIL_FONT_SIZE 14.0
    if (self = [super initWithStyle:style reuseIdentifier:(NSString *)reuseIdentifier])
	{
        // Initialization code
		self.clearsContextBeforeDrawing = YES;
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		ratingsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		ratingsLabel.backgroundColor = [UIColor clearColor];
		ratingsLabel.opaque = NO;
		ratingsLabel.textColor = sLabelColor;
		ratingsLabel.highlightedTextColor = [UIColor whiteColor];
		ratingsLabel.font = [UIFont boldSystemFontOfSize:DETAIL_FONT_SIZE];
		ratingsLabel.textAlignment = UITextAlignmentLeft;
		ratingsLabel.lineBreakMode = UILineBreakModeTailTruncation;
		ratingsLabel.numberOfLines = 1;
		ratingsLabel.text = @"Ratings:";
		[self.contentView addSubview:ratingsLabel];

		ratingsView = [[PSRatingView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:ratingsView];

		ratingsValue = [[UILabel alloc] initWithFrame:CGRectZero];
		ratingsValue.backgroundColor = [UIColor clearColor];
		ratingsValue.opaque = NO;
		ratingsValue.textColor = [UIColor blackColor];
		ratingsValue.highlightedTextColor = [UIColor whiteColor];
		ratingsValue.font = [UIFont systemFontOfSize:DETAIL_FONT_SIZE];
		ratingsValue.textAlignment = UITextAlignmentLeft;
		ratingsValue.lineBreakMode = UILineBreakModeTailTruncation;
		ratingsValue.numberOfLines = 1;
		[self.contentView addSubview:ratingsValue];

		reviewsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		reviewsLabel.backgroundColor = [UIColor clearColor];
		reviewsLabel.opaque = NO;
		reviewsLabel.textColor = sLabelColor;
		reviewsLabel.highlightedTextColor = [UIColor whiteColor];
		reviewsLabel.font = [UIFont boldSystemFontOfSize:DETAIL_FONT_SIZE];
		reviewsLabel.textAlignment = UITextAlignmentLeft;
		reviewsLabel.lineBreakMode = UILineBreakModeTailTruncation;
		reviewsLabel.numberOfLines = 1;
		reviewsLabel.text = @"Reviews:";
		[self.contentView addSubview:reviewsLabel];

		reviewsValue = [[UILabel alloc] initWithFrame:CGRectZero];
		reviewsValue.backgroundColor = [UIColor clearColor];
		reviewsValue.opaque = NO;
		reviewsValue.textColor = [UIColor blackColor];
		reviewsValue.highlightedTextColor = [UIColor whiteColor];
		reviewsValue.font = [UIFont systemFontOfSize:DETAIL_FONT_SIZE];
		reviewsValue.textAlignment = UITextAlignmentLeft;
		reviewsValue.lineBreakMode = UILineBreakModeTailTruncation;
		reviewsValue.numberOfLines = 1;
		[self.contentView addSubview:reviewsValue];
    }
    return self;
}

- (void)dealloc
{
	[ratingsLabel release];
	[ratingsValue release];
	[ratingsView release];
	[reviewsLabel release];
	[reviewsValue release];
    [super dealloc];
}

- (void)layoutSubviews
{
#define MARGIN_X	7
#define MARGIN_Y	1
#define INNER_MARGIN_X	4
#define INNER_MARGIN_Y	0
    [super layoutSubviews];

    CGRect contentRect = self.contentView.bounds;
	CGFloat boundsX = contentRect.origin.x;
	CGFloat boundsY = contentRect.origin.y;
	CGRect frame;
	CGFloat posX;
	CGFloat posY;

	// Rating label.
	posX = boundsX + MARGIN_X;
	posY = boundsY + MARGIN_Y;
	CGSize itemSize = [ratingsLabel.text sizeWithFont:ratingsLabel.font constrainedToSize:CGSizeMake(contentRect.size.width-(2*MARGIN_X),CGFLOAT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
	frame = CGRectMake(posX, posY, itemSize.width, itemSize.height);
	ratingsLabel.frame = frame;
	// Rating view.
	posX += (itemSize.width + INNER_MARGIN_X);
	if (ratingsCount > 0)
	{
		CGFloat realRatingWidth = (ratingsView.rating * kStarWidth) + ((ceilf(ratingsView.rating)-1.0) * kStarMargin);
		itemSize = CGSizeMake(realRatingWidth, kRatingHeight);
	}
	else
	{
		itemSize = CGSizeZero;
		posX -= MARGIN_X;
	}
	frame = CGRectMake(posX, posY, kRatingWidth, kRatingHeight);
	ratingsView.frame = frame;
	// Rating value.
	posX += (itemSize.width + INNER_MARGIN_X);
	itemSize = [ratingsValue.text sizeWithFont:ratingsValue.font constrainedToSize:CGSizeMake(contentRect.size.width-(2*MARGIN_X),CGFLOAT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
	frame = CGRectMake(posX, posY, itemSize.width, itemSize.height);
	ratingsValue.frame = frame;

	// Reviews label.
	posX = boundsX + MARGIN_X;
	posY += (itemSize.height + INNER_MARGIN_Y);
	itemSize = [reviewsLabel.text sizeWithFont:reviewsLabel.font constrainedToSize:CGSizeMake(contentRect.size.width-(2*MARGIN_X),CGFLOAT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
	frame = CGRectMake(posX, posY, itemSize.width, itemSize.height);
	reviewsLabel.frame = frame;
	// Reviews value.
	posX += (itemSize.width + INNER_MARGIN_X);
	itemSize = [reviewsValue.text sizeWithFont:reviewsValue.font constrainedToSize:CGSizeMake(contentRect.size.width-(2*MARGIN_X),CGFLOAT_MAX) lineBreakMode:UILineBreakModeTailTruncation];
	frame = CGRectMake(posX, posY, itemSize.width, itemSize.height);
	reviewsValue.frame = frame;
}

- (void)setAverageRating:(double)rating
{
	averageRating = rating;
	ratingsView.rating = averageRating;
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

- (void)setRatingsCount:(NSUInteger)count
{
	ratingsCount = count;
	if (ratingsCount > 0)
		ratingsValue.text = [NSString stringWithFormat:@"in %d rating%@", ratingsCount, (ratingsCount==1?@"":@"s")];
	else
		ratingsValue.text = @"No ratings";
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

- (void)setReviewsCount:(NSUInteger)count
{
	reviewsCount = count;
	if (reviewsCount > 0)
		reviewsValue.text = [NSString stringWithFormat:@"%d review%@", reviewsCount, (reviewsCount==1?@"":@"s")];
	else
		reviewsValue.text = @"No reviews";
	[self setNeedsLayout];
	[self setNeedsDisplay];
}

@end
