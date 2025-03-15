//
//  DetailViewController.swift
//  Project7
//
//  Created by Ömerfaruk Saribal on 9.03.2025.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <style>
                        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

                        body { 
                            font-family: 'Poppins', sans-serif;
                            background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
                            color: white; 
                            margin: 0; 
                            padding: 20px; 
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                            text-align: center;
                        }

                        .container {
                            background: rgba(255, 255, 255, 0.1);
                            padding: 25px;
                            border-radius: 15px;
                            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
                            max-width: 600px;
                            width: 90%;
                            backdrop-filter: blur(10px);
                            animation: fadeIn 1.5s ease-in-out;
                        }

                        h1 {
                            font-size: 24px;
                            font-weight: 600;
                            margin-bottom: 10px;
                        }

                        p {
                            font-size: 18px;
                            line-height: 1.6;
                            font-weight: 300;
                            color: #f1f1f1;
                        }

                        @keyframes fadeIn {
                            from { opacity: 0; transform: translateY(-20px); }
                            to { opacity: 1; transform: translateY(0); }
                        }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h1>Petition Details</h1>
                        <p>\(detailItem.body)</p>
                    </div>
                </body>
            </html>
        """

        
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
