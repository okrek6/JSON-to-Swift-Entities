//
//  PhotosTableViewController.swift
//  JSONSerialization
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {

    var model = [Photo]()
    let dateFormatterGet = DateFormatter()
    let dateFormatterPrint = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatterPrint.dateStyle = .medium
        dateFormatterPrint.timeStyle = .short
        //Get JSON
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
        cell.latLabel.text = "Lat:\(photo.latitude)"
        cell.longLabel.text = "Long:\(photo.longitude)"
        cell.dateLabel.text = dateFormatterPrint.string(from: dateFormatterGet.date(from: photo.date) ?? Date.distantPast)
        
        return cell
    }
    
    func getResponse() throws {
        guard let url = URL(string: "https://dalemusser.com/code/examples/data/nocaltrip/photos.json") else {
            throw MyError.runtimeError("Bad Status")
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                guard let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []),
                    let rootNode = json as? [String: Any] else {
                        //THROW ERROR
                        //return (nil, "unable to parse response from server")
                        throw MyError.runtimeError("Parsing Error")
                }
                if let status = rootNode["status"] {
                    if let status = status as? Response<Photo>.Status {
                        if status == Response<Photo>.Status.error {
                            //THROW ERROR
                            throw MyError.runtimeError("Bad Status")
                        }
                    }
                }
                
                var tempPhotos = [Photo]()
                
                if let photos = rootNode["photos"] as? [[String: Any]] {
                    for photo in photos {
                        if let image = photo["image"] as? String,
                            let title = photo["title"] as? String,
                            let latitude = photo["latitude"] as? Double,
                            let longitude = photo["longitude"] as? Double,
                            let description = photo["description"] as? String,
                            let date = photo["date"] as? String {
                            
                            tempPhotos.append(Photo(image: image, title: title, description: description, latitude:latitude, longitude: longitude, date: date))
                            
                        }
                    }
                }
                
                self.model = tempPhotos
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
