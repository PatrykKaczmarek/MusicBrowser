//
// AppHUDPresenter.swift
// MusicBrowser
//

protocol AppHUDPresenter {

    /// Indicates whether hud is currently being presented.
    var presentsHUD: Bool { get }

    /// Shows HUD with an optional message. Does nothing if another HUD is active.
    func show(message: String?)

    /// Hides HUD. Does nothing if HUD is not presented yet.
    func hide()
}
