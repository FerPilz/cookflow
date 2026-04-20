//
//  LoopingVideoView.swift
//  CookFlow
//
//  Created by Codex on 2/16/26.
//

import SwiftUI
import AVFoundation
import AVKit

struct LoopingVideoView: UIViewRepresentable {
    let resourceName: String
    let resourceExtension: String
    let videoGravity: AVLayerVideoGravity

    init(resourceName: String, resourceExtension: String = "mp4", videoGravity: AVLayerVideoGravity = .resizeAspectFill) {
        self.resourceName = resourceName
        self.resourceExtension = resourceExtension
        self.videoGravity = videoGravity
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> PlayerView {
        let view = PlayerView()
        view.playerLayer.videoGravity = videoGravity

        guard let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExtension) else {
            assertionFailure("Missing bundled video: \(resourceName).\(resourceExtension)")
            return view
        }

        let item = AVPlayerItem(asset: AVAsset(url: url))
        let player = AVQueuePlayer()
        player.isMuted = true
        player.actionAtItemEnd = .none

        context.coordinator.player = player
        context.coordinator.looper = AVPlayerLooper(player: player, templateItem: item)

        view.playerLayer.player = player
        player.play()
        return view
    }

    func updateUIView(_ uiView: PlayerView, context: Context) {
        // no-op (avoid recreating player)
    }

    static func dismantleUIView(_ uiView: PlayerView, coordinator: Coordinator) {
        coordinator.player?.pause()
        uiView.playerLayer.player = nil
        coordinator.looper = nil
        coordinator.player = nil
    }

    final class Coordinator {
        var player: AVQueuePlayer?
        var looper: AVPlayerLooper?
    }

    final class PlayerView: UIView {
        override static var layerClass: AnyClass { AVPlayerLayer.self }
        var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
    }
}
