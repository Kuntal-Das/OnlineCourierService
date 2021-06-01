# OnlineCourierService

This web app is develooped with asp.Net and SQL Server

System Design: It is designed with three tire archeture in mind

It is designed to have 4 types of users 

1. Registered Customer
2. Unregistered Customer
3. Employee with managerial priviledge
4. General Employee

Functionality

Unregistered user can 

- [X] book slot for sending parcel by providing additional details 

Every user who is not an employee can:
 
- [x] Register/Create Customer account

Every user except unregistered user can :

- [x] LogIn / LogOut
- [x] change/reset password
- [x] Track a parcel

Registered user can :

- [x] book slot for Sending Parcel
- [x] provide a registered users phno./email while sending a parcel to autometically fillup part of the form. 
- [x] can cancel a Sent Parcel in transit
 
General Employee can: 

- [x] Create a parcel on behalf of a customer
- [ ] Update Parcel status

Employee with managerial priviledge can:
- [x] do what a general employee is allowed to do
- [x] manage Employee account(create, activate, deactivate)
- [x] manage Regional Branch(create, update info, deactivate branch)
- [x] manage Sub Branch(create, update info, deactivate branch)
- [x] manage rates of parcel types over distance.

Future Improvements can be added:
- sending a parcel to a location by usng maps.
- automatic distance and fee calculation.
- automatic route calculation.
