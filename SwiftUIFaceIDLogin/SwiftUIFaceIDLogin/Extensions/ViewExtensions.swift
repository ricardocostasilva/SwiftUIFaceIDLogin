//
//  ViewExtensions.swift
//  SwiftUIFaceIDLogin
//
//  Created by ricardo silva on 26/04/2022.
//

import Foundation
import SwiftUI

extension View {
    
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
