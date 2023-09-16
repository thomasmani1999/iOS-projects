import Foundation
struct Ratings : Codable {
	let source : String?
	let value : String?

	enum CodingKeys: String, CodingKey {

		case source = "Source"
		case value = "Value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}
    
    //To get rating value out of 5
    public func getRatingValue() -> Int{
        if let value = value{
            if value.contains("%"){
                if let wholeValue =  Float(value.split(separator: "%", omittingEmptySubsequences: true).first ?? "0"){
                    return Int((wholeValue/100) * 5)
                }
            }else if value.contains("/"){
                let values =  value.split(separator: "/", omittingEmptySubsequences: true)
                if let value1 = Float(values[0]),let value2 = Float(values[1]){
                    return Int((value1/value2) * 5)
                }
            }
        }
        return 0
    }

}
