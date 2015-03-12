//
//  Popcorn.swift
//  PopMenu
//
//  Created by Scott Krulcik on 3/10/15.
//  Copyright (c) 2015 Scott Krulcik. All rights reserved.
//

import Foundation
import UIKit

/* A Popcorn is a data object to represent a button of the pop menu
- A popcorn object is created once, then added to the menu, where it is
maintained and used to draw draw the buttons, and send commands
- The delegate is used so that different view controllers can own different
pieces of Popcorn in the same menu
- Color properties are used for rendering. Position and size attributes are
purposely left up to the popper that manages the Popcorn
*/
struct Popcorn {
    /* Background for the radial button representative of this piece */
    var backgroundColor:UIColor = UIColor.redColor()
}


