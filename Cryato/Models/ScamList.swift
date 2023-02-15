//
//  ScamList.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//

import Foundation

struct Scam : Codable, Identifiable  {
    public var id :Int?
    public var userId :String?
    public var walletId :String?
    public var paymentMethod :String?
    public var platform :String?
    public var currency :String?
    public var scamTechnique :String?
    public var reportedBy :String?
}
