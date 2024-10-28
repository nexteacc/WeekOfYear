//
//  MetricsManager.swift
//  WeekOfYear
//
//  Created by Sheng on 10/28/24.
//

import MetricKit

class MetricsManager: NSObject {
    static let shared = MetricsManager()
    
    override init() {
        super.init()
        MXMetricManager.shared.add(self)
    }
    
    func startCollecting() {
        
        MXMetricManager.shared.add(self)
    }
}

extension MetricsManager: MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        
        for payload in payloads {
            print("Received metric payload: \(payload)")
        }
    }
    
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        for payload in payloads {
            print("Received diagnostic payload: \(payload)")
        }
    }
}
