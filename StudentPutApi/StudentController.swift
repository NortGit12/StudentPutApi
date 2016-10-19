//
//  StudentController.swift
//  StudentPutApi
//
//  Created by Jeff Norton on 10/19/16.
//  Copyright © 2016 JeffCryst. All rights reserved.
//

import Foundation

class StudentController {
    
    /*
     Work:
        -Endpoints
        -Function for getting students
        -Function for adding a student
     */
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    static var baseURL = URL(string: "https://names-e4301.firebaseio.com/students")
    
    static let getterEndpoint = baseURL?.appendPathExtension("json")
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func send(studentWithName name: String,
                     completion: ((_ success: Bool) -> Void)? = nil) {
    
        // Create a student instance
        let student = Student(name: name)
        
        // Add the student name to the URL
        guard let url = baseURL?.appendingPathComponent(name).appendingPathExtension("json") else { return }
        
        // Call the NetworkController to send the data to Firebase
        NetworkController.performRequest(for: url, httpMethod: .Put, body: student.jsonData) { (networkCalldata, networkCallError) in
            
            var success = false
            
            defer {
                
                if let completion = completion {
                    completion(success)
                }
            }
            
            guard let responseDataString = String(data: data!, encoding: .utf8) else { return }
            
            if let error = error {
                
                NSLog("Error: \(error.localizedDescription)")
//                if let completion = completion {
//                    completion(false)
//                }
//                return
            } else if responseDataString.contains("error") {
                
                NSLog("Error: \(responseDataString)")
//                if let completion = completion {
//                    completion(false)
//                }
//                return
            } else {
                
                print("Successfully saved data to the endpoint.  \nResponse: \(responseDataString)")
                success = true
//                if let completion = completion {
//                    completion(success)
//                }
            }
        }
    }
}










