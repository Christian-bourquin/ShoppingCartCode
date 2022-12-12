//
//  ViewController.swift
//  ShoppingCart
//
//  Created by Christian Bourquin on 12/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ItemTextFieldOutlet: UITextField!
    @IBOutlet weak var backgroundOutlet: UIImageView!
    @IBOutlet weak var tableViewOutlet: UITableView!
  
    var movies = ["apples","corn","chips","beef","bread","milk"]
    var selectedMovie = ""
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        backgroundOutlet.image = UIImage(named: "BlankNote 1")
        // Do any additional setup after loading the view.
        if let movi = defaults.object(forKey: "myMovies"){
            movies = movi as! [String]
       }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    //populates table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell")!
            cell.textLabel?.text = movies[indexPath.row]
            cell.detailTextLabel?.text = "Best movies"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let blah = tableView.cellForRow(at: indexPath)?.textLabel?.text{
            selectedMovie = blah
            print(selectedMovie)
        }
         tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    
    @IBAction func addItemsAction(_ sender: UIBarButtonItem) {
        if movies.contains(ItemTextFieldOutlet.text!) == true{
            let alertController = UIAlertController(title: "Alert", message: "Entering Duplicate", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
               
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            movies.append(ItemTextFieldOutlet.text!)
            tableViewOutlet.reloadData()
            ItemTextFieldOutlet.text = ""
        }
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        self.tableViewOutlet.isEditing = !self.tableViewOutlet.isEditing
    }
    
    /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let blah = tableView.cellForRow(at: indexPath)?.textLabel?.text{
            selectedMovie = blah
          performSegue(withIdentifier: "toMovieInfo", sender: nil)
        }
    }
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let MovedObjTemp = movies[sourceIndexPath.item]
        movies.remove(at: sourceIndexPath.item)
        movies.insert(MovedObjTemp, at: destinationIndexPath.item)
    }
    
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        defaults.set(movies, forKey: "myMovies")
        
    }
    @IBAction func sortAction(_ sender: UIButton) {
        movies.sort()
        tableViewOutlet.reloadData()
    }
    /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let NVC = segue.destination as! MovieInfo
     NVC.imput = selectedMovie
     }
     */
     }
