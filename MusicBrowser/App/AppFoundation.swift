//
// AppFoundation.swift
// MusicBrowser
//
        
protocol AppFoundation {

    /// The common interface for presenting HUDs.
    var hudPresenter: AppHUDPresenter { get }

    /// The common interface for all services used by the application.
    var services: AppServices { get }
}
