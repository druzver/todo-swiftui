//
//  CalendarScreen.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI
import domain


class ScrollViewHolder {
    var proxy: ScrollViewProxy?
    
    func scrollToToday() {
        proxy?.scrollTo(0,anchor: .top)
    }
}

struct CalendarScreen: View {
    
    @StateObject var viewModel: CalendarScreenViewModel
        
    private var proxyKeeper = ScrollViewHolder()
    
    init(viewModel: CalendarScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing:0) {
            NavBar(
                title: "Calendar",
                createText: "Today",
                isShowBackButton: false,
                onBack: {},
                onCreate: proxyKeeper.scrollToToday
            )
            
            
            ScrollView { ScrollViewReader { r in
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(viewModel.monthRange, id: \.self) { index in
                        MonthView(
                            model: viewModel.getItem(index: index),
                            onDaySelect: viewModel.selectDate
                        )
                        
                    }
                }
                .modifier(UpdatellProxyModifier(proxy: r, keeper: proxyKeeper))
                .onAppear() {
                    proxyKeeper.scrollToToday()
                }
            }}
        }
        
    }
}



struct UpdatellProxyModifier: ViewModifier {
    
    init(proxy: ScrollViewProxy, keeper: ScrollViewHolder) {
        keeper.proxy = proxy
    }
    
    func body(content: Content) -> some View {
        content
    }
    
}

