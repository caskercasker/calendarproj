//
//  SchueduleTableViewController.swift
//  Calendar_11.29
//
//  Created by 조우현 on 12/6/19.
//  Copyright © 2019 조우현. All rights reserved.
//
//

import CoreData
import UIKit

class SecondViewController: UITableViewController {
    var memos: [NSManagedObject] = []
    var destinationDate: String = "" //버튼을 클릭시 넘어오는 Date객체의 String 형태
    var targetDestinations = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(destinationDate)
        title = destinationDate // 날짜에 따른 뷰를 뿌린다.

        // tableView.register(UITableViewCell.self , forCellReuseIdentifier: "Cell")
        navigationItem.rightBarButtonItem = editButtonItem
        // Do any additional setup after loading the view.
    }


    @IBAction func addMemo(_: UIButton){
//        let alert = UIAlertController(title: "새로운 일정", message: "일정만 추가", preferredStyle: .alert)// 알람스타일의 레이아웃
//        let saveAction = UIAlertAction(title: "저장", style: .default) {
//            [unowned self] _ in
//
//            guard let textField = alert.textFields?.first,
//                let doToSave = textField.text else {
//                return
//            }
//            guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
//                return
//            }
//            self.save(name: doToSave)
//            let indexPath = IndexPath(row: self.memos.count-1, section: 0)
//            self.tableView.insertRows(at: [indexPath], with: .right)
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//        
//        
//        
//        
//        alert.addTextField()
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//
//        present(alert, animated: true)
//    }
    }

    // Override to support editing the table view.
    
    override func tableView(_: UITableView, canEditRowAt _: IndexPath) -> Bool {
        return true
    }
    
    
//MARK: Table View (Edit =deletion)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        assert(self.tableView == tableView)
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // example
        guard editingStyle == .delete else {
            assert(false)
            return
        }
        
        if editingStyle == .delete {
            // 1
            guard (UIApplication.shared.delegate as? AppDelegate) != nil else {
                return
            }
            // let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Memo.fetchRequest()
            if let result = try? managedObjectContext.fetch(fetchRequest) {
                let object = memos[indexPath.row]
                managedObjectContext.delete(object)
            }
            try! managedObjectContext.save()
            memos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            assert(false)
        }
    }
    
//MARK: VIEW Apperar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")

        fetchRequest.predicate = NSPredicate(format: "date = %@", destinationDate)

        do {
            memos = try managedContext.fetch(fetchRequest)
            print("fefd")
        } catch {
            print("Failed")
            assert(false)
        }
        /*
         do {
             memos = try managedContext.fetch(fetchRequest)
         } catch let error as NSError {
             print("Could not fetch. \(error), \(error.userInfo)")
         }*/
    }
//MARK: SAVE FUNCTION
    
    func save(name: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entitiy = NSEntityDescription.entity(forEntityName: "Memo", in: managedContext)!
        let memo = NSManagedObject(entity: entitiy, insertInto: managedContext)
        // 3
        memo.setValue(destinationDate, forKeyPath: "date")
        memo.setValue(name, forKeyPath: "content")

        // 4
        do {
            try managedContext.save()
            memos.append(memo)
        } catch let error as NSError {
            print("Could not save, \(error), \(error.userInfo)")
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return memos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memo = memos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // cell.textLabel?.text = memo.value(forKeyPath: "date") as? String
        cell.textLabel?.text = memo.value(forKeyPath: "content") as? String
        return cell
    }
}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


