import Vapor

/// Register your application's routes here.

// routes are registered in configure.swift
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("health") { req in
        return "We are up!"
    }
}
