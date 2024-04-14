//
//  DetailsViewModel.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Domain

final class DetailsViewModel: ViewModel {
    
    private unowned var templatesRepository: TemplatesRepository
   
    init(templatesRepository: TemplatesRepository) {
        self.templatesRepository = templatesRepository
    }
}



