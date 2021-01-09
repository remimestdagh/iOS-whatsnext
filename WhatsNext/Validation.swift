import Foundation

/// enum contraining frequent errors
enum EvaluateError: Error {
    case isEmpty
    case isNotValidEmailAddress
    case isNotValidEmailLength
    case invalidCharacter
    case tooLong
    case tooShort
}

extension EvaluateError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .tooShort:
            return NSLocalizedString(
                "Your name needs to be at least 2 characters long",
                comment: ""
            )
        case .tooLong:
            return NSLocalizedString(
                "Your name can't be longer than 14 characters",
                comment: ""
            )
        case .invalidCharacter:
            return NSLocalizedString(
                "Your name can only contain letters",
                comment: ""
            )
        case .isEmpty:
            return NSLocalizedString(
                "Please fill in every field",
                comment: ""
            )

        case .isNotValidEmailAddress:
            return NSLocalizedString(
                "Email is not valid",
                comment: ""
            )
        case .isNotValidEmailLength:
            return NSLocalizedString(
                "Email is not valid",
                comment: ""
            )
        }
    }
}

/// validations for register functionality
struct Validations {
    static func validate(username: String) throws {
        guard username.count > 1 else {
            throw EvaluateError.tooShort
        }

        guard username.count < 15 else {
            throw EvaluateError.tooLong
        }

        for character in username {
            guard character.isLetter else {
                throw EvaluateError.invalidCharacter
            }
        }
    }
    private static let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
        + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
        + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
        + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
        + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
        + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
        + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

    static func email(_ string: String) throws {
        if string.isEmpty == true {
            throw EvaluateError.isEmpty
        }

        if isValid(input: string,
                   regEx: emailRegEx,
                   predicateFormat: "SELF MATCHES[c] %@") == false {
            throw EvaluateError.isNotValidEmailAddress
        }

        if maxLength(emailAddress: string) == false {
            throw EvaluateError.isNotValidEmailLength
        }
    }

    // MARK: - Private
    private static func isValid(input: String, regEx: String, predicateFormat: String) -> Bool {
        return NSPredicate(format: predicateFormat, regEx).evaluate(with: input)
    }

    private static func maxLength(emailAddress: String) -> Bool {
        // 64 chars before domain and total 80. '@' key is part of the domain.
        guard emailAddress.count <= 80 else {
            return false
        }

        guard let domainKey = emailAddress.firstIndex(of: "@") else { return false }

        return emailAddress[..<domainKey].count <= 64
    }
}
