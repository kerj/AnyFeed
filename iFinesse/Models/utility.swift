//
//  Utility.swift
//  iFinesse
//
//  Created by Justin Kerntz on 6/12/25.
//

extension Optional {
    func or(_ defaultValue: Wrapped) -> Wrapped {
        self ?? defaultValue
    }
}
