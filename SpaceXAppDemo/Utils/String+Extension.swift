//
//  String+Extension.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: self) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE, d MMMM yyyy"
            return dayFormatter.string(from: date)
        }
        return ""
    }
}
