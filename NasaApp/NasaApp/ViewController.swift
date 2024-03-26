import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
 
    var model: [Model] = [] // Değişken adını model olarak güncelledim
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        // NASA API'den resim ve metin verisini çekmek için Alamofire kullanıyoruz
        let apiURL = URL(string: "https://api.nasa.gov/planetary/apod?api_key=02dLMHOop5N34PfEdQiflx5tarbexQPMK8OFTLAW")!
        
        AF.request(apiURL).responseDecodable(of: Model.self) { response in
            switch response.result {
            case .success(let model):
                self.model.append(model) // Gelen veriyi model dizisine ekliyoruz
                DispatchQueue.main.async {
                    self.updateUI(with: model) // UI'yi güncellemek için updateUI fonksiyonunu çağırıyoruz
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func updateUI(with model: Model) {
        // UI bileşenlerini güncellemek için gelen model verisini kullanın
        dateLabel.text = model.date
        text.text = model.explanation
        titleLabel.text = model.title
        
        // Resmi yüklemek için URL'yi kullanarak bir UIImage nesnesi oluşturun
        if let imageURL = URL(string: model.url) {
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data) // Resmi imageView'e atayın
                }
            }.resume()
        }
    }
}
