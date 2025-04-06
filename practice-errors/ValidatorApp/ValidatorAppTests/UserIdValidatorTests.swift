import Testing
@testable import ValidatorApp

struct UserIdValidatorTests {
    @Test("UserIdValidator - 有効なユーザーID", arguments: [
        "user",
        "User-Name",
        "abc-DEF",
        "a-b-c"
    ])
    func testUserIdValidatorWithValidInput(_ userId: String) throws {
        let validator = UserIdValidator()
        let result = validator.validate(userId)
        #expect(result.isValid)
    }
    
    @Test("UserIdValidator - 無効なユーザーID", arguments: [
        "user123",         // 数字を含む
        "user_name",       // アンダースコアを含む
        "ユーザー",        // 日本語を含む
        "user@domain",     // 特殊文字を含む
        "",               // 空文字
        "user name"       // スペースを含む
    ])
    func testUserIdValidatorWithInvalidInput(_ userId: String) throws {
        let validator = UserIdValidator()
        let result = validator.validate(userId)
        #expect(!result.isValid)
        
        if case .failure(let error) = result {
            #expect(error.key == "error.invalidUserId")
        }
    }
}
