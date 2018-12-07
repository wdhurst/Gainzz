//
//  Lift.swift
//  Gainzz
//
//  Created by Wyatt Hurst on 11/19/18.
//  Copyright © 2018 Wyatt Hurst. All rights reserved.
//

import UIKit

class Lift: NSObject {
    var Name: String?
    var Reps: String?
    var Sets: String?
    var Weight: String?
    var ID: String?
    
    init(Name: String?, Reps: String?, Sets: String?, Weight: String?, ID: String?) {
        self.Name = Name
        self.Reps = Reps
        self.Sets = Sets
        self.Weight = Weight
        self.ID = ID
    }
    
}
