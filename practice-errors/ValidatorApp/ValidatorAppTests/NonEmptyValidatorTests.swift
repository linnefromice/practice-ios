import Testing
@testable import ValidatorApp

struct NonEmptyValidatorTests {
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
}
