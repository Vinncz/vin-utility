@testable import VinUtility
import XCTest


final class AnyCodableTests: XCTestCase {
    func testDecodingNestedJSON() throws {
        let json = """
        {
            "id": "123",
            "name": "Alice",
            "details": {
                "age": 30,
                "address": {
                    "city": "Wonderland",
                    "zip": "12345"
                }
            },
            "hobbies": ["Reading", "Chess"],
            "abilities": [
                {
                    "name": "dying"
                }
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let decoded = try decoder.decode([String: VUAnyCodable].self, from: json)

        XCTAssertEqual(decoded["id"], .string("123"))
        XCTAssertEqual(decoded["name"], .string("Alice"))

        if case .dictionary(let details) = decoded["details"] {
            XCTAssertEqual(details["age"], .int(30))

            if case .dictionary(let address) = details["address"] {
                XCTAssertEqual(address["city"], .string("Wonderland"))
                XCTAssertEqual(address["zip"], .string("12345"))
            } else {
                XCTFail("Address is not a dictionary")
            }
        } else {
            XCTFail("Details is not a dictionary")
        }

        if case .array(let hobbies) = decoded["hobbies"] {
            XCTAssertEqual(hobbies, [.string("Reading"), .string("Chess")])
        } else {
            XCTFail("Hobbies is not an array")
        }
        
        VULogger.log(decoded)
    }
}
