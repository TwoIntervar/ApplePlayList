//
//  AppleMusicAPI.swift
//  Mapli
//
//  Created by woo0 on 2022/07/30.
//

import Foundation
import StoreKit

class AppleMusicAPI {
	let developerToken = Bundle.main.apiKey
	
	func fetchUserToken() async throws -> String {
		return try await SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken)
	}
	
	func fetchPlaylists(userToken: String) async throws -> [Playlist] {
		guard let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists") else { throw NetworkError.invalidURL }
		var musicRequest = URLRequest(url: musicURL)
		musicRequest.httpMethod = "GET"
		musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
		musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
		
		let (data, _) = try await URLSession.shared.data(for: musicRequest)
		let playlist = try JSONDecoder().decode(PlaylistDatum.self, from: data)
		return playlist.data
	}
	
	func fetchSongs(userToken: String, id: String) async throws -> [Song] {
		guard let musicURL = URL(string: "https://api.music.apple.com/v1/me/library/playlists/\(id)/tracks") else { throw NetworkError.invalidURL }
		var musicRequest = URLRequest(url: musicURL)
		musicRequest.httpMethod = "GET"
		musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
		musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
		
		let (data, _) = try await URLSession.shared.data(for: musicRequest)
		let song = try JSONDecoder().decode(SongDatum.self, from: data)
		return song.data
	}
}