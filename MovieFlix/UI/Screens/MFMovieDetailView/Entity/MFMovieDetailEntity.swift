//
//  MFMovieDetailEntity.swift
//  MovieFlix
//
//  Created by Doni on 30/01/23.
//

import UIKit

public struct MFMovieDetailEntity {
    public let id: Int
    public let title: String
    public let backdropPath: String?
    public let overview: String
    public let runtime: Int?
    public let releaseDate: String?
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    public let credits: MovieCredit?
    
    var cast: [MovieCastEntity]? {
        credits?.cast
    }
    
    var crew: [MovieCrewEntity]? {
        credits?.crew
    }
    
    var directors: [MovieCrewEntity]? {
        crew?.filter { $0.job.lowercased() == "director"  }
    }
    
    var producers: [MovieCrewEntity]? {
        crew?.filter { $0.job.lowercased() == "producer"  }
    }
    
    var screenWriters: [MovieCrewEntity]? {
        crew?.filter { $0.job.lowercased() == "story"  }
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = String.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return MFMovieDetailEntity.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return MFMovieDetailEntity.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
}

public struct MovieCredit: Codable {
    public let id: Int
    public let cast: [MovieCastEntity]
    public let crew: [MovieCrewEntity]
}

public struct MovieCastEntity: Codable {
    public let character: String
    public let name: String
}

public struct MovieCrewEntity: Codable {
    public let job: String
    public let name: String
}
