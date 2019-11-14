//
//  SearchResultVC.swift
//  Dr.Booking
//
//  Created by Ali Mohamed on 11/12/19.
//  Copyright © 2019 BeSolutions.Dr.BookingOriginal. All rights reserved.
//

import UIKit
import Cosmos
class SearchResultVC: UIViewController {
    
    
    var doctorsArray: [SearchDoctor]?
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func searchDoctors(SortBy:String , keyWord: String , userId: String){
        if SortBy == "all" {
            APIClient.getDoctors(user_id: userId) { (Result) in
                switch Result {
                case .success(let response):
                    print("success")
                    self.doctorsArray = response.doctors
                    self.TableView.reloadData()
                case .failure(let error):
                    print("error")
                    print(error.localizedDescription)
                    
                }
            }
        } else {
            
        }
    }
    
    
}



extension SearchResultVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchResultTableViewCell
        if let doctor = doctorsArray?[indexPath.row] {
            cell.doctorName.text = doctor.name
            cell.doctorFees.text = doctor.price
            cell.DoctorTitle.text = doctor.jobTitle
//            cell.doctorAddress.text = doctor.address
            cell.rateView.rating = doctor.rating
            cell.doctorImage.sd_setImage(with: URL(string: doctor.image), placeholderImage: UIImage(named: "user"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DoctorDetails") as! DoctorDetailsVC
        vc.doctor = doctorsArray?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
