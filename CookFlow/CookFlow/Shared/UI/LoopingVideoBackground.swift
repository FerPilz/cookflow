//
//  LoopingVideoBackground.swift
//  CookFlow
//
//  Created by Codex on 2/12/26.
//

import AVFoundation
import SwiftUI
import UIKit

struct LoopingVideoBackground: UIViewRepresentable {
    let resourceName: String?
    let fileExtension: String

    init(resourceName: String?, fileExtension: String = "mp4") {
        self.resourceName = resourceName
        self.fileExtension = fileExtension
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> PlayerContainerView {
        let view = PlayerContainerView()
        configure(view: view, coordinator: context.coordinator)
        return view
    }

    func updateUIView(_ uiView: PlayerContainerView, context: Context) {
        configure(view: uiView, coordinator: context.coordinator)
    }

    static func dismantleUIView(_ uiView: PlayerContainerView, coordinator: Coordinator) {
        coordinator.clearLoopObserver()
        coordinator.player?.pause()
        coordinator.player = nil
        uiView.playerLayer.player = nil
    }

    private func configure(view: PlayerContainerView, coordinator: Coordinator) {
        guard
            let resourceName,
            let url = Bundle.main.url(forResource: resourceName, withExtension: fileExtension)
        else {
            coordinator.clearLoopObserver()
            coordinator.player?.pause()
            coordinator.player = nil
            view.playerLayer.player = nil
            view.backgroundColor = UIColor(DesignSystem.Colors.backgroundNearBlack)
            return
        }

        if coordinator.currentURL == url, let player = coordinator.player {
            view.playerLayer.player = player
            view.backgroundColor = .clear
            return
        }

        coordinator.clearLoopObserver()

        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        player.isMuted = true
        player.actionAtItemEnd = .none
        player.play()

        view.playerLayer.player = player
        view.backgroundColor = .clear

        coordinator.player = player
        coordinator.currentURL = url
        coordinator.observeLoop(for: item, player: player)
    }
}

extension LoopingVideoBackground {
    final class Coordinator {
        var player: AVPlayer?
        var currentURL: URL?
        private var loopObserver: NSObjectProtocol?

        func observeLoop(for item: AVPlayerItem, player: AVPlayer) {
            loopObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: item,
                queue: .main
            ) { _ in
                player.seek(to: .zero)
                player.play()
            }
        }

        func clearLoopObserver() {
            if let loopObserver {
                NotificationCenter.default.removeObserver(loopObserver)
                self.loopObserver = nil
            }
        }
    }
}

final class PlayerContainerView: UIView {
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        guard let layer = self.layer as? AVPlayerLayer else {
            fatalError("Expected AVPlayerLayer")
        }
        return layer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = .resizeAspectFill
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    LoopingVideoBackground(resourceName: nil, fileExtension: "mp4")
}
