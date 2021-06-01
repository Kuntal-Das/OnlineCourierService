# OnlineCourierService

This web app is develooped with asp.Net and SQL Server

System Design: It is designed with three tire archeture in mind

![three-tire](https://user-images.githubusercontent.com/42152227/120269345-419baf80-c2c5-11eb-9d19-61fe5c7900bc.jpg)

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

![image](https://user-images.githubusercontent.com/42152227/120270465-48c3bd00-c2c7-11eb-81f5-eaca90872c08.png)

Every user except unregistered user can :

- [x] LogIn / LogOut
- [x] change/reset password
- [x] Track a parcel

![image](https://user-images.githubusercontent.com/42152227/120270025-83792580-c2c6-11eb-854d-0720d5911537.png)

Registered user can :

- [x] book slot for Sending Parcel
- [x] provide a registered users phno./email while sending a parcel to autometically fillup part of the form. 
- [x] can cancel a Sent Parcel in transit

![image](https://user-images.githubusercontent.com/42152227/120270724-afe17180-c2c7-11eb-88b8-cb0c2ad4d091.png)
 
General Employee can: 

- [x] Create a parcel on behalf of a customer
- [ ] Update Parcel status

![image](https://user-images.githubusercontent.com/42152227/120269901-49a81f00-c2c6-11eb-8891-f2b539df359b.png)

Employee with managerial priviledge can:
- [x] do what a general employee is allowed to do
- [x] manage Employee account(create, activate, deactivate)
- [x] manage Regional Branch(create, update info, deactivate branch)
- [x] manage Sub Branch(create, update info, deactivate branch)
- [x] manage rates of parcel types over distance.

![image](https://user-images.githubusercontent.com/42152227/120269779-182f5380-c2c6-11eb-983c-38916641f800.png)

Future Improvements can be added:
- sending a parcel to a location by usng maps.
- automatic distance and fee calculation.
- automatic route calculation.
