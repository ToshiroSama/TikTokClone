//
//  AuthenticationManager.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    public static let shared = AuthManager()
    
    private init() {}
    
    enum SignInMethod {
        case email
        case facebook
        case google
    }
    
    enum AuthError: Error {
        case signInField
    }
    
    // Public
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    public func signIn(with email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else { 
                    completion(.failure(AuthError.signInField))
                }
                return
            }
            
            // Successful sign in
            completion(.success(email))
        }
    }
    
    public func signUp(with username: String, emailAddress: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            
            DatabaseManager.shared.insertUser(with: emailAddress, username: username, completion: completion)
        }
    }
    
    public func signOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            print(error)
            completion(false)
        }
    }
}

