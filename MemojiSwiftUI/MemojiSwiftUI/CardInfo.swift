//
//  User.swift
//  MemojiSwiftUI
//
//  Created by wahaj on 03/07/2022.
//

import Foundation
import SwiftUI

class CardInfo: ObservableObject {
  
    @Published var Memoji: UIImage = UIImage(named: "image")!
    @Published var BgColor: Color = Color(.black)
    @Published var TextColor: Color = Color(.white)
    
    @Published var fullName: String = ""
    @Published var Nationality: String = ""
    @Published var email: String = ""
    @Published var phoneNo: String = ""
    @Published var interset: String = ""

}

