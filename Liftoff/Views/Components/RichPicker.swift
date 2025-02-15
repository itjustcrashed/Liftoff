//
//  RichPicker.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/20/25.
//

import SwiftUI

/// A picker with a horizontal carousel of labeled images.
struct RichPicker: View {
    var title: String
    var subtitle: String?
    @Binding var selection: String
    var options: [Option]

    init(
        _ title: String,
        subtitle: String? = nil,
        selection: Binding<String>,
        options: [Option]
    ) {
        self.title = title
        self.subtitle = subtitle
        self._selection = selection
        self.options = options
    }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                if let subtitle = subtitle {
                    Text(subtitle)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            ForEach(options) { option in
                VStack {
                    Image(option.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .roundedBorder(4, strokeColor: .outline, lineWidth: 1)
                        .padding(8)
                        .if(selection == option.value) { view in
                            view
                                .roundedBorder(10, strokeColor: .accent, lineWidth: 3)
                        }
                    Text(option.title)
                        .font(.caption)
                }
            }
        }
    }
    
    class Option: Identifiable {
        var title: String
        var image: ImageResource
        var value: String
        
        init(_ title: String, image: ImageResource, value: String) {
            self.title = title
            self.image = image
            self.value = value
        }
    }
}

typealias Option = RichPicker.Option
