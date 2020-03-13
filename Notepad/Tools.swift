//
//  Tools.swift
//  Notepad
//
//  Created by 王嘉宁 on 2020/3/13.
//  Copyright © 2020 王嘉宁. All rights reserved.
//

import Foundation


class Tools<T> {
    
    
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
