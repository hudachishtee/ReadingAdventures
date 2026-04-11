//import SwiftUI
//
//struct StoryPreviewView: View {
//    
//    let story: Story
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        
//        ZStack {
//            
//            Color(.systemGray6)
//                .ignoresSafeArea()
//            
//            VStack {
//                
//                Text("StoryPreview")
//                    .font(.system(size: 16, weight: .medium))
//                    .foregroundColor(.gray)
//                    .padding(.top, 8)
//                
//                Spacer()
//                
//                // MARK: MAIN CARD
//                ZStack(alignment: .top) {
//                    
//                    // IMAGE
//                    Image(story.previewImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 420)
//                        .clipped()
//                    
//                    // TOP BAR
//                    HStack {
//                        
//                        Button {
//                            dismiss()
//                        } label: {
//                            Image(systemName: "chevron.left")
//                                .font(.system(size: 14, weight: .bold))
//                                .foregroundColor(.black)
//                                .padding(10)
//                                .background(.ultraThinMaterial)
//                                .clipShape(Circle())
//                        }
//                        
//                        Spacer()
//                        
//                        Text("Book Detail")
//                            .font(.system(size: 13, weight: .medium))
//                            .padding(.horizontal, 14)
//                            .padding(.vertical, 5)
//                            .background(.ultraThinMaterial)
//                            .clipShape(Capsule())
//                        
//                        Spacer()
//                        
//                        Circle().fill(Color.clear).frame(width: 36)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.top, 14)
//                    
//                    
//                    // ✅ FIXED FLOATING CARD
//                    VStack {
//                        Spacer()
//                        
//                        VStack(alignment: .leading, spacing: 14) {
//                            
//                            Text(story.title)
//                                .font(.system(size: 20, weight: .bold))
//                                .foregroundColor(.black)
//                            
//                            Text(story.description)
//                                .font(.system(size: 15))
//                                .foregroundColor(.black.opacity(0.85))
//                                .lineSpacing(6)
//                            
//                            Button {
//                                // navigate later
//                            } label: {
//                                Text("READ NOW")
//                                    .font(.system(size: 14, weight: .bold))
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity)
//                                    .padding(.vertical, 14)
//                                    .background(
//                                        LinearGradient(
//                                            colors: [
//                                                Color.yellow,
//                                                Color.orange
//                                            ],
//                                            startPoint: .top,
//                                            endPoint: .bottom
//                                        )
//                                    )
//                                    .cornerRadius(12)
//                            }
//                            .padding(.top, 8)
//                        }
//                        .padding(22)
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            LinearGradient(
//                                colors: [
//                                    Color.yellow.opacity(0.95),
//                                    Color.orange.opacity(0.9)
//                                ],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            )
//                        )
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                        )
//                        .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 6)
//                        .padding(.horizontal, 18)
//                        .padding(.bottom, 16) // ✅ KEY FIX
//                    }
//                }
//                .frame(height: 500) // ✅ Taller card
//                .clipShape(
//                    RoundedRectangle(cornerRadius: 30, style: .continuous)
//                )
//                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 8)
//                
//                Spacer()
//            }
//            .padding(.horizontal, 16)
//        }
//    }
//}
//
//#Preview {
//    StoryPreviewView(story: sampleStories[0])
//}
