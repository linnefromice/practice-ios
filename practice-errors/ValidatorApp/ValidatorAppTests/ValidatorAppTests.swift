//
//  ValidatorAppTests.swift
//  ValidatorAppTests
//
//  Created by arata.haruyama on 2025/04/06.
//

import Testing
@testable import ValidatorApp

struct ValidatorTests {
    @Test("NonEmptyValidator - 空でない文字列は有効")
    func testNonEmptyValidatorWithValidInput() throws {
        let validator = NonEmptyValidator()
        let result = validator.validate("test")
        #expect(result.isValid)
    }
    
    @Test("NonEmptyValidator - 空文字列は無効", arguments: [
        "",
        " ",
        "\n",
        "\t"
    ])
    func testNonEmptyValidatorWithInvalidInput(_ input: String) throws {
        let validator = NonEmptyValidator()
        let result = validator.validate(input)
        #expect(!result.isValid)
        
        if case .failure(let error) = result {
            #expect(error.key == "error.nonEmpty")
        }
    }
    
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
    
    @Test("CompositeValidator - 複数のバリデーションを組み合わせる")
    func testCompositeValidator() throws {
        let validator = CompositeValidator(validators: [
            AnyValidator(NonEmptyValidator()),
            AnyValidator(UserIdValidator())
        ])
        
        // 有効なケース
        let validResult = validator.validate("user-name")
        #expect(validResult.isValid)
        
        // 無効なケース - 空文字
        let emptyResult = validator.validate("")
        #expect(!emptyResult.isValid)
        if case .failure(let error) = emptyResult {
            #expect(error.key == "error.nonEmpty")
        }
        
        // 無効なケース - 不正なフォーマット
        let invalidResult = validator.validate("user123")
        #expect(!invalidResult.isValid)
        if case .failure(let error) = invalidResult {
            #expect(error.key == "error.invalidUserId")
        }
    }
    
    @Test("ValidationError - エラーメッセージの等価性")
    func testValidationErrorEquality() throws {
        let error1 = ValidationError(key: "error.test", arguments: ["arg1"])
        let error2 = ValidationError(key: "error.test", arguments: ["arg1"])
        let error3 = ValidationError(key: "error.different", arguments: ["arg1"])
        
        #expect(error1 == error2)
        #expect(error1 != error3)
    }
}
