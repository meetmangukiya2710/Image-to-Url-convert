//
//  DBHelper.swift
//  Image to Url convert
//
//  Created by R95 on 11/03/24.
//

import Foundation
import SQLite3
import UIKit

struct UserData {
    var email: String
    var password: String
    var image: String
}

class DBHelper {
    static var file : OpaquePointer?
    public static var userArray = [UserData]()
    
    static func createFile() {
        var a = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        a.appendPathComponent("My User Data1.db")
        sqlite3_open(a.path, &file)
        print("Creat A File")
        print(a.path)
        creatTable()
    }
    
    static func creatTable() {
        let quary = "Create Table if not exists User (email text,password text,image text)"
        var table: OpaquePointer?
        sqlite3_prepare(file, quary, -1, &table, nil)
        sqlite3_step(table)
        print("Create Table")
    }
    
    static func addData(email: String, password: String, image: String) {
        let quary = "insert into user values ('\(email)', '\(password)', '\(image)')"
        var add: OpaquePointer?
        sqlite3_prepare(file, quary, -1, &add, nil)
        sqlite3_step(add)
        print("add data")
    }
    
    static func getData() {
        let quary = "SELECT * FROM User"
        var read: OpaquePointer?
        sqlite3_prepare(file, quary, -1, &read, nil)
        
        
        while sqlite3_step(read) == SQLITE_ROW {
            if let email = sqlite3_column_text(read, 0),
               let password = sqlite3_column_text(read, 1),
               let imageUrl = sqlite3_column_text(read, 2) {
                let userEmail = String(cString: email)
                let userPassword = String(cString: password)
                let userImage = String(cString: imageUrl)
                let userData = UserData(email: userEmail, password: userPassword, image: userImage)
                userArray.append(userData)
                print("Email: \(userEmail), Password: \(userPassword), Image: \(userImage)")
            }
        }
    }
    
//    static func deleteData(email: String) {
//        let q = "DELETE FROM User WHERE email = '\(email)'"
//        var delete: OpaquePointer?
//        sqlite3_prepare(file, q, -1, &delete, nil)
//        sqlite3_step(delete)
//        print("Delete data")
//    }
    
}

