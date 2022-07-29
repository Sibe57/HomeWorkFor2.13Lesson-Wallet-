//
//  DataStore.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import Foundation


//let typeOfFunds: TypeOfFunds
//let image: String
//let name: String
//let currency: Currency
//var price: Double
//var quantity: Int

class DataStore {
    
    static let shared = DataStore()
    
//    mock data for stocks
    let stockNames = ["Apple", "Google", "Amazon", "Netflix", "Intel",
                      "Яндекс", "Сегежа", "ГК Самолет", "Татнефть", "Лукоил"]
    
    let stockImages = ["applelogo", "g.circle", "a.circle", "n.circle", "i.circle",
                  "y.circle", "s.circle", "s.circle", "t.circle", "l.circle"]
    
    let stockCurrencies: [Currency] = [.usd, .usd, .usd, .usd, .usd, .rur, .rur,
                                       .rur, .rur, .rur]
    
    let stockIssuers = ["Apple Inc.", "Alphabet Inc.", "Amazon.com Inc.",
                       "Netflix Inc.", "Intel Corporation","ООО Яндекс",
                       "ПАО Сегежа", "ПАО ГК Самолет", "ПАО Татнефть", "ПАО Лукоил"]
    
    let stockPrices = [150.17, 2318.43, 3245.96, 210.22, 39.54, 1700.43,
                       8.57, 3800.43, 800.12, 1400.91]
    
    let stockQuantities: [Double] = [1, 1, 1, 3, 1, 1, 2000, 4, 3, 8]
    
//    mock data for bonds
    let bondNames = ["Самолет ГК-1-об", "РОСНАНО-8-об", "ОФЗ-29017-ПК",
                      "ОФЗ-29018-ПК", "РУСАЛ Братск-001Р-01"]
    
    let bondImages = ["s.circle", "r.circle", "o.circle",
                      "o.circle", "r.circle", "g.circle"]
    
    let bondCurrencies: [Currency] = [.rur, .rur, .rur, .rur, .rur, .usd]
    
    let bondYelds = [13.35, 15.62, 21.47, 18.4, 17.64, 4.21]
    
    let bondIssuers = ["ПАО ГК Самолет", "ООО Роснано", "МинФинРФ", "МинФинФР",
                        "ПАО Русал", "ОАО ГТЛК"]
    
    let bondPrices = [874.34, 956.23, 994.34, 1003.74, 1030.74, 850]
    
    let bondQuantities: [Double] = [91, 4, 5, 7, 12, 1]
    
//    mock data for cash
    let cashCurrencies: [Currency] = [.rur, .cny, .jpy]
    
    let cashImages = ["Рубль", "Юань", "Йена"]
    
    let cashQuantities = [57435.32, 7015.54, 15063.73]
    
// mock data for crypto
    let cryptoNames = ["Bitcoin", "Ether", "Solana", "ThetherUSD", "Dogecoin"]
    
    let cryptoImages = ["bitcoinsign.circle", "e.circle", "s.circle", "dollarsign.circle", "d.circle"]
    
    let cryptoPrices = [20253.54, 1343.57, 38.35, 0.9999, 0.063]
    
    let cryptoQuantities = [0.05, 1.4632, 1.846, 15.19, 1000.43]
    
    let cryptoTickers = ["BTC", "ETH", "SOL", "TUSD", "DOGE"]
    
// mock data for metalls
    let metallTypes: [TypeOfMetall] = [.gold, .silver]
    let metalImages = [TypeOfMetall.gold.rawValue, TypeOfMetall.silver.rawValue]
    let metalPrices = [39.53, 0.53]
    let metalQantities = [100, 367.57]
    
    private init() {}
}
