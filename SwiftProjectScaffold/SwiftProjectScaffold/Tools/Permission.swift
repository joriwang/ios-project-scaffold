//
//  Permission.swift
//  ChongYaProjectScaffold
//
//  Created by Jori on 2021/11/9.
//

import Foundation
import RxSwift
import SPPermissions

final class Permission {
    static var cameraAuthorization: SPCameraPermission {
        return SPPermissions.Permission.camera
    }

    static func request(_ list: [SPPermissions.Permission], withController: UIViewController) -> Observable<[SPPermissions.Permission]> {

        let wrapper = PermissionRequstWrapper(withPermissios: list, controller: withController)

        return wrapper.observable
    }
}

private class PermissionRequstWrapper: SPPermissionsDelegate {

    private static var cache = [String: PermissionRequstWrapper]()

    private let permissions: [SPPermissions.Permission]
    private var determinedPermissions = [SPPermissions.Permission]()
    private let subject = PublishSubject<[SPPermissions.Permission]>()
    var observable: Observable<[SPPermissions.Permission]> {
        return subject.asObservable()
    }

    private let cacheKey: String

    init(withPermissios: [SPPermissions.Permission], controller: UIViewController) {
        self.permissions = withPermissios
        self.cacheKey = UUID().uuidString
        let spController = SPPermissions.native(withPermissios)
        spController.delegate = self
        spController.present(on: controller)

        PermissionRequstWrapper.cache[self.cacheKey] = self
    }

    func didAllowPermission(_ permission: SPPermissions.Permission) {
        addDeterminedPermission(permission)
    }

    func didDeniedPermission(_ permission: SPPermissions.Permission) {
        addDeterminedPermission(permission)
    }

    func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        permissions.forEach { per in
            addDeterminedPermission(per)
        }
    }

    private func addDeterminedPermission(_ permission: SPPermissions.Permission) {
        determinedPermissions.append(permission)
        if determinedPermissions.count == permissions.count {
            PermissionRequstWrapper.cache.removeValue(forKey: self.cacheKey)
            subject.onNext(determinedPermissions)
            subject.onCompleted()
        }
    }
}
