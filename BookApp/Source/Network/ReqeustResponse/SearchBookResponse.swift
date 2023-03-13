//
//  Books.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

typealias BookInfo = VolumeInfo
 
// MARK: - SearchBookResponse
struct SearchBookResponse: Codable {
    let kind: String
    let totalItems: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind
    let id, etag: String
    let selfLink: String
    let volumeInfo: BookInfo
    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
    let searchInfo: SearchInfo
}

// MARK: - AccessInfo
struct AccessInfo: Codable {
    let country: Country
    let viewability: Viewability
    let embeddable, publicDomain: Bool
    let textToSpeechPermission: TextToSpeechPermission
    let epub, pdf: Epub
    let webReaderLink: String
    let accessViewStatus: AccessViewStatus
    let quoteSharingAllowed: Bool
}

enum AccessViewStatus: String, Codable {
    case none = "NONE"
    case sample = "SAMPLE"
}

enum Country: String, Codable {
    case kr = "KR"
}

// MARK: - Epub
struct Epub: Codable {
    let isAvailable: Bool
    let acsTokenLink: String?
}

enum TextToSpeechPermission: String, Codable {
    case allowed = "ALLOWED"
}

enum Viewability: String, Codable {
    case noPages = "NO_PAGES"
    case partial = "PARTIAL"
}

enum Kind: String, Codable {
    case booksVolume = "books#volume"
}

// MARK: - SaleInfo
struct SaleInfo: Codable {
    let country: Country
    let saleability: Saleability
    let isEbook: Bool
    let listPrice, retailPrice: SaleInfoListPrice?
    let buyLink: String?
    let offers: [Offer]?
}

// MARK: - SaleInfoListPrice
struct SaleInfoListPrice: Codable {
    let amount: Int
    let currencyCode: CurrencyCode
}

enum CurrencyCode: String, Codable {
    case krw = "KRW"
}

// MARK: - Offer
struct Offer: Codable {
    let finskyOfferType: Int
    let listPrice, retailPrice: OfferListPrice
    let rentalDuration: RentalDuration?
}

// MARK: - OfferListPrice
struct OfferListPrice: Codable {
    let amountInMicros: Int
    let currencyCode: CurrencyCode
}

// MARK: - RentalDuration
struct RentalDuration: Codable {
    let unit: String
    let count: Int
}

enum Saleability: String, Codable {
    case forSale = "FOR_SALE"
    case forSaleAndRental = "FOR_SALE_AND_RENTAL"
    case notForSale = "NOT_FOR_SALE"
}

// MARK: - SearchInfo
struct SearchInfo: Codable {
    let textSnippet: String
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publisher, description: String?
    let readingModes: ReadingModes
    let pageCount: Int?
    let printType: PrintType
    let categories: [String]?
    let averageRating, ratingsCount: Int?
    let maturityRating: MaturityRating
    let allowAnonLogging: Bool
    let contentVersion: String
    let panelizationSummary: PanelizationSummary
    let imageLinks: ImageLinks
    let language: Language
    let previewLink: String
    let infoLink: String
    let canonicalVolumeLink: String
    let publishedDate: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let comicsContent: Bool?
    let seriesInfo: SeriesInfo?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}

// MARK: - IndustryIdentifier
struct IndustryIdentifier: Codable {
    let type: TypeEnum
    let identifier: String
}

enum TypeEnum: String, Codable {
    case isbn10 = "ISBN_10"
    case isbn13 = "ISBN_13"
    case other = "OTHER"
}

enum Language: String, Codable {
    case en = "en"
    case ko = "ko"
}

enum MaturityRating: String, Codable {
    case mature = "MATURE"
    case notMature = "NOT_MATURE"
}

// MARK: - PanelizationSummary
struct PanelizationSummary: Codable {
    let containsEpubBubbles, containsImageBubbles: Bool
}

enum PrintType: String, Codable {
    case book = "BOOK"
}

// MARK: - ReadingModes
struct ReadingModes: Codable {
    let text, image: Bool
}

// MARK: - SeriesInfo
struct SeriesInfo: Codable {
    let kind, bookDisplayNumber: String
    let volumeSeries: [VolumeSery]
}

// MARK: - VolumeSery
struct VolumeSery: Codable {
    let seriesID, seriesBookType: String
    let orderNumber: Int

    enum CodingKeys: String, CodingKey {
        case seriesID = "seriesId"
        case seriesBookType, orderNumber
    }
}
