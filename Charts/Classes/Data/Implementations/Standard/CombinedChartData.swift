//
//  CombinedChartData.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 26/2/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation

public class CombinedChartData: BarLineScatterCandleBubbleChartData
{
    private var _lineData: LineChartData!
    private var _barData: BarChartData!
    private var _scatterData: ScatterChartData!
    private var _candleData: CandleChartData!
    private var _bubbleData: BubbleChartData!
    
    public override init()
    {
        super.init()
    }
    
    public override init(dataSets: [IChartDataSet]?)
    {
        super.init(dataSets: dataSets)
    }
    
    public var lineData: LineChartData!
    {
        get
        {
            return _lineData
        }
        set
        {
            _lineData = newValue
            for dataSet in newValue.dataSets
            {
                _dataSets.append(dataSet)
            }
            
            calcMinMax()
            calcYValueCount()
        }
    }
    
    public var barData: BarChartData!
    {
        get
        {
            return _barData
        }
        set
        {
            _barData = newValue
            for dataSet in newValue.dataSets
            {
                _dataSets.append(dataSet)
            }
            
            calcMinMax()
            calcYValueCount()
        }
    }
    
    public var scatterData: ScatterChartData!
    {
        get
        {
            return _scatterData
        }
        set
        {
            _scatterData = newValue
            for dataSet in newValue.dataSets
            {
                _dataSets.append(dataSet)
            }
            
            calcMinMax()
            calcYValueCount()
        }
    }
    
    public var candleData: CandleChartData!
    {
        get
        {
            return _candleData
        }
        set
        {
            _candleData = newValue
            for dataSet in newValue.dataSets
            {
                _dataSets.append(dataSet)
            }
            
            calcMinMax()
            calcYValueCount()
        }
    }
    
    public var bubbleData: BubbleChartData!
    {
        get
        {
            return _bubbleData
        }
        set
        {
            _bubbleData = newValue
            for dataSet in newValue.dataSets
            {
                _dataSets.append(dataSet)
            }
            
            calcMinMax()
            calcYValueCount()
        }
    }
    
    /// - returns: all data objects in row: line-bar-scatter-candle-bubble if not null.
    public var allData: [ChartData]
    {
        var data = [ChartData]()
        
        if lineData !== nil
        {
            data.append(lineData)
        }
        if barData !== nil
        {
            data.append(barData)
        }
        if scatterData !== nil
        {
            data.append(scatterData)
        }
        if candleData !== nil
        {
            data.append(candleData)
        }
        if bubbleData !== nil
        {
            data.append(bubbleData)
        }
        
        return data
    }
    
    public override func notifyDataChanged()
    {
        if (_lineData !== nil)
        {
            _lineData.notifyDataChanged()
        }
        if (_barData !== nil)
        {
            _barData.notifyDataChanged()
        }
        if (_scatterData !== nil)
        {
            _scatterData.notifyDataChanged()
        }
        if (_candleData !== nil)
        {
            _candleData.notifyDataChanged()
        }
        if (_bubbleData !== nil)
        {
            _bubbleData.notifyDataChanged()
        }
        
        super.notifyDataChanged() // recalculate everything
    }
    
    
    /// Get the Entry for a corresponding highlight object
    ///
    /// - parameter highlight:
    /// - returns: the entry that is highlighted
    public override func getEntryForHighlight(highlight: ChartHighlight) -> ChartDataEntry?
    {
        let dataObjects = allData
        
        if highlight.dataIndex >= dataObjects.count
        {
            return nil
        }
        
        let data = dataObjects[highlight.dataIndex]
        
        if highlight.dataSetIndex >= data.dataSetCount
        {
            return nil
        }
        else
        {
            // The value of the highlighted entry could be NaN - if we are not interested in highlighting a specific value.
            // FIXME: Implement on Android
            let entries = data.getDataSetByIndex(highlight.dataSetIndex).entriesForXPos(highlight.x)
            for e in entries
            {
                if e.y == highlight.y || isnan(highlight.y)
                {
                    return e
                }
            }
            
            return nil
        }
    }
}
