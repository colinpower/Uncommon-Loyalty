////
////  ReferralCard.swift
////  Uncommon Loyalty (iOS)
////
////  Created by Colin Power on 9/4/22.
////
//
//import SwiftUI
//
//struct ReferralCard: View {
//    
//    
//    // MARK: GlassMorphism Properties
//    @State var blurView: UIVisualEffectView = .init()
//    @State var defaultBlurRadius: CGFloat = 10
//    @State var defaultSaturationAmount: CGFloat = 1.8
//    
//    //@State var activateGlassMorphism: Bool = false
//    
//    
//    
//    var body: some View {
//        
//        
//        GlassMorphicCard()
//        
//    }
//        
//        
////        ZStack{
////            Color("Dark2")
////                .ignoresSafeArea()
////
////            Image("TopCircle")
////                .offset(x: 150, y: -90)
////
////            Image("BottomCircle")
////                .offset(x: -150, y: 90)
////
////            Image("CenterCircle")
////                .offset(x: -40, y: -100)
//            
//            
//            
////            // MARK: Slider to show Demo
////            Toggle("Activate Glass Morphism", isOn: $activateGlassMorphism)
////                .font(.title3)
////                .frame(maxHeight: UIScreen.main.bounds.height, alignment: .bottom)
////                .padding(15)
////                .onChange(of: activateGlassMorphism) { newValue in
////                    // Changing Blur Radius And Saturation
////                    blurView.gaussianBlurRadius = (activateGlassMorphism ? 10 : defaultBlurRadius)
////                    blurView.saturationAmount = (activateGlassMorphism ? 1.8 : defaultSaturationAmount)
////                }
//                
//                
////        }
//
//    
//    // MARK: GlassMorphism Card
//    @ViewBuilder
//    func GlassMorphicCard()->some View{
//        ZStack{
//            CustomBlurView(effect: .systemUltraThinMaterialDark) { view in
//                blurView = view
//                if defaultBlurRadius == 0{defaultBlurRadius = view.gaussianBlurRadius}
//                if defaultSaturationAmount == 0{defaultSaturationAmount = view.saturationAmount}
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
//            
//            // MARK: Building Glassmorphic Card
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .fill(
//                    .linearGradient(colors: [
//                        .white.opacity(0.25),
//                        .white.opacity(0.05),
//                        .clear
//                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
//                )
//                .blur(radius: 5)
//            
//            // MARK: Borders
//            RoundedRectangle(cornerRadius: 25, style: .continuous)
//                .stroke(
//                    .linearGradient(colors: [
//                        .white.opacity(0.6),
//                        .clear,
//                        .purple.opacity(0.2),
//                        .purple.opacity(0.5)
//                    ], startPoint: .topLeading, endPoint: .bottomTrailing),
//                    lineWidth: 2
//                )
//        }
//        // MARK: Shadows
//        .shadow(color: .black.opacity(0.15), radius: 5, x: -10, y: 10)
//        .shadow(color: .black.opacity(0.15), radius: 5, x: 10, y: -10)
//        .overlay(content: {
//            // MARK: Card Content
//            CardContent()
//                //.animation(.easeIn(duration: 0.5), value: activateGlassMorphism)
//        })
//        .padding(.horizontal,25)
//        .frame(height: 220)
//    }
//    
//    @ViewBuilder
//    func CardContent()->some View{
//        VStack(alignment: .leading, spacing: 12) {
//            HStack{
//                Image("Athleisure LA")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 32, height: 32)
//                    .cornerRadius(8)
//                    .opacity(0.5)
//                    .grayscale(1.0)
//                
//                Text("MEMBERSHIP")
//                    .modifier(CustomModifier(font: .callout))
//                
//                Spacer()
//                
//                Text("20%")
//                    .font(.system(size: 32, weight: .bold, design: .rounded))
//                
//            }
//            .offset(y: -5)
//            
//            Spacer()
//            
//            Text("BALAJI VENKATESH")
//                .modifier(CustomModifier(font: .title3))
//            
//            Text("KAVSOFT")
//                .modifier(CustomModifier(font: .callout))
//        }
//        .padding(20)
//        .padding(.vertical,10)
//        .blendMode(.overlay)
//        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
//    }
//}
//
//// MARK: Custom Modifier Since Most Of the Text Shares Same Modifiers
//struct CustomModifier: ViewModifier{
//    
//    var font: Font
//    
//    func body(content: Content) -> some View {
//        
//        content
//            .font(font)
//            .foregroundColor(.white)
//            //.fontWeight(.semibold)
//            //.kerning(1.2)
//            //.shadow(radius: 15)
//            .frame(maxWidth: UIScreen.main.bounds.width , alignment: .leading)
//    }
//}
//
//// MARK: Custom Blur View
//// With The Help of UiVisualEffect View
//struct CustomBlurView: UIViewRepresentable{
//    var effect: UIBlurEffect.Style
//    var onChange: (UIVisualEffectView)->()
//    
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//        DispatchQueue.main.async {
//            onChange(uiView)
//        }
//    }
//}
//
//// MARK: Adjusting Blur Radius in UIVisualEffectView
//extension UIVisualEffectView{
//    // MARK: Steps
//    // Extracting Private Class BackDropView Class
//    // Then From that View Extracting ViewEffects like Gaussian Blur & Saturation
//    // With the Help of this We ca Achevie Glass Morphism
//    var backDrop: UIView?{
//        // PRIVATE CLASS
//        return subView(forClass: NSClassFromString("_UIVisualEffectBackdropView"))
//    }
//    
//    // MARK: Extracting Gaussian Blur From BackDropView
//    var gaussianBlur: NSObject?{
//        return backDrop?.value(key: "filters", filter: "gaussianBlur")
//    }
//    // MARK: Extracting Saturation From BackDropView
//    var saturation: NSObject?{
//        return backDrop?.value(key: "filters", filter: "colorSaturate")
//    }
//    
//    // MARK: Updating Blur Radius And Saturation
//    var gaussianBlurRadius: CGFloat{
//        get{
//            // MARK: We Know The Key For Gaussian Blur = "inputRadius"
//            return gaussianBlur?.values?["inputRadius"] as? CGFloat ?? 0
//        }
//        set{
//            gaussianBlur?.values?["inputRadius"] = newValue
//            // Updating the Backdrop View with the New Filter Updates
//            applyNewEffects()
//        }
//    }
//    
//    func applyNewEffects(){
//        // MARK: Animating the Change
//        UIVisualEffectView.animate(withDuration: 0.5) {
//            self.backDrop?.perform(Selector(("applyRequestedFilterEffects")))
//        }
//    }
//    
//    var saturationAmount: CGFloat{
//        get{
//            // MARK: We Know The Key For Gaussian Blur = "inputAmount"
//            return saturation?.values?["inputAmount"] as? CGFloat ?? 0
//        }
//        set{
//            saturation?.values?["inputAmount"] = newValue
//            applyNewEffects()
//        }
//    }
//}
//
//
//// MARK: Finding SubView for Class
//extension UIView{
//    func subView(forClass: AnyClass?)->UIView?{
//        return subviews.first { view in
//            type(of: view) == forClass
//        }
//    }
//}
//
//// MARK: Custom Key Filtering
//extension NSObject{
//    // MARK: Key Values From NSOBject
//    var values: [String: Any]?{
//        get{
//            return value(forKeyPath: "requestedValues") as? [String: Any]
//        }
//        set{
//            setValue(newValue, forKeyPath: "requestedValues")
//        }
//    }
//    
//    func value(key: String,filter: String)->NSObject?{
//        (value(forKey: key) as? [NSObject])?.first(where: { obj in
//            return obj.value(forKeyPath: "filterType") as? String == filter
//        })
//    }
//}
//
//
