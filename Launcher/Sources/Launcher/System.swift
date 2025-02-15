//
//  System.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Foundation

/// A system type that a game runs on.
public enum System: Identifiable, Codable, CaseIterable {
    /// A native app package.
    case nativeApp
    /// A native Mach-O executable.
    case nativeExecutable
    /// A Windows EXE file.
    case windowsExecutable

    public var id: Self { self }
    
    public var displayName: String {
        switch self {
        case .nativeApp:
            return "Native App"
        case .nativeExecutable:
            return "Native Executable"
        case .windowsExecutable:
            return "Windows Executable"
        }
    }
}
