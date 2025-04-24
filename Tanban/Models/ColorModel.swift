//
//  Color.swift
//  Tanban
//
//  Created by Luca on 24/04/2025.
//

import SwiftData
import SwiftUI

@Model
final class ColorRGB {
    var red: Double
    var green: Double
    var blue: Double
    var alpha: Double
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    init(red: Double = 0.0, green: Double = 0.0, blue: Double = 0.0, alpha: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

func colorGray() -> ColorRGB {
    return ColorRGB(red: 0.557, green: 0.557, blue: 0.576)
}

func colorBlue() -> ColorRGB {
    return ColorRGB(red: 0.0, green: 0.478, blue: 1.0)
}

func colorGreen() -> ColorRGB {
    return ColorRGB(red: 0.188, green: 0.820, blue: 0.345)
}
