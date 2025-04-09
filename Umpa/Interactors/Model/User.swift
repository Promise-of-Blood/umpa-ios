// Created for Umpa in 2025

import Foundation

enum UserType {
    case student
    case teacher
}

enum Gender {
    case male
    case female
}

enum Grade {
    case 사회인
    case 대학생
    case 재수생
    // TODO: 기획 정해서 수정
}

protocol User: Identifiable, Hashable {
    typealias Id = String

    var id: Id { get }
    var userType: UserType { get }
    var major: Major { get }
    var name: String { get }
    var username: String { get }
    var profileImage: URL? { get }
    var region: Region { get }
    var gender: Gender { get }
}

struct Student: User {
    let id: Id
    let userType: UserType
    let major: Major
    let name: String
    let username: String
    let profileImage: URL?
    let region: Region
    let gender: Gender
    let grade: Grade
    let dreamCollege: [College]
    let subject: Subject
    let availableLessonDay: [WeekDay]
    let requirements: String // 자기소개 및 요청 사항
    let favoriteServices: [Service.Id]
}

struct Teacher: User {
    let id: Id
    let userType: UserType
    let major: Major
    let name: String
    let username: String
    let profileImage: URL?
    let region: Region
    let gender: Gender
    let isEvaluated: Bool
    /// 대표 문구
    let keyphrase: String
    /// 소개글
    let introduction: String
    /// 경력 사항
    let experiences: [String]
    /// 사이트 링크
    let links: [URL?]
    let myServices: [Service.Id]
}

#if MOCK
extension Student {
    static let sample0 = Student(
        id: "student0",
        userType: .student,
        major: Major(name: "피아노"),
        name: "윤재원",
        username: "재운피터팬",
        profileImage: nil,
        region: Region(regionalLocalGovernment: "경기도", basicLocalGovernment: "의정부시"),
        gender: .male,
        grade: .사회인,
        dreamCollege: [
            College(name: "서울예술대학교"),
        ],
        subject: .piano,
        availableLessonDay: [.sat, .sun],
        requirements: "피아노 다시 시작하고 싶어요. 10년 전에 배웠었는데 다시 시작하려고 합니다. 주말에 수업 가능한 선생님 찾습니다.",
        favoriteServices: [
            "lessonService0",
        ]
    )
}

extension Teacher {
    static let sample0 = Teacher(
        id: "teacher0",
        userType: .teacher,
        major: Major(name: "피아노"),
        name: "조성진",
        username: "미스터초",
        profileImage: URL(string: "https://newsimg.hankookilbo.com/cms/articlerelease/2021/01/28/ce746895-10e3-4226-b841-9512ed90d746.jpg"),
        region: Region(regionalLocalGovernment: "서울", basicLocalGovernment: "연남동"),
        gender: .male,
        isEvaluated: true,
        keyphrase: "피아노 잘 가르쳐요",
        introduction: "안녕하세요. 미스터초입니다.",
        experiences: [
            "2008 제6회 모스크바 국제 청소년 쇼팽 피아노 콩쿠르 1위 심사위원상 오케스트라 협연상 폴로네이즈 최고연주상",
            "2009 제7회 일본 하마마쓰 국제 피아노 콩쿠르 1위",
            "2011 제14회 차이코프스키 국제 콩쿠르 피아노 부문 3위",
            "2011 제6회 대원음악상 신인상",
            "2014 제14회 아르투르 루빈스타인 콩쿠르 3위 실내악 최고연주상 주니어 심사위원상",
            "2015 제17회 쇼팽 국제 피아노 콩쿠르 1위 폴로네이즈 최고 연주상",
            "2019 제12회 대원음악상 대상",
            "2023 삼성호암상 예술상",
        ],
        links: [
            URL(string: "https://www.youtube.com/watch?v=d3IKMiv8AHw"),
        ],
        myServices: []
    )

    static let sample1 = Teacher(
        id: "teacher1",
        userType: .teacher,
        major: Major(name: "composition"),
        name: "김현지",
        username: "면지",
        profileImage: nil,
        region: Region(regionalLocalGovernment: "서울시", basicLocalGovernment: "연남동"),
        gender: .female,
        isEvaluated: true,
        keyphrase:
        """
        서울예대 동아방송대를 작곡으로 붙고
        호원대를 베이스로 붙은 사람
        """,
        introduction:
        """
        저는 세상에서 제일 게으른 사람입니다.
        근데 너네는 힝꾸 없잖아. 어쩔티비 알파카좋아 오리너구리도 좋아 담배는 맛있어 오늘 뭐먹지 쓰레기버리러 나가기 귀찮다.

        음 그래서 저한테 레슨을 받으신다면 최선을 다해 가르쳐드리겠습니다.
        아무튼 그렇습니다. 게으르긴 하지만 책임감은 있는 편이라서 돈 받은 값은 합니다.
        네네치킨 
        """,
        experiences: [
            "서울예술대학교 작곡 전공 졸업",
            "동아방송대 작곡 전공 합격",
            "호원대 베이스 전공 합격",
            "전 LNS, SMMA 출강",
        ],
        links: [],
        myServices: []
    )
}
#endif
