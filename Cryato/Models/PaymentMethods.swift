//
//  PaymentMethods.swift
//  Cryato
//
//  Created by John Melody Me on 14/02/2023.
//
import Foundation

public enum PaymentMethod : String, CaseIterable {
    case BIGPAY = "BigPay"
    case GRABPAY = "GrabPay"
    case WISE = "WISE"
    case BANKTRANSFER = "Bank Transfer"
    case TOUCHANDGO = "Touch & Go"
    case PAYPAL = "PayPal"
    case SKRILL = "Skrill"
}
