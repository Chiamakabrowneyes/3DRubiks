import SwiftUI
import Foundation
import UIKit
import SceneKit
import PlaygroundSupport


struct Content: App {
    var body: some Scene {
        WindowGroup {
            ContentsView()
        }
    }
}

struct BottomBarView: View {
    var body: some View {
        HStack {
            Button(action: {
                // Your action here
            }) {
                Image(systemName: "gear")
                Text("Settings")
            }
            Spacer()
            Button(action: {
                // Your action here
            }) {
                Image(systemName: "info.circle")
                Text("About")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Customize your background
    }
}

struct ContentsView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) {
                NavigationView {
                    ContentView()
                        .navigationTitle("Rubiks")
                }
                .tabItem {
                    Label("Rubiks", systemImage: "cube")
                }
                .tag(0)
                
                NavigationView {
                    ZStack{
                        SecondLayerView()
                            .navigationTitle("Solve 2nd Layer")
                    }
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Gray"))
                }
                .tabItem {
                    Label("Instructions", systemImage: "bubble.left")
                }
                .tag(1)
                
                NavigationView {
                    ZStack{
                        ThirdLayerView()
                            .navigationTitle("Instructions")
                    }
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Gray"))
                }
                .tabItem {
                    Label("Solve 3rd Layer", systemImage: "bubble.left")
                }
                .tag(2)
            }
            BottomBarView() // This is your static bottom bar
        }
    }
}


struct ContentView: View {
    @ObservedObject var cubeModel: CubeModel = CubeModel()
    @State private var show2ndLayer = false // State to control navigation
    @State private var show3rdLayer = false
    var body: some View {
        NavigationView {
            ZStack {
                // Cube Scene Background
                GeometryReader { geometry in
                    ScreneKitView(scene: createScene(), size: geometry.size)
                        .edgesIgnoringSafeArea(.all)
                        .gesture(DragGesture().onEnded { value in
                            handleSwipe(value: value)
                        })
                }
                
                // Static Button Overlay
                VStack {
                    Spacer() // Pushes the button to the bottom
                    
                    Button(action: {
                        show2ndLayer = true // Triggers navigation
                    }) {
                        Text("Solve 2nd Layer")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding() // Adds padding around the button at the bottom
                    
                    Button(action: {
                        show3rdLayer = true // Triggers navigation
                    }) {
                        Text("Solve 3rd Layer")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: SecondLayerView(), isActive: $show2ndLayer) { EmptyView() }.hidden()
                    NavigationLink(destination: ThirdLayerView(), isActive: $show3rdLayer) { EmptyView() }.hidden()
                }
            }
        }
    }
    
    func handleSwipe(value: DragGesture.Value) {
        let swipeThreshold: CGFloat = 5.0 // Minimum distance for a swipe to be recognized
        let horizontalSwipeDistance = value.location.x - value.startLocation.x
        let verticalSwipeDistance = value.location.y - value.startLocation.y
        
        if abs(horizontalSwipeDistance) > swipeThreshold || abs(verticalSwipeDistance) > swipeThreshold {
            if abs(horizontalSwipeDistance) > abs(verticalSwipeDistance) {
                // Horizontal swipe
                if horizontalSwipeDistance > 0 {
                    print("Right swipe detected")
                    cubeModel.rotateLayer(direction: .right)
                } else {
                    print("Left swipe detected")
                    cubeModel.rotateLayer(direction: .left)
                }
            } else {
                // Vertical swipe
                if verticalSwipeDistance > 0 {
                    print("Down swipe detected")
                    cubeModel.rotateLayer(direction: .down)
                } else {
                    print("Up swipe detected")
                    // Rotate the cube or a layer upwards
                    cubeModel.rotateLayer(direction: .up)
                }
            }
        }
    }
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
        let squareSize: CGFloat = 1.0
        let spacing: CGFloat = 0 // Spacing between the pieces
        let totalSize = squareSize + spacing
        
        // Colors for each face of the cube
        let faceColors = [
            UIColor.red,    // Front
            UIColor.green,  // Back
            UIColor.blue,   // Left
            UIColor.orange, // Right
            UIColor.white,  // Top
            UIColor.yellow  // Bottom
        ]
        
        // Calculate start offset to center the cube in the scene
        let startOffset = -(totalSize * 2) / 2
        
        // Iterate over x, y, z to create a 3x3x3 structure
        for x in 0..<3 {
            for y in 0..<3 {
                for z in 0..<3 {
                    let box = SCNBox(width: squareSize, height: squareSize, length: squareSize, chamferRadius: 0.1)
                    
                    // Create a material for each face of the cube piece
                    var materials = [SCNMaterial]()
                    for color in faceColors {
                        let material = SCNMaterial()
                        material.diffuse.contents = color
                        materials.append(material)
                    }
                    
                    // Assign materials to the box
                    box.materials = materials
                    
                    let node = SCNNode(geometry: box)
                    node.position = SCNVector3(
                        Float(startOffset + CGFloat(x) * totalSize),
                        Float(startOffset + CGFloat(y) * totalSize),
                        Float(startOffset + CGFloat(z) * totalSize)
                    )
                    
                    scene.rootNode.addChildNode(node)
                }
            }
        }
        
        // Configure the camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 10) // Adjust as needed to fit the cube in view
        scene.rootNode.addChildNode(cameraNode)
        
        return scene
    }
}


struct ScreneKitView: UIViewRepresentable {
    let scene: SCNScene
    let size: CGSize
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView(frame: CGRect(origin: .zero, size: size), options: nil)
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        view.backgroundColor = UIColor.gray
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
}

var pieceNodes: [String: SCNNode] = [:]

class CubeModel: ObservableObject {
    @Published var pieces: [CubePiece] = []
    // Maps cube piece positions to their corresponding SCNNode
    
    
    init() {
        self.pieces = initializeCube()
    }
    
    private func initializeCube() -> [CubePiece] {
        var pieces: [CubePiece] = []
        
        // Define default colors for each side for demonstration
        let colorScheme = [
            UIColor.red,    // Front
            UIColor.green,  // Back
            UIColor.blue,   // Left
            UIColor.orange, // Right
            UIColor.white,  // Top
            UIColor.yellow  // Bottom
        ]
        
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    let position = SCNVector3(x, y, z)
                    let id = "x\(x)y\(y)z\(z)"
                    var colors = CubePieceColor()
                    // Determine colors based on position; this is simplified
                    if x == 1 { colors.right = colorScheme[3] }
                    if x == -1 { colors.left = colorScheme[2] }
                    if y == 1 { colors.top = colorScheme[4] }
                    if y == -1 { colors.bottom = colorScheme[5] }
                    if z == 1 { colors.front = colorScheme[0] }
                    if z == -1 { colors.back = colorScheme[1] }
                    
                    let type: CubePieceType = (x != 0 && y != 0 && z != 0) ? .corner : ((x != 0 && y != 0) || (x != 0 && z != 0) || (y != 0 && z != 0)) ? .edge : .center
                    let piece = CubePiece(id: id, type: type, colors: colors, position: position, orientation: SCNQuaternion(0, 0, 0, 1))
                    pieces.append(piece)
                }
            }
        }
        
        return pieces
    }
}


extension CubeModel {
    
    enum RotationDirection {
        case up, down, left, right
    }
    
    func rotateLayer(direction: RotationDirection) {
        switch direction {
        case .up:
            rotateTopLayerClockwise()
        case .down:
            rotateBottomLayerClockwise()
        case .left:
            rotateLeftLayerClockwise()
        case .right:
            rotateRightLayerClockwise()
        }
        
        // Update the SceneKit scene accordingly
        updateScene()
    }
    func rotateLeftLayerClockwise() {
        // Temporary storage for the new positions of the pieces in the left layer
        var newPositions = [SCNVector3]()
        
        // Collect new positions for each piece in the left layer
        for piece in pieces where piece.position.x == -1 {
            let oldPosition = piece.position
            // For a clockwise rotation, the y position becomes the negative z position, and the z position becomes the y position
            let newPosition = SCNVector3(oldPosition.x, -oldPosition.z, oldPosition.y)
            newPositions.append(newPosition)
        }
        
        // Update the positions of the pieces in the left layer
        for (index, piece) in pieces.enumerated().filter({ $0.element.position.x == -1 }) {
            pieces[index].position = newPositions[index]
        }
    }
    
    private func rotateRightLayerClockwise() {
        var newPositions = [SCNVector3]()
        
        for piece in pieces where piece.position.x == 1 {
            let oldPosition = piece.position
            let newPosition = SCNVector3(oldPosition.x, -oldPosition.z, oldPosition.y)
            newPositions.append(newPosition)
        }
        
        for (index, piece) in pieces.enumerated().filter({ $0.element.position.x == 1 }) {
            pieces[index].position = newPositions[index]
        }
    }
    
    
    private func rotateBottomLayerClockwise() {
        var newPositions = [SCNVector3]()
        
        for piece in pieces where piece.position.y == -1 {
            let oldPosition = piece.position
            let newPosition = SCNVector3(oldPosition.z, oldPosition.y, -oldPosition.x)
            newPositions.append(newPosition)
        }
        
        for (index, piece) in pieces.enumerated().filter({ $0.element.position.y == -1 }) {
            pieces[index].position = newPositions[index]
        }
    }
    
    
    private func rotateTopLayerClockwise() {
        var newPositions = [SCNVector3]()
        
        for piece in pieces where piece.position.y == 1 {
            let oldPosition = piece.position
            let newPosition = SCNVector3(-oldPosition.z, oldPosition.y, oldPosition.x)
            newPositions.append(newPosition)
        }
        
        for (index, piece) in pieces.enumerated().filter({ $0.element.position.y == 1 }) {
            pieces[index].position = newPositions[index]
        }
    }
    
    func updateScene() {
        for piece in pieces {
            if let node = pieceNodes[piece.id] {
                // Update the node's position and orientation
                node.position = piece.position
                node.orientation = piece.orientation
            }
        }
    }
    
    
    func mapPiecesToNodes(scene: SCNScene) {
        for piece in pieces {
            // Assuming each piece's SCNNode is named with the piece's unique identifier
            if let node = scene.rootNode.childNode(withName: piece.id, recursively: true) {
                pieceNodes[piece.id] = node
            }
        }
    }
}

enum CubePieceType {
    case center, edge, corner
}

struct CubePieceColor {
    var front: UIColor?
    var back: UIColor?
    var left: UIColor?
    var right: UIColor?
    var top: UIColor?
    var bottom: UIColor?
    
    // Initialize with default colors for simplicity; adjust as needed
    init(front: UIColor? = nil, back: UIColor? = nil, left: UIColor? = nil, right: UIColor? = nil, top: UIColor? = nil, bottom: UIColor? = nil) {
        self.front = front
        self.back = back
        self.left = left
        self.right = right
        self.top = top
        self.bottom = bottom
    }
}

struct CubePiece {
    let id: String
    let type: CubePieceType
    var colors: CubePieceColor
    var position: SCNVector3
    var orientation: SCNQuaternion
}



