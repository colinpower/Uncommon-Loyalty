//
//  ReferProductCarousel.swift
//  Uncommon Loyalty (iOS)
//
//  Created by Colin Power on 9/4/22.
//

import SwiftUI

struct ReferProductCarousel: View {
    
    //Environment
    @EnvironmentObject var viewModel: AppViewModel

    //ViewModels
    @ObservedObject var reviewsViewModel = ReviewsViewModel()
    @ObservedObject var rewardsProgramViewModel = RewardsProgramViewModel()

    //State
    @State var indexOfCurrentReferPage:Int = 0
    
    @State var isShowingContactsList:Bool = false
    @State var selectedContact:[String] = ["", "", "", ""]  // ID, first name, last name, phone number
    
    //@State var userSuggestedCode:String = ""
    @State var userAcceptedCode:String = ""
    
    @State var userSelectedColor:Color = .gray
        
    //Binding
    @Binding var isShowingReferExperience:Bool
    
    //Required variables
    var screenWidth:CGFloat = UIScreen.main.bounds.width     //this should be 428 for an iPhone 12 Pro Max
    var totalHeaderHeight:CGFloat = CGFloat(104) + CGFloat(UIScreen.main.bounds.width / 1.6)
    var item: Items
    
    var arrayOfReferralPrompts: [String] = ["Who's getting this discount?!", "Make a discount code for ", "Brighten it up! Select a color", "Ta-da! Send it"]   //eventually will just pull from the viewmodel for this
    
    
    
    @State var imageString = "AthleisureLA-Gold-Discount"
    
    
    
    var body: some View {
        
        //MARK: The VStack containing the entire REFER flow
        VStack(alignment: .leading, spacing: 0) {
            
            //MARK: HEADER (84 height)
            VStack(alignment: .center, spacing: 0) {
                
                //The top bar
                HStack(alignment: .center) {
                    
                    Label {
                        Text("Step \(indexOfCurrentReferPage+1)")
                            .font(.system(size: 23, weight: .semibold))
                            .foregroundColor(Color("Dark1"))
                    } icon: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("ReferPurple"))
                    }
                    
                    Spacer()
                    
                    Button {
                        isShowingReferExperience.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Dark1"))
                            .frame(width: 24, height: 24)
                    }
                    
                }.padding(.horizontal)
                .padding(.top, 60)
                .padding(.bottom, 20)
                .frame(maxWidth: screenWidth, maxHeight: 104)


            }
            .frame(width: screenWidth, height: 104)
            
            
            //MARK: CARD (SCREENWIDTH / 1.6 is height)
            if userSelectedColor == .gray {
                CustomReferralCard(screenWidth: screenWidth, selectedContact: selectedContact, userAcceptedCode: userAcceptedCode)
            } else {
                TransitionReferralCard(userSelectedColor: userSelectedColor, selectedContact: selectedContact, userAcceptedCode: userAcceptedCode, screenWidth: screenWidth, firstName: selectedContact[1])
                //TransitionReferralCard(screenWidth: screenWidth, firstName: selectedContact[1])
            }

            
            //MARK: CONTENT & HORIZONTAL SCROLLVIEW
            Color.clear.overlay(
                HStack(spacing: 0) {
                    
                    ReferProductStep1(indexOfCurrentReferPage: $indexOfCurrentReferPage, isShowingContactsList: $isShowingContactsList, selectedContact: $selectedContact, item: item, promptForStep1: arrayOfReferralPrompts[0], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep2(userAcceptedCode: $userAcceptedCode, indexOfCurrentReferPage: $indexOfCurrentReferPage, selectedContact: $selectedContact, item: item, promptForStep2: arrayOfReferralPrompts[1], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep3(userSelectedColor: $userSelectedColor, indexOfCurrentReferPage: $indexOfCurrentReferPage, selectedContact: $selectedContact, item: item, promptForStep3: arrayOfReferralPrompts[2], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight)
                    
                    ReferProductStep4(userSelectedColor: $userSelectedColor, selectedContact: $selectedContact, indexOfCurrentReferPage: $indexOfCurrentReferPage, userAcceptedCode: $userAcceptedCode, isShowingReferExperience: $isShowingReferExperience, item: item, promptForStep4: arrayOfReferralPrompts[3], screenWidth: screenWidth, totalHeaderHeight: totalHeaderHeight, imageString: $imageString)
                    
                } , alignment: .leading)
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height - totalHeaderHeight)
            .offset(x: -1 * CGFloat(indexOfCurrentReferPage) * screenWidth)
            
        }
        .ignoresSafeArea()
        .background(Color("Background"))
        .onAppear {
            self.rewardsProgramViewModel.listenForOneRewardsProgram(email: "colinjpower1@gmail.com", companyID: "zKL7SQ0jRP8351a0NnHM")
        }
    }
}





struct CustomReferralCard: View {
    
    var screenWidth:CGFloat
    
    var selectedContact: [String]
    
    var userAcceptedCode: String
    
    @State var shouldRemoveGrayscale:Bool = false
    
    
    // MARK: GlassMorphism Properties
    @State var blurView: UIVisualEffectView = .init()
    @State var defaultBlurRadius: CGFloat = 5
    @State var defaultSaturationAmount: CGFloat = 1.2
    
    
    
    var body: some View {
//        ZStack(alignment: .center) {
//            Color("Dark1").opacity(0.05)
//
//        }
        GlassMorphicCard()
        .padding()
        .frame(width: screenWidth, height: screenWidth / 1.6)
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                //change the colors of the athleisure icon
                withAnimation(.easeIn(duration: 2).delay(0.25)) {
                    shouldRemoveGrayscale = true
                }
                
            }
            
        }
        
        
//        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        
        

           
    }
    
    
    // MARK: GlassMorphism Card
    @ViewBuilder
    func GlassMorphicCard()->some View{
        ZStack{
            CustomBlurView(effect: .systemUltraThinMaterial) { view in
                blurView = view
                if defaultBlurRadius == 0 {
                    defaultBlurRadius = view.gaussianBlurRadius
                    
                }
                if defaultSaturationAmount == 0 {
                    defaultSaturationAmount = view.saturationAmount
                    
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            // MARK: Building Glassmorphic Card
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    .linearGradient(colors: [
                        .white.opacity(0.40),
                        .white.opacity(0.15),
                        .clear
                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .blur(radius: 5)
            
            // MARK: Borders
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .stroke(
                    .linearGradient(colors: [
                        .white.opacity(0.6),
                        .clear,
                        .gray.opacity(0.2),
                        .gray.opacity(0.5)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: 2
                )
        }
        // MARK: Shadows
        .shadow(color: .black.opacity(0.15), radius: 5, x: -10, y: 10)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 10, y: -10)
        .overlay(content: {
            // MARK: Card Content
            CardContent()
                //.animation(.easeIn(duration: 0.5), value: activateGlassMorphism)
        })
//        .padding(.horizontal,25)
//        .frame(height: 220)
    }
    
    @ViewBuilder
    func CardContent()->some View{
        VStack(alignment: .center, spacing: 12) {
            HStack (alignment: .center) {
                
                Image("Athleisure LA")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .cornerRadius(8)
                    .opacity(shouldRemoveGrayscale ? 1.0 : 0.5)
                    .grayscale(shouldRemoveGrayscale ? 0.01 : 1.0)
                
                if shouldRemoveGrayscale {
                    Text("ATHLEISURE LA")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color("ReviewComplementaryBlue"))
                } else {
                    Text("ATHLEISURE LA")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                }
                    //.modifier(CustomModifier(font: .callout))
                
                Spacer()
                
                if shouldRemoveGrayscale {
                    Text("20%")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color("ReviewComplementaryBlue"))
                } else {
                    Text("20%")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
            }.padding(.top, 15)
            
            Spacer()
            
            if userAcceptedCode == "" {
                if shouldRemoveGrayscale {
                    HStack {
                        Spacer()
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.gray)
                        Spacer()
                    }.frame(width: screenWidth * 2 / 3, height: 40)
                } else {
                    HStack {
                        Spacer()
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "asterisk")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.frame(width: screenWidth * 2 / 3, height: 40)
                    
                }
            } else {
                HStack {
                    Spacer()
                    Text(userAcceptedCode.uppercased())
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color("ReviewComplementaryBlue"))
                    Spacer()
                }.frame(width: screenWidth * 2 / 3, height: 40)
                
            }
            
            Spacer()
            
            if selectedContact[1] == "" {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("- - - - - - -")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Text("- - - - - ")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }.padding(.leading)
                    .padding(.bottom, 5)
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(selectedContact[1].uppercased() + " " + selectedContact[2].uppercased())
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("ReviewComplementaryBlue"))
                        Text(selectedContact[3])
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("ReviewComplementaryBlue"))
                    }
                    Spacer()
                }
                .padding(.bottom,5)
            }
        }
        .padding(20)
        .padding(.vertical, 10)
        //.blendMode(.overlay)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
    }
}

// MARK: Custom Modifier Since Most Of the Text Shares Same Modifiers
struct CustomModifier: ViewModifier{
    
    var font: Font
    
    func body(content: Content) -> some View {
        
        content
            .font(font)
            .foregroundColor(.white)
            //.fontWeight(.semibold)
            //.kerning(1.2)
            //.shadow(radius: 15)
            .frame(maxWidth: UIScreen.main.bounds.width , alignment: .leading)
    }
}

// MARK: Custom Blur View
// With The Help of UiVisualEffect View
struct CustomBlurView: UIViewRepresentable{
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView)->()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}


// MARK: Adjusting Blur Radius in UIVisualEffectView
extension UIVisualEffectView{
    // MARK: Steps
    // Extracting Private Class BackDropView Class
    // Then From that View Extracting ViewEffects like Gaussian Blur & Saturation
    // With the Help of this We ca Achevie Glass Morphism
    var backDrop: UIView?{
        // PRIVATE CLASS
        return subView(forClass: NSClassFromString("_UIVisualEffectBackdropView"))
    }
    
    // MARK: Extracting Gaussian Blur From BackDropView
    var gaussianBlur: NSObject?{
        return backDrop?.value(key: "filters", filter: "gaussianBlur")
    }
    // MARK: Extracting Saturation From BackDropView
    var saturation: NSObject?{
        return backDrop?.value(key: "filters", filter: "colorSaturate")
    }
    
    // MARK: Updating Blur Radius And Saturation
    var gaussianBlurRadius: CGFloat{
        get{
            // MARK: We Know The Key For Gaussian Blur = "inputRadius"
            return gaussianBlur?.values?["inputRadius"] as? CGFloat ?? 0
        }
        set{
            gaussianBlur?.values?["inputRadius"] = newValue
            // Updating the Backdrop View with the New Filter Updates
            applyNewEffects()
        }
    }
    
    func applyNewEffects(){
        // MARK: Animating the Change
        UIVisualEffectView.animate(withDuration: 0.5) {
            self.backDrop?.perform(Selector(("applyRequestedFilterEffects")))
        }
    }
    
    var saturationAmount: CGFloat{
        get{
            // MARK: We Know The Key For Gaussian Blur = "inputAmount"
            return saturation?.values?["inputAmount"] as? CGFloat ?? 0
        }
        set{
            saturation?.values?["inputAmount"] = newValue
            applyNewEffects()
        }
    }
}

// MARK: Finding SubView for Class
extension UIView{
    func subView(forClass: AnyClass?)->UIView?{
        return subviews.first { view in
            type(of: view) == forClass
        }
    }
}



// MARK: Custom Key Filtering
extension NSObject{
    // MARK: Key Values From NSOBject
    var values: [String: Any]?{
        get{
            return value(forKeyPath: "requestedValues") as? [String: Any]
        }
        set{
            setValue(newValue, forKeyPath: "requestedValues")
        }
    }
    
    func value(key: String,filter: String)->NSObject?{
        (value(forKey: key) as? [NSObject])?.first(where: { obj in
            return obj.value(forKeyPath: "filterType") as? String == filter
        })
    }
}



struct TransitionReferralCard: View {
    
    var userSelectedColor:Color
    
    var selectedContact:[String]
    
    var userAcceptedCode:String
    
    var screenWidth: CGFloat
    
    var firstName:String
    
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                        .foregroundColor(userSelectedColor)
                        .clipped()
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 3)
                        
//                    userSelectedColor.frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
//                        .clipped()
//                        .cornerRadius(8)
                    VStack(spacing:0) {
                        HStack (alignment: .center) {
                        
                        Image("Athleisure LA")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .cornerRadius(8)
                        
                        Text("ATHLEISURE LA")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("20%")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                    }.padding(.top, 15)
                
                    Spacer()
                
                    HStack {
                        Spacer()
                        Text(userAcceptedCode.uppercased())
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }.frame(width: screenWidth * 2 / 3, height: 40)
                
                    Spacer()
                
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(selectedContact[1].uppercased() + " " + selectedContact[2].uppercased())
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            Text(selectedContact[3])
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.bottom,5)
                    }
                    .padding(.horizontal)
                    .frame(width: geometry.size.width, height: geometry.size.width / 1.6, alignment: .center)
                        .clipped()
                        .cornerRadius(8)
                }
                
            }
            .frame(maxWidth: screenWidth, maxHeight: UIScreen.main.bounds.width / 1.6)
            
            .padding(.horizontal)
            
            Spacer()
        }.frame(width: screenWidth, height: UIScreen.main.bounds.width / 1.6)

    
        
        
    }
    
}
