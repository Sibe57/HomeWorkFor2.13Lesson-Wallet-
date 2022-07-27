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
//    mock data for stocks
    let stockNames = ["Apple", "Google", "Amazon", "Netflix", "Intel",
                      "Яндекс", "Сегежа", "ГК Самолет", "Татнефть", "Лукоил"]
    
    let stockImages = ["Apple", "Google", "Amazon", "Netflix", "Intel",
                  "Яндекс", "Сегежа", "ГК Самолет", "Татнефть", "Лукоил"]
    
    let stockCurrencies: [Currency] = [.usd, .usd, .usd, .usd, .usd, .rur, .rur,
                                       .rur, .rur, .rur]
    
    let stockIssuers = ["Apple Inc.", "Alphabet Inc.", "Amazon.com Inc.",
                       "Netflix Inc.", "Intel Corporation","ООО Яндекс",
                       "ПАО Сегежа", "ПАО ГК Самолет", "ПАО Татнефть", "ПАО Лукоил"]
    
    let stockPrices = [150.17, 2318.43, 3245.96, 210.22, 39.54, 1700.43,
                       8.57, 3800.43, 800.12, 1400.91]
    
    let stockQuantity: Double = [5, 1, 1, 3, 10, 19, 2000, 4, 18, 8]
    
//    mock data for bonds
    let bondsNames = ["Самолет ГК-1-об", "РОСНАНО-8-об", "ОФЗ-29017-ПК",
                      "ОФЗ-29018-ПК", "РУСАЛ Братск-001Р-01"]
    
    let bondsImage = ["Самолет ГК-1-об", "РОСНАНО-8-об", "ОФЗ-29017-ПК",
                      "ОФЗ-29018-ПК", "РУСАЛ Братск-001Р-01", "GTLK"]
    
    let bondsCurrencies: [Currency] = [.rur, .rur, .rur, .rur, .rur, .usd]
    
    let bondsYelds = [13.35, 15.62, 21.47, 18.4, 17.64, 4.21]
    
    let bondsIssuers = ["ПАО ГК Самолет", "ООО Роснано", "МинФинРФ", "МинФинФР",
                        "ПАО Русал", "ОАО ГТЛК"]
    
    let bondsPrices = [874.34, 956.23, 994.34, 1003.74, 1030.74, 850]
    
    let bondsQuantity: Double = [9, 4, 5, 7, 12, 1]
}
