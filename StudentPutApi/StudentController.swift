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
    
    static var baseURL = URL(string: "https://names-e4301.firebaseio.com/students")!
    
    static let getterEndpoint = baseURL.appendingPathExtension("json")
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func send(studentWithName name: String,
                     completion: ((_ success: Bool) -> Void)? = nil) {
    
        // Create a student instance
        let student = Student(name: name)
        
        // Add the student name to the URL
        let url = baseURL.appendingPathComponent(name).appendingPathExtension("json")
        
        // Call the NetworkController to send the data to Firebase
        NetworkController.performRequest(for: url, httpMethod: .Put, body: student.jsonData) { (data, error) in
            
            var success = false
            
            defer {
                
                if let completion = completion {
                    completion(success)
                }
            }
            
            guard let responseDataString = String(data: data!, encoding: .utf8) else { return }
            
            if let error = error {
                
                NSLog("Error: \(error.localizedDescription)")
                
            } else if responseDataString.contains("error") {
                
                NSLog("Error: \(responseDataString)")
                
            } else {
                
                print("Successfully saved data to the endpoint.  \nResponse: \(responseDataString)")
                success = true
            }
        }
    }
    
    static func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        NetworkController.performRequest(for: getterEndpoint, httpMethod: .Get) { (data, error) in
            
            guard let data = data else {
                completion([])
                return
            }
            
            guard let studentsDict = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String : [String : String]] else {
                
                completion([])
                return
            }
            
            let students = studentsDict.flatMap{ Student(dictionary: $0.1) }
            completion(students)
        }
    }
}










