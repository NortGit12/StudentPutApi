//
//  StudentTableViewController.swift
//  StudentPutApi
//
//  Created by Jeff Norton on 10/19/16.
//  Copyright © 2016 JeffCryst. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var students = [Student]() {
        
        didSet{
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchStudents()
    }

    //==================================================
    // MARK: - Methods
    //==================================================
    
    private func fetchStudents() {
        
        StudentController.fetchStudents { (students) in
            
            self.students = students
        }
    }

    //==================================================
    // MARK: - Table view data source
    //==================================================

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name

        return cell
    }

    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text , name.characters.count > 0
            else { return }
        
        StudentController.send(studentWithName: name) { (success) in
            
            guard success else { return }
            
            DispatchQueue.main.async {
                
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                
                self.fetchStudents()
            }
        }
    }
}












