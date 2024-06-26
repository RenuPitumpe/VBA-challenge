Attribute VB_Name = "Module1"
Sub QuarterData()

Dim ws As Worksheet
Dim ticker As String, TickerID As Integer
Dim DataCount As Long
Dim OpenPrice As Double, ClosePrice As Double
Dim QuaterlyChange As Double, PercentChange As Double, TotalVolume As Double

For Each ws In Worksheets

DataCount = ws.Cells(Rows.Count, 1).End(xlUp).Row

ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Quarterly Change"
ws.Cells(1, 11).Value = "Percentage Change"
ws.Cells(1, 12).Value = "Total Stock Volume"

TickerID = 1
TotalVolume = 0
ticker = ""

For i = 2 To DataCount
    
If ws.Cells(i, 1).Value = ticker Then
    TotalVolume = TotalVolume + ws.Cells(i, 7).Value
Else
    TickerID = TickerID + 1
    ticker = ws.Cells(i, 1).Value
    TotalVolume = 0 + ws.Cells(i, 7).Value
    OpenPrice = ws.Cells(i, 3).Value
End If

If ticker <> ws.Cells(i + 1, 1).Value Then
    ClosePrice = ws.Cells(i, 6).Value
    QuarterlyChange = ClosePrice - OpenPrice
    PercentChange = QuarterlyChange / OpenPrice
    PercentChange = Application.WorksheetFunction.RoundUp(PercentChange, 2)
    
    
    ws.Cells(TickerID, 9) = ticker
    ws.Cells(TickerID, 10) = QuarterlyChange
    ws.Cells(TickerID, 11) = PercentChange
    ws.Cells(TickerID, 12) = TotalVolume
    
    If QuarterlyChange > 0 Then
        ws.Cells(TickerID, 10).Interior.ColorIndex = 4
    ElseIf QuarterlyChange < 0 Then
        ws.Cells(TickerID, 10).Interior.ColorIndex = 3
        End If
End If
Next
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"

Dim MaxPrice As Double, MinPrice As Double, MaxTotal As Double
Dim MaxRow As Integer, MinRow As Integer, MaxTotRow As Integer
    
    MaxPrice = ws.Cells(2, 11).Value
    MaxRow = 2
    
    MinPrice = ws.Cells(2, 11).Value
    MinRow = 2
    
    MaxTotal = ws.Cells(2, 12).Value
    MaxTotRow = 2
    
    For i = 3 To DataCount
        If ws.Cells(i, 11).Value > MaxPrice Then
            MaxPrice = ws.Cells(i, 11).Value
            MaxRow = i
        End If
        
        If ws.Cells(i, 11).Value < MinPrice Then
            MinPrice = ws.Cells(i, 11).Value
            MinRow = i
        End If
        
        If ws.Cells(i, 12).Value > MaxTotal Then
            MaxTotal = ws.Cells(i, 12).Value
            MaxTotRow = i
        End If
    Next
    
    ws.Cells(2, 16).Value = ws.Cells(MaxRow, 9)
    ws.Cells(2, 17).NumberFormat = "0.00%"
    ws.Cells(2, 17).Value = ws.Cells(MaxRow, 11)
    
    ws.Cells(3, 16).Value = ws.Cells(MinRow, 9)
    ws.Cells(3, 17).NumberFormat = "0.00%"
    ws.Cells(3, 17).Value = ws.Cells(MinRow, 11)
    
    ws.Cells(4, 16) = ws.Cells(MaxTotRow, 9)
    ws.Cells(4, 17).NumberFormat = "0,000"
    ws.Cells(4, 17).Value = ws.Cells(MaxTotRow, 12)

    ws.Columns("A:Q").AutoFit
    
Next
End Sub
