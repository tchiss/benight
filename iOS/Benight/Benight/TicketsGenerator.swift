//
//  TicketsGenerator.swift
//  Benight
//
//  Created by Kevin VACQUIER on 18/08/2015.
//  Copyright (c) 2015 Benight. All rights reserved.
//

import Foundation

public func GenerateTicket (reservation: PFObject?) {
    if let reservation = reservation {
        if let Event: PFObject = reservation["Event"] as? PFObject
        {
    let EventNameString : String = Event["name"] as! String
    var Ticket = PFObject(className:"Tickets")
    Ticket["Reservation"] = reservation
    Ticket["User"] = PFUser.currentUser()
    Ticket["EventName"] = EventNameString[0..<15]
    Ticket["EventPlace"] = Event["author"]
    Ticket["Date"] = Event["date"]
    Ticket.saveInBackground()
        }
    }
}