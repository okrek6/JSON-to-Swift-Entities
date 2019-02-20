//
//  PhotosTableViewController.swift
//  Codable Protocol
//
//  Created by Brendan Krekeler on 2/19/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    
    var model = [Photo]()
    let dateFormatterGet = DateFormatter()
    let dateFormatterPrint = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatterPrint.dateStyle = .medium
        dateFormatterPrint.timeStyle = .short
        
        do {
            try getResponse()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotosTableViewCell
        let photo = model[indexPath.row]
        cell.titleLabel.text = photo.title
        cell.photoName.text = photo.image
        cell.descriptionLabel.text = photo.description
        cell.latitudeLabel.text = "Lat:\(photo.latitude)"
        cell.longitudeLabel.text = "Long:\(photo.longitude)"
        cell.dateLabel.text = dateFormatterPrint.string(from: dateFormatterGet.date(from: photo.date) ?? Date.distantPast)
        
        return cell
    }
    
    func getResponse() throws {
        guard let url = URL(string: "https://dalemusser.com/code/examples/data/nocaltrip/photos.json") else {
            //THROW ERROR
            throw MyError.runtimeError("Bad URL")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response<Photo>.self, from: dataResponse)
                if response.status == Response.Status.ok {
                    self.model = response.photos
                } else {
                    //THROW ERROR
                    throw MyError.runtimeError("Bad Status")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
}

enum MyError: Error {
    case runtimeError(String)
}

