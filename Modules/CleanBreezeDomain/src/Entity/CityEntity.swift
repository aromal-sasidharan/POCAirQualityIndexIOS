



public protocol AbstractAqiEntity {
    var city: String {get set}
    var aqi: Double {get set}
    var updatedOn: Date? {get set}
}


public struct AqiEntity:Decodable, AbstractAqiEntity {
    public var city: String
    public var aqi: Double
    public var updatedOn: Date?
}
