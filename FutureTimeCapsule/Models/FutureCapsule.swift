import Foundation

struct FutureCapsule: Identifiable, Codable {
    let id: UUID
    let title: String
    let message: String
    let imageData: Data?
    let dreamType: DreamType
    let aboutType: AboutType
    let openDate: Date
    let createdDate: Date
    var openedDate: Date?
    var fulfillmentStatus: FulfillmentStatus?
    
    init(
        id: UUID = UUID(),
        title: String,
        message: String,
        imageData: Data?,
        dreamType: DreamType,
        aboutType: AboutType,
        openDate: Date,
        createdDate: Date = Date(),
        openedDate: Date? = nil,
        fulfillmentStatus: FulfillmentStatus? = nil
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.imageData = imageData
        self.dreamType = dreamType
        self.aboutType = aboutType
        self.openDate = openDate
        self.createdDate = createdDate
        self.openedDate = openedDate
        self.fulfillmentStatus = fulfillmentStatus
    }
    
    var isReadyToOpen: Bool {
        guard openedDate == nil else { return false }
        return Calendar.current.isDateInToday(openDate) || openDate < Date()
    }
    
    var isSealed: Bool {
        return openedDate == nil
    }
}
