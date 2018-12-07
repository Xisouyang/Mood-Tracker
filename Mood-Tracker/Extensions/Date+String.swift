    //
//  Date+String.swift
//  Mood-Tracker
//
//  Created by Stephen Ouyang on 12/7/18.
//  Copyright © 2018 Stephen Ouyang. All rights reserved.
//

import Foundation

extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .short)
    }
}
