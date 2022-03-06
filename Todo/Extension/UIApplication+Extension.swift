//
//  UIApplication+Extension.swift
//  Todo
//
//  Created by 椎原健 on 2022/03/06.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
       )
    }
}
