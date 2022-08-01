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
    let cashCurrencies: [Currency] = [.rur, .cny, .jpy, .eur, .usd]
    
    let cashImages = ["rublesign.circle", "yensign.circle", "yensign.circle", "eurosign.circle", "dollarsign.circle"]
    
    let cashQuantities = [57435.32, 7015.54, 15063.73, 1, 1]
    
// mock data for crypto
    let cryptoNames = ["Bitcoin", "Ether", "Solana", "ThetherUSD", "Dogecoin"]
    
    let cryptoImages = ["bitcoinsign.circle", "e.circle", "s.circle", "dollarsign.circle", "d.circle"]
    
    let cryptoPrices = [20253.54, 1343.57, 38.35, 0.9999, 0.063]
    
    let cryptoQuantities = [0.05, 1.4632, 1.846, 15.19, 1000.43]
    
    let cryptoTickers = ["BTC", "ETH", "SOL", "TUSD", "DOGE"]
    
// mock data for metalls
    let metallTypes: [TypeOfMetall] = [.gold, .silver, .palladium]
    let metalImages = ["g.circle", "s.circle", "p.circle"]
    let metalPrices = [39.53, 0.53, 100]
    let metalQantities = [100, 367.57, 1]
    
    private init() {}
}

class TestsDataStore {
    static let shared = TestsDataStore()
    
    let questions = ["Я планирую вывести капитал из инвестиционного портфеля через:",
                     "Я планирую инвестировать следующую долю свободных денежных средств:",
                     "Мои знания инвестиционных инструментов:",
                     "Представьте, что в течение последних трех месяцев рынки акций упали на 25%. Одна из акций в Вашем портфеле потеряла 20% своей стоимости. Какие Ваши действия?"
    ]
    
    let answers = [
        ["Менее чем через 3 года": 3, "3-5 лет": 2,
         "6-10 лет": 1, "11 лет и более": 0],
        ["до 10%": 0, "10-30%": 1, "30-40%": 2, "более 60%": 3],
        ["Отсутствуют": 1, "Неглубокие": 2, "Хорошие": 3, "Обширные": 4],
        ["Продам все акции": 1, "Продам часть акций": 2,
         "Ничего": 3, "Докуплю акции": 4],
    ]
    
    private init() {}
}
