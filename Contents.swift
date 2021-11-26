import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let employeeApiUrl = "https://demo0333988.mockable.io/getEmployees"
let reportsApiUrl = "https://demo0333988.mockable.io/getReports"


struct EmployeeResult: Codable {
    let id: String
    let name: String
    let address: String
}

struct EmployeeModel: Codable {
    let employees: [EmployeeResult]?
}

struct ReportResult: Codable {
    let id: String
    let labourHours: String
    let totalCost: String
}

struct ReportModel: Codable {
    let reports: [ReportResult]?
}

class HttpHandler {
    
    func getDataFromApi<T: Codable>(url: URL, resultType: T.Type, completionHandler: @escaping(_ result: T?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                completionHandler(result)
            } catch {
                debugPrint("Error")
            }
        }.resume()
    }
}

class DatabaseHandler {
    
    func saveDataToDatabase(data: Array<EmployeeModel>) {
        // code to save data to database
    }
}

class Employees {
    
    let _httpHandler: HttpHandler
    
    init(httpHandler: HttpHandler) {
        _httpHandler = httpHandler
    }
    
    func getEmployeeData() -> Void {
        
        _httpHandler.getDataFromApi(url: URL(string: employeeApiUrl)!, resultType: EmployeeModel.self) { (result) in
            debugPrint(result as Any)
            // business logic to use the result
        }
    }
}

class Reports {
    
    let _httpHandler: HttpHandler
    
    init(httpHandler: HttpHandler) {
        _httpHandler = httpHandler
    }
    
    func getReportsData() -> Void {
        
        _httpHandler.getDataFromApi(url: URL(string: reportsApiUrl)!, resultType: ReportModel.self) { (result) in
            debugPrint(result as Any)
            // business logic to use the result
        }
    }
}

let objEmployee = Employees(httpHandler: HttpHandler())
objEmployee.getEmployeeData()

let objReports = Reports(httpHandler: HttpHandler())
objReports.getReportsData()
