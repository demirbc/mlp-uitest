//
//  Routeable.swift
//  MyLittlePony
//
//  Created by Berat Demir on 8.12.2024.
//


@MainActor
protocol Routeable {

    associatedtype R: Router

    var presentationRouter: PresentationRouter<R> { get }

    var navigationRouter: NavigationRouter { get }
}

extension Routeable {

    func push(_ route: R.SegueRoute) {
        navigationRouter.push(route)
    }

    func replaceTop(_ route: R.SegueRoute) {
        var path = navigationRouter.path
        path.removeLast()
        path.append(route)
        navigationRouter.path = path
    }

    func pop() {
        navigationRouter.pop()
    }

    func endFlowBranch() {
        presentationRouter.dismissPresented()
    }

    func present(_ route: R.PresentRoute) {
        presentationRouter.present(route: route)
    }
}
