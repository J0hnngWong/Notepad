//
//  CommonTools.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/13.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation
import UIKit

class CommonTools<T> {
    
    
    // 因为slice下标的特殊性
    public class func mergeSort(list: Array<T>, condition: ((T, T) -> Bool)) -> Array<T> {
        if list.count < 2 {
            return list
        } else {
            let mid = list.count / 2
            let leftArray = mergeSort(list: Array(list[list.startIndex..<mid]), condition: condition)
            let rightArray = mergeSort(list: Array(list[mid..<list.endIndex]), condition: condition)
            return mergePortion(left: leftArray, right: rightArray, condition: condition)
        }
    }

    private class func mergePortion(left: Array<T>, right: Array<T>, condition: ((T, T) -> Bool)) -> Array<T> {
        
        var resultArr: Array<T> = []
        var leftIndex = left.startIndex
        var rightIndex = right.startIndex
        
        while leftIndex < left.endIndex && rightIndex < right.endIndex {
            if condition(left[leftIndex], right[rightIndex]) {
                resultArr.append(left[leftIndex])
                leftIndex += 1
            } else {
                resultArr.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        if leftIndex < left.endIndex {
            let range = leftIndex..<left.endIndex
            let remainingElements = left[range]
            resultArr.append(contentsOf: remainingElements)
        }
        
        if rightIndex < right.endIndex {
            let range = rightIndex..<right.endIndex
            let remainingElements = right[range]
            resultArr.append(contentsOf: remainingElements)
        }
        return resultArr
    }
    
    
    // 因为slice下标的特殊性
    public class func mergeSortSlice(list: ArraySlice<T>, condition: ((T, T) -> Bool)) -> ArraySlice<T> {
        if list.count < 2 {
            return list
        } else {
            let mid = (list.endIndex + list.startIndex) / 2
            let leftArray = mergeSortSlice(list: list[list.startIndex..<mid], condition: condition)
            let rightArray = mergeSortSlice(list: list[mid..<list.endIndex], condition: condition)
            return mergePortionSlice(left: leftArray, right: rightArray, condition: condition)
        }
    }

    private class func mergePortionSlice(left: ArraySlice<T>, right: ArraySlice<T>, condition: ((T, T) -> Bool)) -> ArraySlice<T> {
        
        var resultArr: ArraySlice<T> = []
        var leftIndex = left.startIndex
        var rightIndex = right.startIndex
        
        while leftIndex < left.endIndex && rightIndex < right.endIndex {
            if condition(left[leftIndex], right[rightIndex]) {
                resultArr.append(left[leftIndex])
                leftIndex += 1
            } else {
                resultArr.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        if leftIndex < left.endIndex {
            let range = leftIndex..<left.endIndex
            let remainingElements = left[range]
            resultArr.append(contentsOf: remainingElements)
        }
        
        if rightIndex < right.endIndex {
            let range = rightIndex..<right.endIndex
            let remainingElements = right[range]
            resultArr.append(contentsOf: remainingElements)
        }
        return resultArr
    }
}

extension CommonTools {
    // UI related
    public class func applicationWindow() -> UIWindow? {
        let windows = UIApplication.shared.windows
        for window in windows {
            if window.windowLevel == .normal {
                return window
            }
        }
        return nil
    }
    
    public class func currentViewController() -> UIViewController? {
        guard let windowsRootViewController = CommonTools.applicationWindow()?.rootViewController else { return nil }
        var rootViewController: UIViewController? = windowsRootViewController
        if windowsRootViewController is UINavigationController {
            let naviVC = windowsRootViewController as? UINavigationController
            rootViewController = naviVC?.topViewController
        }
        // loop to trace the most top vc kind like recursion
        while rootViewController?.presentedViewController != nil {
            rootViewController = rootViewController?.presentedViewController
            if rootViewController is UINavigationController {
                let naviVC = rootViewController as? UINavigationController
                rootViewController = naviVC?.topViewController
            }
        }
        // if vc is preseting or dismissing
        while rootViewController?.isBeingDismissed ?? false || rootViewController?.navigationController?.isBeingDismissed ?? false {
            rootViewController = rootViewController?.presentingViewController
        }
//        while rootViewController?.isBeingPresented ?? false || rootViewController?.navigationController?.isBeingPresented ?? false {
//            rootViewController = rootViewController
//        }
        let naviVC = rootViewController as? UINavigationController
        if naviVC != nil {
            rootViewController = naviVC?.topViewController
        }
        return rootViewController
    }
}
