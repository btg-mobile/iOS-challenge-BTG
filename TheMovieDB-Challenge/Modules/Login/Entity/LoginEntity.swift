//
//  Entity.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 17/06/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

enum SocialLoginTypes {
    case Apple
    case Facebook
    case Google
    case Email
}

class LoginSocialEntity {
    
    public var id: String?
    public var Email: String?
    public var GivenName: String?
    public var FamilyName: String?
    public var FullName: String?
    public var AuthorizationCode: String?
    public var IdentityToken: String?
    public var type: SocialLoginTypes?
    
    init() {
    }
//    override convenience init() {
//        self.id = ""
//        self.Email = ""
//        self.GivenName = ""
//        self.FamilyName = ""
//        self.FullName = ""
//        self.AuthorizationCode = ""
//        self.IdentityToken = ""
//        self.type = nil
//    }
    
    init(id: String, Email: String, GivenName: String, FamilyName: String, FullName: String, AuthorizationCode: String, IdentityToken: String, type: SocialLoginTypes) {
        self.id = id
        self.Email = Email
        self.GivenName = GivenName
        self.FamilyName = FamilyName
        self.FullName = FullName
        self.AuthorizationCode = AuthorizationCode
        self.IdentityToken = IdentityToken
        self.type = type
    }
    
    public func showValues() {
        print("========= Exibindo valores Login Social =========")
        print("ID: \(self.id!)")
        print("E-mail: \(self.Email!)")
        print("Nome: \(self.GivenName!)")
        print("Sobre nome: \(self.FamilyName!)")
        print("Nome completo: \(self.FullName!)")
        print("Token de autenticação: \(self.AuthorizationCode!)")
        print("Token de identificação: \(self.IdentityToken!)")
        print("========= Exibindo valores Login Social =========")
    }
    
}
