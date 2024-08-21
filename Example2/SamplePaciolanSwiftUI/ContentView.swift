import SwiftUI
import PaciolanSDK

struct ContentView: View {
    
    @State var showSdk = false
    @State var controller = PaciolanSDKViewController(string: "{\"channelCode\":\"msdk-sa\",\"sdkKey\":\"test2\",\"organizationId\":390,\"distributorCode\":\"CICD80\",\"applicationId\":\"com.paciolan.sdk\",\"uiOptions\":{\"accentColor\":\"#cc0000\",\"logoImage\":\"https://upload.wikimedia.org/wikipedia/en/thumb/2/28/Tulane_Green_Wave_logo.svg/1200px-Tulane_Green_Wave_logo.svg.png\"},\"route\":{\"name\":\"event-list\"},\"debug\":true,\"demo\":false}")!
    
    var body: some View {
        VStack(spacing: 0) {
            if showSdk {
                PaciolanViewRepresentable(controller: controller)
                    .onAppear {
                        NotificationCenter.default.addObserver(
                            forName: NSNotification.Name("ExitAppNotification"),
                            object: nil,
                            queue: .main
                        ) { notification in
                            showSdk = false
                        }
                    }
                    .onDisappear {
                        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ExitAppNotification"), object: nil)
                    }
            } else {
                Button("Open Paciolan SDK") {
                    showSdk = true
                }
            }
            Spacer()
            Divider()
            HStack(alignment: .center) {
                Button("Home") {
                    navigateAwayFromPaciolan()
                }
                Divider()
                Button("Schedule") {
                    navigateAwayFromPaciolan()
                }
                Divider()
                Button("Open SDK") {
                    showSdk = true
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .frame(height: 30)
        }
    }
    
    func navigateAwayFromPaciolan() {
        DispatchQueue.main.async {
            controller.navAway(fromPac: nil, resolver: { result in
                print("navAway Sucess: \(result!)")
                    
                if let shouldNavigate = result as? NSNumber,
                    shouldNavigate.boolValue
                {
                    showSdk = false
                }
            }, rejecter: { code, message, error in
                print("navAway Error: \(String(describing: code)) - \(String(describing: message))")
            })
        }
    }
}

struct PaciolanViewRepresentable: UIViewControllerRepresentable {
    
    var controller: PaciolanSDKViewController
    

    func makeUIViewController(context: Context) -> PaciolanSDKViewController {
        controller.setTokenListener { token in
            print("TOKEN: \(String(describing: token))")
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: PaciolanSDKViewController, context: Context) {
        print("updateUIViewController Test")
    }
    
}
