import Foundation
import Security


/// A type wrapper for CFDictionary used in the Keychain API.
/// Enables a more readable and composable way of making queries.
struct VUSecureQuery {
    
    
    private var query: [CFString: Any]
    
    
    init ( _ initialObject: [CFString: Any] ) {
        self.query = initialObject
    }
    
    
    init () {
        self.init([:])
    }
    
    
    /// Returns the query as a CFDictionary. Used for the Keychain API.
    func unwrapped () -> CFDictionary {
        query as CFDictionary
    }
    
    
    /// Returns the raw dictionary. Used for debugging.
    func rawUnwrapped () -> [CFString: Any] {
        query
    }
    
    
    /// Writes a key-value pair into the query, replacing any existing value.
    /// 
    /// - Parameters:
    ///   - key: The key to insert or update.
    ///   - value: The corresponding value.
    func write ( _ key: CFString, _ value: Any ) -> VUSecureQuery {
        var query = self.query
            query[key as CFString] = value
        
        return VUSecureQuery(query)
    }
    
}


extension VUSecureQuery {
    
    
    func RW_IR_ID_valueData ( _ data: Data ) -> VUSecureQuery {
        var query = self.query
            query[kSecValueData] = data
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, OPTIONAL for READ)  
    /// Specifies the access control mechanism for the key.
    ///
    /// - Required when storing a key to enforce security policies.  
    /// - If omitted on retrieval, access control settings will not be checked.
    func RW_OR_authenticated () -> VUSecureQuery {
        var query = self.query
        var error: Unmanaged<CFError>?
        
        if let accessControl = SecAccessControlCreateWithFlags (
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            [.userPresence],
            &error
        ) {
            query[kSecAttrAccessControl] = accessControl
        } else {
            fatalError("Failed to create SecAccessControl: \(String(describing: error?.takeRetainedValue()))")
        }
        
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, REQUIRED for READ, REQUIRED for DELETE)  
    /// Specifies a generic label for the key. Required when storing kSecKeyClass-marked keys.
    ///
    /// - The same identifier must be used for storing and retrieving the key.  
    func RW_RR_RD_applicationLabel ( _ tag: String ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrApplicationLabel] = tag
        
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, REQUIRED for READ, REQUIRED for DELETE)  
    /// Specifies an identifier for the key. Required when storing kSecKeyClass-marked keys.
    ///
    /// - The same identifier must be used for storing and retrieving the key.  
    func RW_RR_RD_applicationTag ( _ tag: String ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrApplicationTag] = tag
        
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, REQUIRED for READ)  
    /// Specifies the key nature: encryption key, generic passwords, etc.
    ///
    /// - Required when storing the key.  
    /// - If omitted on retrieval, no class filter is applied.  
    func RW_OR_keyClass ( _ keyClass: KeyClass ) -> VUSecureQuery {
        var query = self.query
            query[kSecClass] = keyClass.rawValue
        
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, OPTIONAL for READ)  
    /// Specifies the cryptographic key type (RSA or EC).  
    ///
    /// - Required when storing the key.  
    /// - If omitted on retrieval, no key type filter is applied.  
    func RW_OR_keyType ( _ type: KeyType ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrKeyType] = type.rawValue
        
        return VUSecureQuery(query)
    }
    
    
    func RW_OR_attrKeyClass ( _ attrKeyClass: AttrKeyClass ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrKeyClass] = attrKeyClass.rawValue
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for WRITE, OPTIONAL for READ)  
    /// Specifies an account name associated with the key (useful for multi-user environments).
    func OW_OR_keyOwner ( _ account: String ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrAccount] = account
            
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for WRITE, OPTIONAL for READ)  
    /// Specifies an owner label for identifying whose key this is.
    func OW_OR_OD_genericLabel ( _ label: String ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrLabel] = label
            
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for WRITE, OPTIONAL for READ)  
    /// Specifies the access group for shared Keychain access between multiple apps.  
    ///
    /// - If omitted, the key is only accessible to the current app.  
    func OW_OR_accessGroup ( _ group: String ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrAccessGroup] = group
            
        return VUSecureQuery(query)
    }
    
}


/// Key placement-specific query modifiers.
extension VUSecureQuery {
    
    
    /// (REQUIRED for WRITE)  
    /// Stores the key inside the Secure Enclave.
    func RW_secureEnclave ( _ type: KeyType ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrTokenID] = kSecAttrTokenIDSecureEnclave
            query[kSecAttrKeyType] = type.rawValue
            
        return VUSecureQuery(query)
    }
    
    
    /// (REQUIRED for WRITE, IGNORED for READ)  
    /// Specifies the size of the key in bits.  
    ///
    /// - Ignored when retrieving a key.  
    func RW_IR_keySize ( _ size: KeySize ) -> VUSecureQuery {
        var query = self.query
            query[kSecAttrKeySizeInBits] = size.rawValue
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for WRITE, IGNORED for READ)  
    /// Specifies that the key is accessible only when the device is unlocked.
    func OW_IR_whenUnlocked () -> VUSecureQuery {
        var query = self.query
            query[kSecAttrAccessible] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        
        return VUSecureQuery(query)
    }
     
    
    /// (OPTIONAL for WRITE)  
    /// Makes the key persistent, ensuring it remains in the Keychain.
    func OW_persistent () -> VUSecureQuery {
        var query = self.query
            query[kSecAttrIsPermanent] = true
        
        return VUSecureQuery(query)
    }
    
}


/// Key retrieval-specific query modifiers.
extension VUSecureQuery {
    
    /// (OPTIONAL for READ)  
    /// Limits the number of results returned. Defaults to 1.
    func OR_limit ( _ limit: Int ) -> VUSecureQuery {
        var query = self.query
            query[kSecMatchLimit] = limit
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for READ)  
    /// Returns the key's raw data.
    func OR_returnData () -> VUSecureQuery {
        var query = self.query
            query[kSecReturnData] = true
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for READ)  
    /// Returns a reference to the key, allowing further operations.
    func OR_returnRef () -> VUSecureQuery {
        var query = self.query
            query[kSecReturnRef] = true
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for READ)  
    /// Returns metadata attributes of the key.
    func OR_returnAttributes () -> VUSecureQuery {
        var query = self.query
            query[kSecReturnAttributes] = true
        
        return VUSecureQuery(query)
    }
    
    
    /// (OPTIONAL for READ)  
    /// Returns nothing.
    func OR_returnNothing () -> VUSecureQuery {
        var query = self.query
            query[kSecReturnData] = false
        
        return VUSecureQuery(query)
    }
    
}

extension VUSecureQuery {
    
    
    enum KeyClass {
        case genericPassword
        case cryptographicKey
        case identity
        case certificate
        
        var rawValue: CFString {
            switch self {
                case .genericPassword : return kSecClassGenericPassword
                case .cryptographicKey: return kSecClassKey
                case .identity        : return kSecClassIdentity
                case .certificate     : return kSecClassCertificate
            }
        }
    }
    
    
    enum KeySize {
        case bits128
        case bits256
        case bits384
        case bits512
        
        var rawValue: Int {
            switch self {
                case .bits128: return 128
                case .bits256: return 256
                case .bits384: return 384
                case .bits512: return 512
            }
        }
    }
    
    
    enum KeyType {
        case ecSecPrimeRandom
        case rsa
        
        var rawValue: CFString {
            switch self {
                case .ecSecPrimeRandom: return kSecAttrKeyTypeECSECPrimeRandom
                case .rsa:              return kSecAttrKeyTypeRSA
            }
        }
    }
    
    
    enum AttrKeyClass {
        case `public`
        case `private`
        case symmetric
        
        var rawValue: CFString {
            switch self {
                case .public:  return kSecAttrKeyClassPublic
                case .private: return kSecAttrKeyClassPrivate
                case .symmetric: return kSecAttrKeyClassSymmetric
            }
        }
    }
    
}
