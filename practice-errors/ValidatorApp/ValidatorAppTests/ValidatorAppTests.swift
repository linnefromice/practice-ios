//
//  ValidatorAppTests.swift
//  ValidatorAppTests
//
//  Created by arata.haruyama on 2025/04/06.
//

import Testing
@testable import ValidatorApp

struct ValidatorTests {
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
