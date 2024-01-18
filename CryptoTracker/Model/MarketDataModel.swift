//
//  MarketData.swift
//  CryptoTracker
//
//  Created by Marvis Ighedosa on 12/01/2024.
//

import Foundation

// MARK: - CoinData
struct GlobalData: Codable{
    var data: MarketDataModel?
}


struct MarketDataModel: Codable {
    //JSON Data
    /*
     url = https://api.coingecko.com/api/v3/global
     Json Respons  = {
     "data": {
       "active_cryptocurrencies": 12179,
       "upcoming_icos": 0,
       "ongoing_icos": 49,
       "ended_icos": 3376,
       "markets": 974,
       "total_market_cap": {
         "btc": 40206600.05869277,
         "eth": 711069037.495588,
         "ltc": 25412788200.8873,
         "bch": 6368739329.185324,
         "bnb": 5997700206.110615,
         "eos": 2348318458752.9365,
         "xrp": 3103205750388.2593,
         "xlm": 15007868356960.393,
         "link": 125155441363.76224,
         "dot": 229037585559.45892,
         "yfi": 222648017.3922376,
         "usd": 1844741484707.4717,
         "aed": 6775366525033.616,
         "ars": 1504287525924140.8,
         "aud": 2755813185467.3735,
         "bdt": 202384568295330.97,
         "bhd": 695281220844.7596,
         "bmd": 1844741484707.4717,
         "brl": 8983891030525.37,
         "cad": 2468614607420.6904,
         "chf": 1574176940628.3965,
         "clp": 1686038374778086.2,
         "cny": 13114267214785.393,
         "czk": 41542840339018.25,
         "dkk": 12544242096010.799,
         "eur": 1682321220686.4019,
         "gbp": 1446017215461.3132,
         "gel": 4948517187986.286,
         "hkd": 14422650112814.182,
         "huf": 638912353685655.9,
         "idr": 28703589346810156,
         "ils": 6896162042193.737,
         "inr": 153002469501184.5,
         "jpy": 267805733188695.16,
         "krw": 2425573099099493.5,
         "kwd": 566925953080.2979,
         "lkr": 595049933559026.1,
         "mmk": 3872474700231251,
         "mxn": 31192054900052.254,
         "myr": 8572513679435.606,
         "ngn": 1754588407548403,
         "nok": 19020159114797.77,
         "nzd": 2957738588383.452,
         "php": 103249717868964.38,
         "pkr": 518349004620346,
         "pln": 7321109311644.983,
         "rub": 162891112148143.1,
         "sar": 6918180876555.213,
         "sek": 18933513452002.547,
         "sgd": 2455550148225.992,
         "thb": 64713531283538.08,
         "try": 55509562593887.09,
         "twd": 57431877302768,
         "uah": 69860454107687.55,
         "vef": 184713964863.75906,
         "vnd": 45203183723977460,
         "zar": 34385988653913.2,
         "xdr": 1381847882915.7637,
         "xag": 80676356061.93434,
         "xau": 905749621.5765209,
         "bits": 40206600058692.766,
         "sats": 4020660005869277
       },
       "total_volume": {
         "btc": 3032643.4158510426,
         "eth": 53633454.00080179,
         "ltc": 1916797856.6537774,
         "bch": 480371763.9823091,
         "bnb": 452385578.82929754,
         "eos": 177125459547.99905,
         "xrp": 234063971417.83157,
         "xlm": 1131991093309.4429,
         "link": 9440037821.046368,
         "dot": 17275505136.35487,
         "yfi": 16793562.325866826,
         "usd": 139142407201.27386,
         "aed": 511042233168.8397,
         "ars": 113463154168251.81,
         "aud": 207861363557.80295,
         "bdt": 15265161133115.871,
         "bhd": 52442634131.75279,
         "bmd": 139142407201.27386,
         "brl": 677623523070.2024,
         "cad": 186198977892.67258,
         "chf": 118734668621.87744,
         "clp": 127171985909748.16,
         "cny": 989163372793.8541,
         "czk": 3133431353209.797,
         "dkk": 946168368968.6616,
         "eur": 126891613959.23766,
         "gbp": 109068028166.38326,
         "gel": 373249368175.00824,
         "hkd": 1087850125101.3588,
         "huf": 48190927357255.73,
         "idr": 2165011493556417,
         "ils": 520153417134.7857,
         "inr": 11540441894225.74,
         "jpy": 20199651109426.91,
         "krw": 182952507247852.3,
         "kwd": 42761244581.09531,
         "lkr": 44882538202088.73,
         "mmk": 292087241536529.7,
         "mxn": 2352707758960.489,
         "myr": 646594766264.3185,
         "ngn": 132342475462055.58,
         "nok": 1434624171746.1458,
         "nzd": 223091891450.0543,
         "php": 7787765606311.079,
         "pkr": 39097255019825.3,
         "pln": 552205705488.0402,
         "rub": 12286307671765.396,
         "sar": 521814220907.1406,
         "sek": 1428088792022.3093,
         "sgd": 185213571364.87317,
         "thb": 4881115644620.686,
         "try": 4186892432371.3696,
         "twd": 4331885916937.8643,
         "uah": 5269330056974.999,
         "vef": 13932329233.063545,
         "vnd": 3409518270530489.5,
         "zar": 2593615026801.3726,
         "xdr": 104227959531.88695,
         "xag": 6085135765.494373,
         "xau": 68317530.51175341,
         "bits": 3032643415851.0425,
         "sats": 303264341585104.25
       },
       "market_cap_percentage": {
         "btc": 48.739104759681176,
         "eth": 16.898685628862903,
         "usdt": 5.1424543348178595,
         "bnb": 2.5639598999585838,
         "sol": 2.309480740527714,
         "xrp": 1.7486499219958658,
         "usdc": 1.3674498029009685,
         "steth": 1.3130597396082058,
         "ada": 1.0973022204371505,
         "avax": 0.7673513434514498
       },
       "market_cap_change_percentage_24h_usd": 0.4627948706059013,
       "updated_at": 1705046011
     }
   }
     */
     
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    var marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var totalValue: String {
        if let item = totalVolume.first(where: { $0.key == "btc"}) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}




