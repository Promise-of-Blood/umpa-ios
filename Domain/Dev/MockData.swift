// Created for Umpa in 2025

import Foundation

#if DEBUG
extension AccompanistService {
    public static let sample0 = AccompanistService(
        id: "accompanistService0",
        type: .accompanist,
        title: "반주자도 중요합니다",
        thumbnail: nil,
        rating: 3.5,
        author: .sample0,
        reviews: [],
        serviceDescription:
        """
        2022 년부터 입시 반주를 진행했습니다.
        많은 학생들과 입시장에 함께 들어갔고, 합격시킨 학생 정말 많습니다. 반주자의 중요성을 모르는 사람이 많은 것 같지만, 좋은 반주자와 함께 해야 좋은 연주가 나온답니다~!
        """,
        price: 160000,
        chargeDescription: nil,
        instruments: [
            Major(name: "피아노"),
        ],
        ensemblePolicy: EnsemblePolicy(freeCount: 2, price: 20000),
        isServingMusicRecorded: true,
        ensemblePlace: [.privateStudio, .studentPreference]
    )
}

extension Student {
    public static let sample0 = Student(
        id: "student0",
        userType: .student,
        major: Major(name: "피아노"),
        name: "윤재원",
        username: "재운피터팬",
        profileImage: nil,
        region: Region(
            regionalLocalGovernment: "경기도",
            basicLocalGovernment: BasicLocalGovernment(id: 114, name: "의정부시")
        ),
        gender: .male,
        grade: .사회인,
        dreamCollege: [
            Domain.College(name: "서울예술대학교"),
        ],
        subject: LessonSubject(name: "피아노"),
        availableLessonDays: [.sat, .sun],
        requirements: "피아노 다시 시작하고 싶어요. 10년 전에 배웠었는데 다시 시작하려고 합니다. 주말에 수업 가능한 선생님 찾습니다.",
        favoriteServices: [
            "lessonService0",
        ]
    )
}

extension Teacher {
    public static let sample0 = Teacher(
        id: "teacher0",
        userType: .teacher,
        major: Major(name: "피아노"),
        name: "조성진",
        profileImage: URL(string: "https://newsimg.hankookilbo.com/cms/articlerelease/2021/01/28/ce746895-10e3-4226-b841-9512ed90d746.jpg"),
        region: Region(
            regionalLocalGovernment: "서울",
            basicLocalGovernment: BasicLocalGovernment(id: 1, name: "강남구")
        ),
        gender: .male,
        isEvaluated: true,
        keyphrase: "피아노 잘 가르쳐요",
        introduction: "안녕하세요. 미스터초입니다.",
        experiences: [
            Experience(
                title: "2008 제6회 모스크바 국제 청소년 쇼팽 피아노 콩쿠르 1위 심사위원상 오케스트라 협연상 폴로네이즈 최고연주상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: true
            )!,
            Experience(
                title: "2009 제7회 일본 하마마쓰 국제 피아노 콩쿠르 1위",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: true
            )!,
            Experience(
                title: "2011 제14회 차이코프스키 국제 콩쿠르 피아노 부문 3위",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: true
            )!,
            Experience(
                title: "2011 제6회 대원음악상 신인상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "2014 제14회 아르투르 루빈스타인 콩쿠르 3위 실내악 최고연주상 주니어 심사위원상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "2015 제17회 쇼팽 국제 피아노 콩쿠르 1위 폴로네이즈 최고 연주상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "2019 제12회 대원음악상 대상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "2023 삼성호암상 예술상",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
        ],
        links: [
            URL(string: "https://www.youtube.com/watch?v=d3IKMiv8AHw"),
        ],
        myServices: []
    )

    public static let sample1 = Teacher(
        id: "teacher1",
        userType: .teacher,
        major: Major(name: "작곡"),
        name: "기면지",
        profileImage: nil,
        region: Region(
            regionalLocalGovernment: "서울시",
            basicLocalGovernment: BasicLocalGovernment(id: 1, name: "강남구")
        ),
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
            Experience(
                title: "서울예술대학교 작곡 전공 졸업",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: true
            )!,
            Experience(
                title: "동아방송대 작곡 전공 합격",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "호원대 베이스 전공 합격",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
            Experience(
                title: "전 LNS, SMMA 출강",
                startDate: YMDate(year: 2020, month: 1)!,
                endDate: YMDate(year: 2022, month: 1)!,
                isRepresentative: false
            )!,
        ],
        links: [],
        myServices: []
    )
}

extension ChatRoom {
    public static let sample0 = ChatRoom(
        id: "chatRoom0",
        student: .sample0,
        relatedService: LessonService.sample0.eraseToAnyService(),
        messages: [
            ChatMessage.sample0,
            ChatMessage.sample1,
            ChatMessage.sample2,
            ChatMessage.sample3,
            ChatMessage.sample4,
            ChatMessage.sample5,
            ChatMessage.sample6,
        ]
    )
}

extension ChatMessage {
    public static let sample0 = ChatMessage(
        id: "chatMessage0",
        created: .now,
        sender: .student,
        text: "안녕하세요 선생님!"
    )

    public static let sample1 = ChatMessage(
        id: "chatMessage1",
        created: .now,
        sender: .teacher,
        text: "안녕하세요 학생님!"
    )

    public static let sample2 = ChatMessage(
        id: "chatMessage2",
        created: .now,
        sender: .student,
        text: "오늘은 무슨 곡을 배우나요?"
    )

    public static let sample3 = ChatMessage(
        id: "chatMessage3",
        created: .now,
        sender: .teacher,
        text: "오늘은 스케일을 배워볼까요?"
    )

    public static let sample4 = ChatMessage(
        id: "chatMessage4",
        created: .now,
        sender: .student,
        text: "네 알겠습니다!"
    )

    public static let sample5 = ChatMessage(
        id: "chatMessage5",
        created: .now,
        sender: .teacher,
        text: "그럼 시작해볼까요?"
    )

    public static let sample6 = ChatMessage(
        id: "chatMessage6",
        created: .now,
        sender: .student,
        text: "네!"
    )
}

extension Review {
    public static let sample0 = Review(
        id: "review0",
        createdAt: .now,
        rating: Rating(amount: 5.0),
        writer: .sample0,
        content:
        """
        선생님한테 정말 많은 걸 배웠습니다.
        그냥 음악적인 지식 뿐만 아니라 연습하는 루틴까지 체크해주시고 열정적으로 알려주셨습니다.
        의지 박약인 저를 합격 할 수 있게 해주신 은인 이십니당..
        """,
        images: []
    )

    public static let sample1 = Review(
        id: "review1",
        createdAt: .now,
        rating: Rating(amount: 4.5),
        writer: .sample0,
        content:
        """
        개인 사정으로 잠깐 그만 두었지만 정말 좋은 선생님 이십니다.
        빡센 선생님 찾고 있었는데 정말 빡세게 알려주십니다.
        의지 박약인 사람한테 추천드려요
        """,
        images: []
    )
}

extension LessonService {
    public static let sample0 = LessonService(
        id: "lessonService0",
        type: .lesson,
        title: "가고싶은 학교 무조건 가는 방법",
        thumbnail: nil,
        rating: 5.0,
        author: .sample0,
        reviews: [
            .sample0,
            .sample1,
        ],
        serviceDescription:
        """
        기초적인 음악 이론부터 
        미디 큐베이스 프로툴 로직 에이블톤 활용등 실용음악적으로 곡 쓰기
        클래식적인 오케스트레이션
        힙합 R&B를 접목해 여러가지 리듬 접목해 곡쓰기
        발라드 동요 영상에 음악을 입히는 방법 

        Music in Music out 기법부터시작해
        기본적인 화성학 을 토대로전통화성학과 재즈화성학의 비슷한점을 찾고 그 차이점을 알아보고
        컴파운드 하모니를 이용한 새로운 사운드 만들기

        관악기나 현악에서만 쓰이는 보이싱을 이용해 피아노 보이싱 연구해보기 등
        관악에서는 피아노 보이싱에 대한 보이싱을 사용할수있는지 에 관한 레슨을 같이 해봅니다

        기존의 4마디패턴으로 곡쓰기 론도형식의 반복되는 음악에서 그 반대의 형식까지 
        음악에서 형식은 왜 중요하고 꼭 쓰지않아도 되는것인가
        제가 연구하고 가진 정보와 지식들을 모두 알려드립니다
        """,
        subject: Major(name: "피아노"),
        badges: [
            Badge(title: "학력 인증"),
            Badge(title: "시범 레슨 운영"),
        ],
        price: 100000,
        scheduleType: .byStudent,
        availableTimes: [],
        lessonStyle: .both,
        isAvailableOfflineCounseling: true,
        trialPolicy: .free,
        lessonTargets: [
            TargetStudent(description: "아무리 해도 기본기가 부족하다고 느껴지는 학생"),
            TargetStudent(description: "코드초견 어떻게 해야하는지 모르겠다 하는 학생"),
        ],
        studioImages: [],
        curriculum: [
            CurriculumItem(title: "1주차", description: "7th chord 2-5-1 A form B form"),
            CurriculumItem(title: "2주차", description: "Major Scale / Minor Scale"),
            CurriculumItem(title: "3주차", description: "ChordTone Solo"),
            CurriculumItem(title: "4주차", description: "Blues Scale"),
            CurriculumItem(title: "5주차", description: "Walking Bass"),
            CurriculumItem(title: "6주차", description: "Walking Bass + Comping"),
            CurriculumItem(title: "7주차", description: "Jazz Ballad"),
            CurriculumItem(title: "8주차", description: "Jazz Ballad 2"),
            CurriculumItem(title: "9주차", description: "Jazz Standard"),
            CurriculumItem(title: "10주차", description: "Jazz Standard 2"),
        ],
        status: .recruiting
    )
}

extension MusicCreationService {
    public static let sample0 = MusicCreationService(
        id: "musicCreationService0",
        type: .mrCreation,
        title: "엠알 제작 내가 최고",
        thumbnail: nil,
        rating: 4.0,
        author: .sample0,
        reviews: [],
        serviceDescription:
        """
        MR 제작합니다.

        최고 퀄리티 보장합니다.
        """,
        price: 100000,
        chargeDescription: "기본 2 트랙 (피아노 + 드럼) 기준. 트랙 추가시 각 트랙 별 20,000원 추가",
        tools: [
            MusicCreationTool(name: "에이블톤"),
        ],
        turnaround: Turnaround(
            minDate: UnitDate(amount: 1, unit: .week),
            maxDate: UnitDate(amount: 2, unit: .week)
        ),
        revisionPolicy: RevisionPolicy(freeCount: 1, price: 10000),

        sampleMusics: [
            SampleMusic(url: URL(string: "https://youtu.be/r6TwzSGYycM?si=BK53S-MP6U1HCaWP")),
        ]
    )
}

extension ScoreCreationService {
    public static let sample0 = ScoreCreationService(
        id: "compositionService0",
        type: .scoreCreation,
        title: "입시 악보 제작 합니다",
        thumbnail: nil,
        rating: 4.5,
        author: .sample0,
        reviews: [],
        serviceDescription:
        """
        입시 악보 제작 합니다

        악보 제작 경력 몇년입니다
        믿고 맡겨주세요
        업게 최고 빠른 작업 속도!
        짱 저렴한 가격~!
        """,
        basePrice: 20000,
        majors: [
            .vocal,
            .piano,
            .drum,
            .bass,
        ],
        revisionPolicy: RevisionPolicy(freeCount: 2, price: 5000),
        turnaround: Turnaround(
            minDate: UnitDate(amount: 3, unit: .day),
            maxDate: UnitDate(amount: 7, unit: .day)
        ),
        pricesByMajor: [
            PriceByMajor(price: 20000, major: .vocal),
            PriceByMajor(price: 40000, major: .piano),
            PriceByMajor(price: 20000, major: .drum),
            PriceByMajor(price: 30000, major: .bass),
        ],
        tools: [
            CompositionTool(name: "시벨리우스"),
        ],
        sampleSheets: [
            SampleSheet(url: URL(string: "https://www.musicscore.co.kr/sample/samp7ys7f3ij9wkjid8eujfhsiud843dsijfowejfisojf3490fi0if0sjk09jkr039uf90u/8u4ojsjdjf430foeid409ijef923jerojfgojdofj894jjdsf934f90f40ufj390rfjds/sample_102000/sample_Y3Zp6CqGi2024040332204.jpg")),
        ]
    )
}
#endif
