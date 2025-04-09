// Created for Umpa in 2025

public enum Subject: CaseIterable {
    case piano
    case composition
    case vocal
    case drum
    case bass
    case guitar
    case electronicMusic
    case windInstruments
    case classicalHarmony
    case sightSingingEarTraining
    case practicalHarmony
    case musicNotation
    case accompanist
    case musicCreation

    public var name: String {
        switch self {
        case .piano: "피아노"
        case .composition: "작곡"
        case .vocal: "보컬"
        case .drum: "드럼"
        case .bass: "베이스"
        case .guitar: "기타"
        case .electronicMusic: "전자음악"
        case .windInstruments: "관악"
        case .classicalHarmony: "전통화성학"
        case .sightSingingEarTraining: "시창청음"
        case .practicalHarmony: "실용화성학"
        case .musicNotation: "악보제작"
        case .accompanist: "반주자"
        case .musicCreation: "MR제작"
        }
    }
}
