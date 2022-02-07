# AlbumList
This project is part of an assignment submission. 


Its an iOS Application - supported from iOS 13. In this app, we fetch list of album and displays in the app.

Supported features are, 

1. Fetch album from remote server 
2. Save fetched data in the database 
3. Display the album information in the UITableview 
4. Sorted data as per album title (ascending order) 
5. Support for the offline display of information
6. Network check 
7. Automatic retry when network reconnects
8. Error alert display when fetch fails. 

For this application, used MVVM architecture, where viewmodel and view communicate via delegate. 
Persistent storage is achieved by making use of Realm database. 

Language used, 
Swift 

UI Framework, 
UIKit

For network connection, 
URLSession 

Thirdparty framework used are, 
1. Reachability - https://github.com/ashleymills/Reachability.swift
2. RealmSwift - https://github.com/realm/realm-swift

Used a swift package manager to include these frameworks in the app. 

Class details, 
ViewController: AlbumListViewController 
ViewModel: AlbumListViewModel 
Models:
1. AlbumModel (Generic model) 
2. AlbumRealmModel (Database model) 
3. AlbumNetworkModel (Network model) 

Generic Managers,
1. Router - to manage the URL Request details, such as http method, url path, 
2. URLSessionNetworkRequestService - handles the URLSession - connection to the remote server and retrieve data. 
3. DatabaseManager - Handles the database operations such as save, fetch data from database. 

Further improvements required, 
1. Write unit tests for Model, ViewModel and View logic
2. Write performance unit test for launch time 

3. Sort albums based on id. 
