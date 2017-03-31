//
//  ViewController.swift
//  AddressListDemo
//
//  Created by llk on 17/1/9.
//  Copyright © 2017年 llk. All rights reserved.
//

import UIKit
import Contacts
import AddressBook

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressBook()
        //Contacts()
    }
    func addressBook(){
        let contact = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        ABAddressBookRequestAccessWithCompletion(contact) { (granted, error) in
            guard granted else {
                print("用户拒绝授权，直接返回")
                return
            }
            
            print("用户允许访问，访问通讯录")
            let peoples = ABAddressBookCopyArrayOfAllPeople(contact).takeRetainedValue() as NSArray
            for people: ABRecord in peoples as [AnyObject]{
                
                var firstName = ""
                var lastName = ""
                if let firstNameUnmanaged = ABRecordCopyValue(people, kABPersonLastNameProperty) {
                    firstName = firstNameUnmanaged.takeRetainedValue() as? String ?? ""
                }
                if let lastNameUnmanaged = ABRecordCopyValue(people, kABPersonFirstNameProperty) {
                    lastName = lastNameUnmanaged.takeRetainedValue() as? String ?? ""
                }
                let phoneNums: ABMultiValue = ABRecordCopyValue(people, kABPersonPhoneProperty).takeRetainedValue()
                guard let phoneNumUnmanaged = ABMultiValueCopyValueAtIndex(phoneNums, 0) else {
                    continue
                }
                var phoneNum = phoneNumUnmanaged.takeRetainedValue() as? String ?? ""
                print(phoneNum)
                var name = ""
                if firstName == "" {
                    name = lastName
                }else if lastName == ""{
                    name = firstName
                }
                print(name)
            }

        }
    }
}

