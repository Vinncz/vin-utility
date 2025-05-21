import Foundation
import Testing
@testable import VinUtility



struct VinUtilityTest {
    
    @Test func example() async throws {
        #expect(VinUtility.name == "VinUtility")
    }
    
    @Test func await() async {
        let awaiter = VUAwaiterObject<String>()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            VULogger.log("Executing dq")
            awaiter.fulfill("Hello!")
            VULogger.log("Fulfilled")
        }
        
        VULogger.log("Sleeping")
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        VULogger.log("Woken up")
        
        VULogger.log("Invoking the await")
        let result = try? await awaiter.await()
        VULogger.log(result)
    }
    
    
    @MainActor @Test func monad() async throws {
        let flow = VUMonadAsyncFlow {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            VULogger.log("returned hello")
            return "Hello"
        }.flatMap { (word: String) in
            try await Task.sleep(nanoseconds: 1_000_000_000)
            VULogger.log("returned world")
            return "\(word) World"
        }.softFlatMap { (words: String) in
//            throw VUError.BAD_REQUEST
            return words
        }.map { (words: String) in
            "\(words)!!!"
        }
        
        let endresult = try await flow.evaluate()
        VULogger.log("Done \(endresult)")
    }
    
}
