//
//  Helper.swift
//  Cryato
//
//  Created by John Melody Me on 17/02/2023.
//

import Foundation

struct Helper {
    public static func currentDate() throws -> String {
        return String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
    }
}
